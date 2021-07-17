#! /bin/sh

#Lanzamos la ejecución de todos los libros
ansible-playbook setup_master_node.yaml  --private-key ../.ssh/id_rsa  && ansible-playbook setup_worker_nodes.yaml --private-key ../.ssh/id_rsa && ansible-playbook setup_nfs-server.yaml --private-key ../.ssh/id_rsa #&& ansible-playbook setup_k8sdashboard.yaml
