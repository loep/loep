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

# Main loop
for (( ;; )) ; do

	# check config file
	if [ -f /opt/loep_v1.0/conf/general.conf ] ; then
		web_server=`grep 'web server directory' /opt/loep_v1.0/conf/general.conf | cut -d '=' -f 2 | cut -d ' ' -f 2`
		web_server=`echo -n "$web_server"/resources.html`
		delay=`grep 'update "Servers Resources" page after' /opt/loep_v1.0/conf/general.conf | cut -d '=' -f 2 | cut -d ' ' -f 2`
	else
		echo '[-] Not found : /opt/loep_v1.0/conf/general.conf '
		exit 1
	fi

	# check loep directory
	if [ -d /opt/loep_v1.0/html/ ] ; then
		out='/opt/loep_v1.0/html/resources.html'
	else
		echo '[-] Not found : /opt/loep_v1.0/html/'
		exit 1
	fi

	echo '
		<!-- Programming and idea by : E2MA3N [Iman Homayouni] -->
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
		<li class="active"><a href="resources.html"><i class="fa fa-fw fa-table"></i> Server Resources</a></li>
		<li><a href="authentication.html"><i class="fa fa-fw fa-edit"></i> Authentication Logs</a></li>
		<li><a href="about.html"><i class="fa fa-fw fa-file"></i> About Program</a></li>
		</div>
		</nav>
		<div id="page-wrapper">
		<div class="container-fluid">
		<div class="row">
		<div class="col-lg-12">
		<h1 class="page-header">Server Resources</h1>
		<ol class="breadcrumb">
		<li>
		<i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a>
		</li>
		<li class="active">
		<i class="fa fa-table"></i> Server Resources
		</li>
		</ol>
		</div>
		</div>
	' > $out

	echo '
		<div class="row">
		<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	' >> $out

	echo "<i class='fa fa-info-circle'></i>  <strong>Update automatically after $delay second</strong>" >> $out
		
	echo '
		</div>
		</div>
		</div>
	' >> $out

	echo '	
		<div class="row">
		<div class="col-sm-4">
		<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">Uptime</h3>
		</div>
		<div class="panel-body">
	' >> $out

	# Uptime
	time=`uptime -p 2> /dev/null`
	if [ "$?" = "0" ] ; then
		t=`echo "$time" | sed 's/^up//' | cut -d ',' -f 1,2,3`
	else
		t=`uptime | rev | cut -d ',' -f 1,2,3,4 --complement | rev | grep -o -P '.{0,0}up.{0,}'`	
	fi

	if [ -z "$t" ] ; then
		echo '
			Command error
			' >> $out
	else
		echo "
			$t
			" >> $out
	fi

	echo '
		</div>
		</div>
		<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">CPU Usage</h3>
		</div>
		<div class="panel-body">
	' >> $out

	# CPU Usage
	cpu=`iostat | grep -A1 '%idle' | tr " " : | tr -s : | cut -d : -f 7 | tail -n1 | cut -d . -f 1`
	cpu=`expr 100 - $cpu`

	if [ -z "$cpu" ] ; then
		echo '
			Command error
		' >> $out
	else
		echo "
			$cpu Percent
		" >> $out
	fi

	echo '
		</div>
		</div>
		</div>
		<div class="col-sm-4">
		<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">CPU Frequency</h3>
		</div>
		<div class="panel-body">
	' >> $out

	# CPU Information
	frequency=`grep 'model name' /proc/cpuinfo | head -n 1 | cut -d '@' -f 2`
	core=`grep processor /proc/cpuinfo | wc -l`

	if [ ! -f /proc/cpuinfo ] ; then
		echo '
			Command error
		' >> $out
	else
		echo "
			$core x $frequency
		" >> $out
	fi

	echo '
		</div>
		</div>
		<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">Active Users</h3>
		</div>
		<div class="panel-body">
	' >> $out

	# Active users
	n=`users | wc -w`

	if [ -z "$n" ] ; then
		echo '
			Command error
		' >> $out
	else
		echo "
			$n Person
		" >> $out
	fi

	echo '
		</div>
		</div>
		</div>
		<div class="col-sm-4">
		<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">SSH Attacks</h3>
		</div>
		<div class="panel-body">
	' >> $out

	# SSH Attacks
	if [ -f /var/log/auth.log ] ; then
		n=`cat $(ls /var/log/auth.log* | sort -r | grep -v gz) | tr -s ' ' | grep 'Failed password' | wc -l`
	elif [ -f /var/log/secure ] ; then
		n=`cat $(ls /var/log/secure* | sort -r | grep -v gz) | tr -s ' ' | grep 'Failed password' | wc -l`
	fi

	if [ -z "$n" ] ; then
		echo '
			Command error
		' >> $out
	else
		echo "
			$n SSH Attack on server
		" >> $out
	fi

	echo '
		</div>
		</div>
		<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">Disk Usage</h3>
		</div>
		<div class="panel-body">
		' >> $out

	# Disk Usage
	n=`df | rev | grep "^/" | tr -s ' ' | cut -d ' ' -f 2 | rev | tr -d '%' | head -n 1`

	if [ -z "$n" ] ; then
		echo '
			Command error
		' >> $out
	else
		echo "
			$n Percent
		" >> $out
	fi

	echo '
		</div>
		</div>
		</div>
		<div class="col-sm-4">
		<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">Ping Latency</h3>
		</div>
		<div class="panel-body">
	' >> $out

	# Ping Latency
	Latency=`ping -c 1 8.8.8.8 | grep 'time=' | cut -d '=' -f 4`

	if [ -z "$Latency" ] ; then
		echo '
			Command error
		' >> $out
	else
		echo "
			$Latency from 8.8.8.8
		" >> $out
	fi

	echo '
		</div>
		</div>
		</div>
		<div class="col-sm-4">
		<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">CPU Model</h3>
		</div>
		<div class="panel-body">
	' >> $out

	# Host name
	model=`grep 'model name' /proc/cpuinfo | head -n 1 | cut -d '@' -f 1 | cut -d : -f 2 | tr -s ' '`
	if [ ! -f /proc/cpuinfo ] ; then
		echo '
			Command error
		' >> $out
	else
		echo "
			$model
		" >> $out
	fi

	echo '
		</div>
		</div>
		</div>
		<div class="col-sm-4">
		<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">RAM Usage</h3>
		</div>
		<div class="panel-body">
	' >> $out

	# RAM Usage
	ram=`free -m | grep Mem | tr -s " " : | cut -d : -f 3`
	total=`free -m | grep Mem | tr -s ' ' | cut -d ' ' -f 2`

	if [ -z "$ram" ] ; then
		echo '
			Command error
		' >> $out
	else
		echo "
			$ram Megabyte from $total Megabyte
		" >> $out
	fi

	echo '
		</div>
		</div>
		</div>
		</div>
	' >> $out

	echo '
		<hr>
		<div class="alert alert-danger">
	' >> $out
	update=`date +'%e %b %Y - %H:%M:%S - %Z'`
	if [ -z "$update" ] ; then
		echo "
			<strong>Last update : </strong>Command error
		" >> $out
	else
		echo "
			<strong>Last update : </strong>$update
		" >> $out
	fi

	echo '
		</div>
		<div class="alert alert-success">
		<strong>Powered by /bin/bash ,</strong> Programming and idea by Iman Homayouni
		</div>
		</div>
		</div>
		<script src="js/jquery.js"></script>
		<script src="js/bootstrap.min.js"></script>
		</body>
		</html>
	' >> $out

	mv $out $web_server
	echo '[+] Finish'
	echo "[+] Sleep $delay second"
	echo '[+]'
	sleep $delay

done