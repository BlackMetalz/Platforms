salt group-minion-id* cmd.run "sed -i 's/minion-id/minion-idnew/g' /etc/salt/minion_id && service salt-minion restart"
salt-key -d group-minion-id* -y
salt-key -A -y ( have to wait )
