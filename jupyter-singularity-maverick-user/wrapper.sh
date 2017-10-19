#!/bin/bash

EMAIL_ADDRESS=${email}
SESSION_FILE="$STOCKYARD/delete_me_to_end_session"

# make sure the Python and Singularity modules are loaded
ml TACC
ml python
ml tacc-singularity

# create password
export PASSWORD=`date | md5sum | cut -c-32`

# run notebook in background
LOCAL_IPY_PORT=8888
nohup singularity run ${containerImage} &
IPYTHON_PID=$!

# use ssh for port forwarding
# echo Using ssh for port forwarding
IPY_PORT_PREFIX=2
NODE_HOSTNAME_PREFIX=`hostname -s`
NODE_HOSTNAME_DOMAIN=`hostname -d`
NODE_HOSTNAME_LONG=`hostname -f`
LOGIN_IPY_PORT="$((49+$IPY_PORT_PREFIX))`echo $NODE_HOSTNAME_PREFIX | perl -ne 'print $1.$2.$3 if /c\d\d(\d)-(\d)\d(\d)/;'`"

for i in `seq 3`; do
    ssh -f -g -N -R $LOGIN_IPY_PORT:$NODE_HOSTNAME_LONG:$LOCAL_IPY_PORT login$i
done

# send email notification
echo Your notebook is now running at http://$NODE_HOSTNAME_DOMAIN:$LOGIN_IPY_PORT with the password $PASSWORD | mailx -s "Jupyter notebook now running" $EMAIL_ADDRESS

# use file to kill job if necessary. This is TACC specific right now.
echo $NODE_HOSTNAME_LONG $IPYTHON_PID > $SESSION_FILE
while [ -f $SESSION_FILE ] ; do
    sleep 10
done
