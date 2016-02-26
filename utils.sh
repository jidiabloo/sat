#!/bin/bash

######################################################################
##### if the terminal is avaliable
######################################################################
if tty 1>/dev/null 2>&1; then
    TerminalBool=1
else
    TerminalBool=0
fi


function check_tools_installed
{
    ErrorCode=63
    ! [ -f "/usr/bin/expect" ] && CerrInfo "please install expect" && exit ${ErrorCode} || ((--ErrorCode))
    ! [ -f "/usr/bin/sshpass" ] && CerrInfo "please install sshpass" && exit ${ErrorCode} || ((--ErrorCode))
    return 0
}


function clean_known_hosts
{
    [ $# != 1] && echo "Error: the amount of parameter is not correct !"

    PhoneAddr=$1
    ssh-keygen -f "${HOME}/.ssh/known_hosts" -R ${PhoneAddr}

    [ $? != 0 ] && echo "Error: problem during clean all the know_hosts"
}

function ssh_run
{
    

    [ $# != 1] && echo "Error: the amount of parameter is not correct !"
    
    instruction=$1
    sshpass -p "${LoginPawd}" ssh -o StrictHostKeyChecking=no "${LoginUser}@${PhoneAddr}" "$instruction"
    #TODO: add error handling here
}

######################################################################
##### function：CerrInfo
##### output the message to stderr, along with pid and time information 
#####       
##### input：$@
#####       The message will be outputed
######################################################################
function CerrInfo
{
    if [ 1 -eq ${TerminalBool} ]; then
        printf "\033[0;31;40m[%05d][%s]\033[0m : " "$$" "$(date '+%F %T')" >/dev/tty
        echo "$@" >/dev/tty
    else
        printf "[%05d][%s] : " "$$" "$(date '+%F %T')" >&2
        echo "$@" >&2
    fi
}




