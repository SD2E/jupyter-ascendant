#!/bin/bash

EMAIL_ADDRESS=${email}
# Needs to be threadsafe to allow multiple 
# notebook jobs to be in flight or active
SESSION_FILE="$STOCKYARD/delete_me_to_end_session.${AGAVE_JOB_ID}"

_AGAVE_CLIENT="$STOCKYARD/.sd2e.agave.current"
_AGAVE_AUTH="$HOME/.agave"

# make sure the Python and Singularity modules are loaded
ml TACC
ml python
ml tacc-singularity

# Boostrap TACC Cloud client config from hub or sd2e-cli
if [ -e "${_AGAVE_CLIENT}" ]
then
    mkdir -p "${_AGAVE_AUTH}"
    if [ ! -e "${_AGAVE_AUTH}/current" ]
    then
        echo "API Client not found. Installing one..."
        cp "${_AGAVE_CLIENT}" "${_AGAVE_AUTH}/current"
    # Install client if it's newer than one we detect
    elif test "${_AGAVE_CLIENT}" -nt "${_AGAVE_AUTH}/current"
    then
        echo "Existing API client older than session. Installing newer..."
        cp "${_AGAVE_CLIENT}" "${_AGAVE_AUTH}/current"
    fi
fi

# Create a strong password
export PASSWORD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c32`

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
ftmp=$(mktemp)

cat << EOM > ${ftmp}
Your HPC-enabled Jupyter Notebook is now availabe for use.

Access it at http://maverick.tacc.utexas.edu:$LOGIN_IPY_PORT
Your notebook password is: $PASSWORD

Get help at support@sd2e.org

EOM

mailx -s "Your SD2E Jupyter Notebook is now available" "$EMAIL_ADDRESS" < ${ftmp} && \
rm -f ${ftmp}

# use file to kill job if necessary. This is TACC specific right now.
echo $NODE_HOSTNAME_LONG $IPYTHON_PID > $SESSION_FILE
while [ -f $SESSION_FILE ] ; do
    sleep 10
done

