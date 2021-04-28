# MyFirstTask
Creating a NIDS using snort which replays its alerts in a syslog server

I am running my syslog server as host 

Steps :
for the server :

> sudo docker run --privileged -it -P --rm --net=host mysyslogserver /bin/bash

> sudo service rsyslog restart
  
  
  
for the client :

> sudo docker run --privileged -it --rm --net=host myclientsys /bin/bash

> snort -i wlp6s0 -s -c /etc/snort/etc/snort.conf -A fast     (I use wifi, if using Ethernet ,use ifconfig to check your enps)

Open 2nd container to create the alert:

> sudo docker run -it --rm --net=host myclientsys /bin/bash

> wget 8.8.8.8:23456/malicious.exe   (we want the destination port to be 23456)

we can close the 2nd container whenever we want

In the first container again

> sudo service rsyslog restart

> logger -n 127.0.0.1 -f alert -P 514
    
We will find the alert in our /var/log/messages or /var/log/syslog file on the server.
 
you can create a parser in the server to simple print the syslog file with the following process.

> touch myparser.py
> chmod +x myparser.py
> vim my parser   (and then paste the following code)

f = open("/var/log/messages", "r")
print(f.read()) 
 
> /.myparser.py 
 
 
 you can pull my docker images from here:
 server :https://hub.docker.com/r/stavroslir/mysyslogserver
 client :https://hub.docker.com/r/stavroslir/mysyslogclient

