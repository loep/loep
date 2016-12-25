#! /bin/bash
# Programming and idea by : E2MA3N [Iman Homayouni]
# Github : https://github.com/loep
# Email : e2ma3n@Gmail.com
# Website : http://Loep.ir
# Documentation : https://Loep.github.io
# License : GPL v3.0
# loep v1.0 [ Monitoring linux events and resources ]

# check root privilege
[ "`whoami`" != "root" ] && echo '[-] Please use root user or sudo' && exit 1

# help function
function help_f {
	echo 'Usage: '
	echo '	sudo ./install.sh -i [install program]'
	echo '	sudo ./install.sh -u [help to uninstall program]'
	echo '	sudo ./install.sh -c [check dependencies]'
}

# uninstall program from system
function uninstall_f {
	echo 'For uninstall program:'
	echo '	sudo rm -rf /opt/loep_v1.0'
	echo '	sudo rm -f /YOUR-WEB-SERVER-ADDRESS/loep-dir/'
	echo '	remove loep scripts from /etc/crontab'
}

# check dependencies in system
function check_f {
	echo '[+] check dependencies in system:  '
	for program in whoami grep free users df cut cat tr tac head tail wc rev date cp sleep expr ifconfig ping curl wget bc iostat sort unzip uptime sed
	do
		if [ ! -z `which $program 2> /dev/null` ] ; then
			echo "[+] $program found"
		else
			echo "[-] Error: $program not found"
		fi
		sleep 0.5
	done
}

