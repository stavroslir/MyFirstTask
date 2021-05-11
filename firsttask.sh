#!/bin/sh


syslogserver(){

gnome-terminal -e 'sudo docker run --privileged -it -P --rm --net=host stavroslir/mysyslogserver /bin/bash -c "
cd /var/log && ./myshellscript.sh " '

}

syslogclient1(){

    gnome-terminal -e 'sudo docker run -it --privileged --rm --net=host finalcl  /bin/bash -c "cd /var/log/snort && ./secclient.sh"'
}

syslogclient2(){ 

    gnome-terminal -e 'sudo docker run -it --privileged --rm --net=host finalcl   /bin/bash -c "cd /var/log/snort && ./myshellscript.sh "'
}

syslogserver
syslogclient1
syslogclient2
