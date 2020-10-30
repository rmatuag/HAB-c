#!/bin/bash

domain="getafix.tk"
DEPTFILE="a-dept.csv"

while read -r line; do 
	IFS=','
	[[ -n "$line" && "$line" == [[:blank:]#]* ]] && continue
	read -r -a array <<< "$line"
	base="${array[0]}"
    org="${array[1]}"
	if [[ $base -eq 0 ]] 
	then
		echo "createHABGroup $org MyHABOU zimbra@getafix.tk" > create_hab.zmp
	fi
	echo "chabg $org MyHAB $org@$domain memberURL 'ldap:///??sub?(&(objectClass=zimbraAccount)(zimbraAccountStatus=active)(ou=$org))' zimbraIsACLGroup FALSE" >> create_hab.zmp
done < $DEPTFILE

while read -r line; do
	IFS=','
	[[ -n "$line" && "$line" == [[:blank:]#]* ]] && continue
	read -r -a array <<< "$line"
	base="${array[0]}"
    org="${array[1]}"
    if [[ $base -eq 0 ]] 
    then
        root=$org
    elif [[ $base -eq 1 ]]
    then
        echo "addHABGroupMember $root $org" >> create_hab.zmp
        nroot=$org
    else
        echo "addHABGroupMember $nroot $org" >> create_hab.zmp
    fi
done < $DEPTFILE