# install program in system
function install_f {
	reset
	# print header
	echo '[+] ---------------------------------------------------------------------------------------------------------------------- [+]'
	sleep 1.5
	echo '[+] Loep v1.0 [ Monitoring Linux Events and Resources ]'

	sleep 1.5
	echo '[+] Programming and idea by : E2MA3N [Iman Homayouni]'

	sleep 1.5
	echo '[+] http://www.Loep.ir'

	sleep 1.5
	echo '[+] Tested on all popular linux distributions such as debian 7, debian 8, CentOS 6 and CentOS 7'

	sleep 2.5
	echo -en '[+] Press enter for continue or press ctrl+c for exit' ; read
	sleep 4

	# Create main directory
	echo '[+]'
	echo -en '[+] Create main directory : '
	[ ! -d /opt/loep_v1.0/ ] && mkdir -p /opt/loep_v1.0/ && echo 'done' || echo 'error ! /opt/loep_v1.0/ exists'
	sleep 1

	# Create html directory
	echo -en '[+] Create html directory : '
	[ ! -d /opt/loep_v1.0/html ] && mkdir -p /opt/loep_v1.0/html && echo 'done' || echo 'error ! /opt/loep_v1.0/html exists'
	sleep 1

	# Create conf directory
	echo -en '[+] Create conf directory : '
	[ ! -d /opt/loep_v1.0/conf ] && mkdir -p /opt/loep_v1.0/conf && echo 'done' || echo 'error ! /opt/loep_v1.0/conf exists'
	echo '[+]'
	sleep 1

	# Insert web server directory
	for (( ;; )) ; do
		echo '[+] Enter web server directory. For example : /var/www/html/loep'
		sleep 3
		echo -en '[+] Enter address: ' ; read www
		echo -en "[+] Web server directory is $www. Are you sure ? [y/n]: " ; read question
		if [ "$question" = "y" ] ; then
			echo '[+]'
			break
		else
			echo '[+]'
		fi
	done

	# Create general.conf
	echo -en '[+] Create general.conf : '
	if [ -f /opt/loep_v1.0/conf/general.conf ] ; then
		echo 'error ! /opt/loep_v1.0/conf/general.conf exists'
	else
		echo '# Programming and idea by : E2MA3N [Iman Homayouni]
# Github : https://github.com/loep
# Email : e2ma3n@Gmail.com
# Website : http://Loep.ir
# License : GPL v3.0
# Loep v1.0 [ Monitoring Linux Events and Resources ]
#
# Dont change this form, just change time or log address
grep number of ssh login in log file = 72
grep number of su login in log file = 72
grep number of ssh attack in log file = 72
grep number of console login in log file = 72
grep number of lines in tinyproxy log file = 72
update "Dashboard" page after = 300 second
update "Network Heartbeat" page after = 180 second
update "Bandwidth Usage" page after = 60 second
update "Servers Resources" page after = 60 second
update "Authentication Logs" page after = 360 second
update "SSH Service" page after = 480 second
update "Tinyproxy Service" page after = 600 second
		' > /opt/loep_v1.0/conf/general.conf
		echo "web server directory = $www" >> /opt/loep_v1.0/conf/general.conf
		chmod 644 /opt/loep_v1.0/conf/general.conf
		echo 'done'
	fi
	sleep 1

	# Create heartbeat.conf
	echo -en '[+] Create heartbeat.conf : '
	if [ -f /opt/loep_v1.0/conf/heartbeat.conf ] ; then
		echo 'error ! /opt/loep_v1.0/conf/heartbeat.conf exists'
	else
		echo '# Programming and idea by : E2MA3N [Iman Homayouni]
# Github : https://github.com/loep
# Email : e2ma3n@Gmail.com
# Website : http://Loep.ir
# License : GPL v3.0
# Loep v1.0 [ Monitoring Linux Events and Resources ]
#
# Network heartbeat config file
# ip_address server_name
# Insert your ipv4 below this line
192.168.1.1 ADSL Modem
8.8.8.8 google dns server' > /opt/loep_v1.0/conf/heartbeat.conf
		chmod 644 /opt/loep_v1.0/conf/heartbeat.conf
		echo 'done'
	fi
	sleep 1

	# Create interface.conf
	echo -en '[+] Create interface.conf : '
	if [ -f /opt/loep_v1.0/conf/interface.conf ] ; then
		echo 'error ! /opt/loep_v1.0/conf/interface.conf exists'
	else
		echo '# Programming and idea by : E2MA3N [Iman Homayouni]
# Github : https://github.com/loep
# Email : e2ma3n@Gmail.com
# Website : http://Loep.ir
# License : GPL v3.0
# Loep v1.0 [ Monitoring Linux Events and Resources ]
#
# Network heartbeat config file
# interface eternet 1
# Insert your interfaces below this line
eth0 ethernet 01' > /opt/loep_v1.0/conf/interface.conf
		chmod 644 /opt/loep_v1.0/conf/interface.conf
		echo 'done'
	fi
	sleep 1

	echo '[+]'
	# Copy authentication.sh
	echo -en '[+] Copy authentication.sh : '
	[ ! -f /opt/loep_v1.0/authentication.sh ] && cp authentication.sh /opt/loep_v1.0/ && chmod 755 /opt/loep_v1.0/authentication.sh && echo 'done' || echo 'error ! /opt/loep_v1.0/authentication.sh exists'
	sleep 1

	# Copy bandwidth.sh
	echo -en '[+] Copy bandwidth.sh : '
	[ ! -f /opt/loep_v1.0/bandwidth.sh ] && cp bandwidth.sh /opt/loep_v1.0/ && chmod 755 /opt/loep_v1.0/bandwidth.sh && echo 'done' || echo 'error ! /opt/loep_v1.0/bandwidth.sh exists'
	sleep 1

	# Copy heartbeat.sh
	echo -en '[+] Copy heartbeat.sh : '
	[ ! -f /opt/loep_v1.0/heartbeat.sh ] && cp heartbeat.sh /opt/loep_v1.0/ && chmod 755 /opt/loep_v1.0/heartbeat.sh && echo 'done' || echo 'error ! /opt/loep_v1.0/heartbeat.sh exists'
	sleep 1

	# Copy index.sh
	echo -en '[+] Copy index.sh : ' 
	[ ! -f /opt/loep_v1.0/index.sh ] && cp index.sh /opt/loep_v1.0/ && chmod 755 /opt/loep_v1.0/index.sh && echo 'done' || echo 'error ! /opt/loep_v1.0/index.sh exists'
	sleep 1

	# Copy resources.sh
	echo -en '[+] Copy resources.sh : '
	[ ! -f /opt/loep_v1.0/resources.sh ] && cp resources.sh /opt/loep_v1.0/ && chmod 755 /opt/loep_v1.0/resources.sh && echo 'done' || echo 'error ! /opt/loep_v1.0/resources.sh exists'
	sleep 1

	# Copy ssh-service.sh
	echo -en '[+] Copy ssh-service.sh : '
	[ ! -f /opt/loep_v1.0/ssh-service.sh ] && cp ssh-service.sh /opt/loep_v1.0/ && chmod 755 /opt/loep_v1.0/ssh-service.sh && echo 'done' || echo 'error ! /opt/loep_v1.0/ssh-service.sh exists'
	sleep 1

	# Copy tinyproxy.sh
	echo -en '[+] Copy tinyproxy.sh : '
	[ ! -f /opt/loep_v1.0/tinyproxy.sh ] && cp tinyproxy.sh /opt/loep_v1.0/ && chmod 755 /opt/loep_v1.0/tinyproxy.sh && echo 'done' || echo 'error ! /opt/loep_v1.0/tinyproxy.sh exists'
	echo '[+]'
	sleep 3

	if [ ! -d $www ] ; then
		mkdir -p $www
	fi

	# Create about.html
	sleep 1
	echo -en '[+] Create about.html : '
	echo '<!-- Programming and idea by : E2MA3N [Iman Homayouni] -->
		<!-- Gitbub : https://github.com/loep -->
		<!-- Email : e2ma3n@Gmail.com -->
		<!-- Website : http://Loep.ir -->
		<!-- License : GPL v3.0 -->
		<!-- CSS and html templates by http://startbootstrap.com/ -->
		<!-- Loep v1.0 [ Monitoring Linux Events and Resources ] -->
		<!DOCTYPE html>
		<html lang="en">
		<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>Loep v1.0 [ Monitoring Linux Events and Resources ]</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/sb-admin.css" rel="stylesheet">
		<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		</head>
		<body>
		<div id="wrapper">
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
		<span class="sr-only">Toggle navigation</span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		</button>
		</div>
		<a class="navbar-brand" target="_blank" href="https:/loep.github.io/index.html">Loep v1.0</a>
		<div class="collapse navbar-collapse navbar-ex1-collapse">
		<ul class="nav navbar-nav side-nav">
		<li><a href="index.html"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a></li>
		<li><a href="services.html"><i class="fa fa-fw fa-desktop"></i> Server Services</a></li>
		<li><a href="heartbeat.html"><i class="fa fa-fw fa-wrench"></i> Network Heartbeat</a></li>
		<li><a href="bandwidth.html"><i class="fa fa-fw fa-bar-chart-o"></i> Bandwidth Usage</a></li>
		<li><a href="resources.html"><i class="fa fa-fw fa-table"></i> Server Resources</a></li>
		<li><a href="authentication.html"><i class="fa fa-fw fa-edit"></i> Authentication Logs</a></li>
		<li class="active"><a href="about.html"><i class="fa fa-fw fa-file"></i> About Program</a></li>
		</div>
		</nav>
		<div id="page-wrapper">
		<div class="container-fluid">
		<div class="row">
		<div class="col-lg-12">
		<h1 class="page-header">About Program</h1>
		<ol class="breadcrumb">
		<li><i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a></li>

		<li class="active">
		<i class="fa fa-fw fa-file"></i> About Program
		</li>
		</ol>
		</div>
		</div>
		<div class="row">
		<div class="col-lg-6">
		<div class="page-header">
		<h2>Features</h2>
		</div>
		<ul>
		<li><span>Easy installation</span></li>
		<li><span>No need of sophisticated configuration and dependencies</span></li>
		<li><span>Low usage of resources</span></li>
		<li><span>Showing cpu usage to percentage</span></li>
		<li><span>Showing memory usage to MB</span></li>
		<li><span>Showing disk usage to percentage</span></li>
		<li><span>Showing server uptime</span></li>
		<li><span>Showing cpu model and frequency</span></li>
		<li><span>Showing number of attacks in ssh service</span></li>
		<li><span>Showing number of active users in server</span></li>
		<li><span>Showing ping time from google server</span></li>
		<li><span>Login monitoring to ssh service</span></li>
		<li><span>Monitoring attacks to ssh service</span></li>
		<li><span>Monitoring Viewed websites in tinyproxy service</span></li>
		<li><span>Login monitoring to server from console way</span></li>
		<li><span>Login monitoring to other users by su command</span></li>
		<li><span>Auto check new version</span></li>
		<li><span>Auto check dependencies in system</span></li>
		<li><span>Configuration ability</span></li>
		<li><span>Network Heartbeat</span></li>
		<li><span>Monitoring Bandwidth Usage</span></li>
		<li><span>Consistent and coordinate for debian 7 & 8</span></li>
		<li><span>Consistent and coordinate for centos 6 & 7</span></li>
		<li><span>Monitoring Servers Resources</span></li>
		<li><span>Monitoring Authentication Logs</span></li>
		<li><span>Monitoring Services logs</span></li>
		</ul>
		</div>
		<div class="col-lg-6">
		<div class="page-header">
		<h2>Documentation</h2>
		</div>
		<ul>
		<li><span><a target="_blank" href=https://loep.github.io/documentation.html#download>How to download source code</a></span></li>
		<li><span><a target="_blank" href=https://loep.github.io/documentation.html#extract>How to extract master.zip file</a></span></li>
		<li><span><a target="_blank" href=https://loep.github.io/documentation.html#dependencies>How to check dependencies</a></span></li>
		<li><span><a target="_blank" href=https://loep.github.io/documentation.html#debian>How to install dependencies on debian</a></span></li>
		<li><span><a target="_blank" href=https://loep.github.io/documentation.html#centos>How to install dependencies on centos</a></span></li>
		<li><span><a target="_blank" href=https://loep.github.io/documentation.html#install>How to install loep</a></span></li>
		<li><span><a target="_blank" href=https://loep.github.io/documentation.html#configuration>How to configuration loep</a></span></li>
		<li><span><a target="_blank" href=https://loep.github.io/documentation.html#update>How to update loep</a></span></li>
		<li><span><a target="_blank" href=https://loep.github.io/documentation.html#uninstall>How to uninstall loep</a></span></li>
		</ul>
		<br>
		<div class="page-header">
		<h2>Download</h2>
		</div>
		<p>Loep v1.0 is available now. You can download and view source code from <a target="_blank" href="https://github.com/loep/loep">github</a>.</p>
		<br>
		<div class="page-header">
		<h2>Tutorial video</h2>
		</div>
		<p>The installation is very simple and easy and do not need many dependency and library. Before installation, please watch tutorial video using <a target="_blank" href="https://www.youtube.com/watch?v=Xr_bXTKKjwE">this link</a>.</p>
		</div>
		</div>
		<div class="page-header">
		<h2>License</h2>
		</div>
		<div class="well">
		<p>This program is <strong>free software;</strong> you can redistribute it and/or modify it under the terms of the <a rel="license" target="_blank" href="https://en.wikipedia.org/wiki/GNU_General_Public_License">GNU General Public License</a> as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.</p>
		</div>
		<br>
		<hr>
		<div class="alert alert-success">
		<strong>Powered By /bin/bash ,</strong> Programming and idea By Iman Homayouni
		</div>
		</div>
		</div>
		</div>
		<script src="js/jquery.js"></script>
		<script src="js/bootstrap.min.js"></script>
		</body>
		</html>
	' > $www/about.html
	echo 'done'

	# Create services.html
	sleep 1
	echo -en '[+] Create services.html : '
	echo '<!-- Programming and idea by : E2MA3N [Iman Homayouni] -->
		<!-- Gitbub : https://github.com/loep -->
		<!-- Email : e2ma3n@Gmail.com -->
		<!-- Website : http://Loep.ir -->
		<!-- License : GPL v3.0 -->
		<!-- CSS and html templates by http://startbootstrap.com/ -->
		<!-- Loep v1.0 [ Monitoring Linux Events and Resources ] -->
		<!DOCTYPE html>
		<html lang="en">
		<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>Loep v1.0 [ Monitoring Linux Events and Resources ]</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/sb-admin.css" rel="stylesheet">
		<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		</head>
		<body>
		<div id="wrapper">
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
		<span class="sr-only">Toggle navigation</span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		</button>
		</div>
		<a class="navbar-brand" target="_blank" href="https:/loep.github.io/index.html">Loep v1.0</a>
		<div class="collapse navbar-collapse navbar-ex1-collapse">
		<ul class="nav navbar-nav side-nav">
		<li><a href="index.html"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a></li>
		<li class="active"><a href="services.html"><i class="fa fa-fw fa-desktop"></i> Server Services</a></li>
		<li><a href="heartbeat.html"><i class="fa fa-fw fa-wrench"></i> Network Heartbeat</a></li>
		<li><a href="bandwidth.html"><i class="fa fa-fw fa-bar-chart-o"></i> Bandwidth Usage</a></li>
		<li><a href="resources.html"><i class="fa fa-fw fa-table"></i> Server Resources</a></li>
		<li><a href="authentication.html"><i class="fa fa-fw fa-edit"></i> Authentication Logs</a></li>
		<li><a href="about.html"><i class="fa fa-fw fa-table"></i> About Program</a></li>
		</div>
		</nav>
		<div id="page-wrapper">
		<div class="container-fluid">
		<div class="row">
		<div class="col-lg-12">
		<h1 class="page-header">Server Services</h1>
		<ol class="breadcrumb">
		<li><i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a></li>

		<li class="active">
		<i class="fa fa-fw fa-desktop"></i> Server Services
		</li>
		</ol>
		</div>
		</div>
		<div class="row">
		<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		<i class="fa fa-info-circle"></i>  <strong>Choose one of services</strong>
		</div>
		</div>
		</div>
		<div class="row">
		<div class="col-sm-4">
		<div class="list-group">
		<a href="ssh-service.html" class="list-group-item">SSH Service</a>
		<a href="tinyproxy.html" class="list-group-item">Tinyproxy Service</a>
		<a href="#" class="list-group-item">Squid Service</a>
		<a href="#" class="list-group-item">Apache Service</a>
		<a href="#" class="list-group-item">Nginx Service</a>
		</div>
		</div>
		</div>                
		<hr>
		<div class="alert alert-success">
		<strong>Powered By /bin/bash ,</strong> Programming and idea By Iman Homayouni
		</div>
		</div>
		</div>
		</div>
		<script src="js/jquery.js"></script>
		<script src="js/bootstrap.min.js"></script>
		</body>
		</html>
	' > $www/services.html
	echo 'done'

	# Download css files
	sleep 3
	echo '[+]'
	echo -en '[+] Download css files from http://Loep.ir/file.zip : '
	rm -f $www/file.zip &> /dev/null
	wget http://loep.ir/file.zip -P $www &> /dev/null
	if [ "$?" = "0" ] ; then
		unzip -o $www/file.zip -d $www &> /dev/null
		chmod -R 755 $www
		rm -f $www/file.zip &> /dev/null
		echo 'done'
		echo '[+]'
	else
		echo 'error ! Can not download css files. Please check internet connection.'
		exit 1
	fi

	# Add authentication.sh to crontab
	sleep 3
	echo -en '[+] Add /opt/loep_v1.0/authentication.sh to /etc/crontab : '
	cat /etc/crontab | grep '@reboot root /opt/loep_v1.0/authentication.sh' &> /dev/null
	if [ "$?" = "0" ] ; then
		echo 'error ! /opt/loep_v1.0/authentication.sh is exists in crontab'
	else
		echo '@reboot root /opt/loep_v1.0/authentication.sh' >> /etc/crontab
		echo 'done'
	fi

	# Add bandwidth.sh to crontab
	sleep 1
	echo -en '[+] Add /opt/loep_v1.0/bandwidth.sh to /etc/crontab : '
	cat /etc/crontab | grep '@reboot root /opt/loep_v1.0/bandwidth.sh' &> /dev/null
	if [ "$?" = "0" ] ; then
		echo 'error ! /opt/loep_v1.0/bandwidth.sh is exists in crontab'
	else
		echo '@reboot root /opt/loep_v1.0/bandwidth.sh' >> /etc/crontab
		echo 'done'
	fi

	# Add heartbeat.sh to crontab
	sleep 1
	echo -en '[+] Add /opt/loep_v1.0/heartbeat.sh to /etc/crontab : '
	cat /etc/crontab | grep '@reboot root /opt/loep_v1.0/heartbeat.sh' &> /dev/null
	if [ "$?" = "0" ] ; then
		echo 'error ! /opt/loep_v1.0/heartbeat.sh is exists in crontab'
	else
		echo '@reboot root /opt/loep_v1.0/heartbeat.sh' >> /etc/crontab
		echo 'done'
	fi

	# Add index.sh to crontab
	sleep 1
	echo -en '[+] Add /opt/loep_v1.0/index.sh to /etc/crontab : '
	cat /etc/crontab | grep '@reboot root /opt/loep_v1.0/index.sh' &> /dev/null
	if [ "$?" = "0" ] ; then
		echo 'error ! /opt/loep_v1.0/index.sh is exists in crontab'
	else
		echo '@reboot root /opt/loep_v1.0/index.sh' >> /etc/crontab
		echo 'done'
	fi

	# Add resources.sh to crontab
	sleep 1
	echo -en '[+] Add /opt/loep_v1.0/resources.sh to /etc/crontab : '
	cat /etc/crontab | grep '@reboot root /opt/loep_v1.0/resources.sh' &> /dev/null
	if [ "$?" = "0" ] ; then
		echo 'error ! /opt/loep_v1.0/resources.sh is exists in crontab'
	else
		echo '@reboot root /opt/loep_v1.0/resources.sh' >> /etc/crontab
		echo 'done'
	fi

	# Add ssh-service.sh to crontab
	sleep 1
	echo -en '[+] Add /opt/loep_v1.0/ssh-service.sh to /etc/crontab : '
	cat /etc/crontab | grep '@reboot root /opt/loep_v1.0/ssh-service.sh' &> /dev/null
	if [ "$?" = "0" ] ; then
		echo 'error ! /opt/loep_v1.0/ssh-service.sh is exists in crontab'
	else
		echo '@reboot root /opt/loep_v1.0/ssh-service.sh' >> /etc/crontab
		echo 'done'
	fi

	# Add tinyproxy.sh to crontab
	sleep 1
	echo -en '[+] Add /opt/loep_v1.0/tinyproxy.sh to /etc/crontab : '
	cat /etc/crontab | grep '@reboot root /opt/loep_v1.0/tinyproxy.sh' &> /dev/null
	if [ "$?" = "0" ] ; then
		echo 'error ! /opt/loep_v1.0/tinyproxy.sh is exists in crontab'
	else
		echo '@reboot root /opt/loep_v1.0/tinyproxy.sh' >> /etc/crontab
		echo 'done'
	fi

	sleep 1
	echo '[+]'

	# echo footer
	echo '[+] Please see README'
	sleep 1.5
	echo '[!] Please restart server'
	sleep 1.5
	echo '[+] You can view source code from /opt/loep_v1.0/'
	sleep 1.5
	echo '[+] Finish'
	echo '[+] ---------------------------------------------------------------------------------------------------------------------- [+]'
}

case $1 in
	-i) install_f ;;
	-c) check_f ;;
	-u) uninstall_f ;;
	*) help_f ;;
esac
