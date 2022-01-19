Creating a NIDS using snort which replays its alerts in a syslog server

I am running my syslog server as host 

Steps :
for the server :

> sudo docker run --privileged -it -P --rm --net=host stavroslir/mysyslogserver /bin/bash

> sudo service rsyslog restart
  
  
  
for the client :

> sudo docker run -it --privileged --rm -P --net=host stavroslir/myclient   /bin/bash

> snort -i wlp6s0 -s -c /etc/snort/etc/snort.conf -A fast     (I use wifi, if using Ethernet ,use ifconfig to check your enps)

Open 2nd container to create the alert:

> sudo docker run -it --rm --net=host myclientsys /bin/bash

> wget 8.8.8.8:23456/malicious.exe   (we want the destination port to be 23456)

we can close the 2nd container whenever we want

In the first container again

> sudo service rsyslog restart

> logger -n 127.0.0.1 -f alert -P 514


    
We will find the alert in our /var/log/messages or /var/log/messages file on the server.
 
> tail -f messages
 
 
 you can pull my docker images from here:
 server :https://hub.docker.com/r/stavroslir/mysyslogserver
 client :https://hub.docker.com/r/stavroslir/myclient


UPDATED!!

I have created 3 bash scripts ,one for each container that when you run them,it does automatically the job for you.
You can run them on your own with the following steps:


For the server:
> cd /var/log
 

> ./myshellscript.sh

For the client:
>cd /var/log/snort

>./myshellscript.sh   

and for the 2nd client that creates the traffic:
>cd /var/log/snort

>./secclient.sh


NOTE!
You should make the Server do the restart first ,or this might not work!

You can run the bash script i have uploaded ,the whole process gets done automatically.






