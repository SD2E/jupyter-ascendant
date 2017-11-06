# jupyter-hpc

## Purpose and Usage

This program helps you launch and manage a powerful Jupyter Notebook running on a full node of TACC's [Maverick][6] analytics cluster. Each Maverick node has twin 10-core Intel Xeon E5-2680 v2 Ivy Bridge, 256 GB RAM, and a Tesla K40 GPU, and is attached to TACC's Stockyard global WORK filesystem. 

Once installed, you can launch notebook using `jupyter-hpc start` as described below. You will get an email at your email address on file with your TACC user account when the server is ready. You can check the status of your server with `jupyter-hpc show` and shut it down before its default maximum duration of 8 hours in order to conserve resources. 

Your environment will be as close as possible to the one provided in the Jupyter Hub environment. Its capabilities are documented at the [Github repo for the SD2E base image][7].

## Installation of SD2E Jupyter Hub

Until we release this capability more broadly in the SD2E Jupyter environment:

In your **Jupyter Terminal**

```
wget -q "https://github.com/SD2E/jupyter-ascendant/archive/0.1.1.tar.gz"
tar xf 0.1.1.tar.gz
cd jupyter-hpc-ascending-0.1.1
make install-user
hash -r

jupyter-hpc usage

usage: jupyter-hpc command options

  jupyter-hpc show : Show details about your Notebook Server
  jupyter-hpc start -n NAME -e EMAIL -d DURATION --archive : Launch a Notebook Server
  jupyter-hpc stop <Session ID> : Shut down your Notebook Server

Version: 0.2.0 | Get help at support@sd2e.org

```

Please note this will not be persistent beyond the current SD2E Jupyter Notebook Server session. You can copy the `jupyter-hpc` code from `/home/jupyter/bin` to anywhere you wish on `/home/jupyter/tacc-work` and point your `$PATH` at it to enable persistent installation. 

## Local installation

If you want to install and run this locally (i.e. not in a Jupyter environment) so you can
launch SD2E notebooks from anywhere, you can follow these same commands on a local UNIX-
compatible system. 

You will also need to install:

1. The [SD2E CLI][1]
2. You will also need to configure SD2E CLI as follows:
    * [Create an API Client][4]
    * [Authorize with the SD2E Tenant][5]
2. [jq JSON parser][2]
3. [bashids][3] for generating short unique IDs

[1]: https://sd2e.github.io/api-user-guide/docs/install_cli.html
[2]: https://stedolan.github.io/jq/
[3]: https://github.com/benwilber/bashids
[4]: https://sd2e.github.io/api-user-guide/docs/create_client.html
[5]: https://sd2e.github.io/api-user-guide/docs/authorization.html
[6]: https://www.tacc.utexas.edu/systems/maverick
[7]: https://github.com/SD2E/jupyteruser-sd2e#jupyter-hpc-notebook-environment
