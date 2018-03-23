#!/bin/sh

# Set inventory according to plugin, else default to /etc/ansible/hosts
if [ "${PLUGIN_INVENTORY}" ];
then
  inventory=${PLUGIN_INVENTORY};
else
  inventory=/etc/ansible/hosts;
fi

# Set tags accordingly to plugin, else default to all (equivalent to no tags)
if [ "${PLUGIN_TAGS}" ];
then
  tags=${PLUGIN_TAGS};
else
  tags=all;
fi

# Install requirements from galaxy if wanted
if [ "${PLUGIN_GALAXY_REQUIREMENTS}" ];
then
    ansible-galaxy install -r ${PLUGIN_GALAXY_REQUIREMENTS} -f
fi


echo ${PLUGIN_SSH_PRIVATE_KEY} > /tmp/ansible.pem

ansible-playbook ${PLUGIN_PLAYBOOK} \
    --private-key /tmp/ansible.pem \
    -i $inventory \
    -t $tags \
    -e '__drone_commit_tag=${DRONE_TAG}' \
    -e '__drone_commit_sha=${DRONE_COMMIT_SHA}'

