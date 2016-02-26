#!/bin/bash

function Main
{

    linuxcasework=$1
    #package the test case
    (
        cd "${linuxcasework}"
        tar -cvzf "${linuxcasework}/${phonecaseroot}.tar.gz" "${phonecaseroot}" 1>/dev/null
    )
}


function deploy_case
{
    ssh-keygen -f "${HOME}/.ssh/known_hosts" -R ${PhoneAddr}

    
}


Main "$@"
