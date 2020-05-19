Exercise 3: Linux problem solving
Please connect with a ssh client to the following machine as mentioned in the intro using you
SSH key you provided to us.
We have an issue with redis on this machine. It's not starting. Please diagnose and solve the
issue.
Please deliver:
● A short description of your troubleshooting process.
● Tell us what's wrong
● Explain what you did to fix it
We will validate the machine and check if redis is running now.




Troubleshooting & Solution:

I have checked status of the redis service and found following causes blocking the service to be running
	sudo systemctl status redis
Then two causes found 
	1.start-limit-hit
	2.Failed to start Advanced key-value store
	
For further information log file was analysed and found a workaround to resolve the causes
	The start-limit-hit occured due to low ulimit set so that Redis could't set maximum open files to 10032
---------------------------------------------------------------------------------------------------------------
	
1.To resolve start-limit-hit error  for  below configuration files were required to be modified 
	/etc/systemd/system.conf
	/etc/security/limits.conf
	/etc/pam.d/common-session
	/etc/pam.d/common-session-noninteractive
	/etc/rc.local
	/etc/sysctl.conf
	
1.1 So , the original configuration files were backed up under /home/stylelabs/backup_conf

cp -p /etc/systemd/system.conf /home/stylelabs/backup_conf/system.conf_bkp
cp -p /etc/security/limits.conf /home/stylelabs/backup_conf/limits.conf_bkp
cp -p /etc/pam.d/common-session /home/stylelabs/backup_conf/common-session_bkp
cp -p /etc/pam.d/common-session-noninteractive /home/stylelabs/backup_conf/common-session-noninteractive_bkp
cp -p /etc/rc.local /home/stylelabs/backup_conf/rc.local_bkp
cp -p /etc/sysctl.conf /home/stylelabs/backup_conf/sysctl.conf_bkp

1.2 The required changes as below has been done in the mentioned configuration files

added below attribute to /etc/systemd/system.conf
DefaultLimitNOFILE=65536

added below attributes to /etc/security/limits.conf
*    soft nofile 64000
*    hard nofile 64000
root soft nofile 64000
root hard nofile 64000

Added below line to /etc/pam.d/common-session
session required pam_limits.so

Added below attribute to /etc/pam.d/common-session-noninteractive
session required pam_limits.so

Added below attributes to /etc/rc.local
sysctl -w net.core.somaxconn=65535
echo never > /sys/kernel/mm/transparent_hugepage/enabled

Edited /etc/sysctl.conf and added below value
vm.overcommit_memory = 1




-------------------------------------------------------------------------------------------------------

2. To resolve "Failed to start Advanced key-value store",
	2.1 /etc/redis/redis.conf file was analysed and corrected log path of redis service from /var/log/redis-servvice.log to /var/log/redis/redis-servvice.log
	2.2 /etc/systemd/system/redis.service file was analysed and noticed the PID mapping to /var/run/redis/redis-server.pid was missing. 
		Hence the attribute ExecStartPost=/bin/sh -c "echo $MAINPID > /var/run/redis/redis-server.pid has been added to /etc/redis/redis.conf

Now redis service is upand running

