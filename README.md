
# INSTALLATION

Until we release this capability more broadly in the default Jupyter environment:

```
wget "https://github.com/SD2E/sd2e-jupyter-ascending/archive/0.1.0.tar.gz"
tar xf 0.1.0.tar.gz
cd sd2e-jupyter-ascending-0.1.0/
make install-user
hash -r

sd2e-jupyter usage

usage: sd2e-jupyter command options

  sd2e-jupyter show : Show details about your Notebook Server
  sd2e-jupyter start -n NAME -e EMAIL -d DURATION --archive : Launch a Notebook Server
  sd2e-jupyter stop <Session ID> : Shut down your Notebook Server

Version: 0.1.0 | Get help at support@sd2e.org

```

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
