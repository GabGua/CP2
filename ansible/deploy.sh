#Lanzamos la ejecución de todos los playbooks
#! /bin/sh
for i in $(ls|grep setup)
do
	echo "Running " $i " playbook"
    ansible-playbook $i
done