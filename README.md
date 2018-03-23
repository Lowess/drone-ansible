# drone-ansible

Use the Drone plugin to provision with ansible.
The following parameters are used to configure this plugin:

* `inventory` - Define the inventory file (mandatory)
* `playbook` - Define the playbook file (mandatory)
* `ssh_private_key` - Define the ssh-key to use for connecting to hosts
---
* `tags` - Define a comma separated list of tags to execute (optional)
* `galaxy_requirements` - Define the path to the `requirements.yml` file in order to install Ansible Galaxy requirements before running the playbook (optional)

The following is a sample configuration in your .drone.yml file:

```yaml
pipeline:
  deploy:
    image: Lowess/drone-ansible
    inventory: path/to/inventory
    playbook: web.yml
    secrets: [ plugin_ssh_private_key ]
```

```yaml
pipeline:
  deploy:
    image: Lowess/drone-ansible
    inventory: path/to/inventory
    playbook: web.yml
    galaxy_requirements: path/to/requirements.yml
    secrets: [ plugin_ssh_private_key ]
```
To add the ssh key use drone secrets via the cli

```
drone secret add \
  -repository user/repo \
  -image Lowess/drone-ansible \
  -name ssh_private_key \
  -value @path/to/.ssh/id_rsa
```

Exposed Drone variables to Ansible (using extra_vars) which can be used in any playbook:

```
__drone_commit_tag -> DRONE_TAG
__drone_commit_sha -> DRONE_COMMIT_SHA
```


## Docker

Build the docker image with the following commands:

```
docker build --rm -t Lowess/drone-ansible .
```

## Local usage

Execute from a project directory:

```
docker run --rm  \
  -e PLUGIN_INVENTORY=/ansible/inventory \
  -e PLUGIN_PLAYBOOK=/ansible/nginx.yml \
  -e PLUGIN_TAGS=web \
  -e PLUGIN_SSH_PRIVATE_KEY='...' \
  -e PLUGIN_GALAXY_REQUIREMENTS=/ansible/requirements.yml \
  -e DRONE_TAG=v0.0.9 \
  -v $(pwd):/drone/src/github.com/username/test \
  -w /drone/src/github.com/username/test \
  drone-ansible:latest
```


