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

# Main loop !
for (( ;; )) ; do

	# check config file
	if [ -f /opt/loep_v1.0/conf/general.conf ] ; then
		web_server=`grep 'web server directory' /opt/loep_v1.0/conf/general.conf | cut -d '=' -f 2 | cut -d ' ' -f 2`
		web_server=`echo -n "$web_server"/bandwidth.html`
		delay=`grep 'update "Bandwidth Usage" page after' /opt/loep_v1.0/conf/general.conf | cut -d '=' -f 2 | cut -d ' ' -f 2`
	else
		echo '[-] Not found : /opt/loep_v1.0/conf/general.conf '
		exit 1
	fi

	# check loep directory
	if [ -d /opt/loep_v1.0/html/ ] ; then
		out='/opt/loep_v1.0/html/bandwidth.html'
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
		<li class="active"><a href="bandwidth.html"><i class="fa fa-fw fa-bar-chart-o"></i> Bandwidth Usage</a></li>
		<li><a href="resources.html"><i class="fa fa-fw fa-table"></i> Server Resources</a></li>
		<li><a href="authentication.html"><i class="fa fa-fw fa-edit"></i> Authentication Logs</a></li>
		<li><a href="about.html"><i class="fa fa-fw fa-file"></i> About Program</a></li>
		</div>
		</nav>
		<div id="page-wrapper">
		<div class="container-fluid">
		<div class="row">
		<div class="col-lg-12">
		<h1 class="page-header">
		Bandwidth Usage
		</h1>
		<ol class="breadcrumb">
		<li>
		<i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a>
		</li>
		<li class="active">
		<i class="fa fa-bar-chart-o"></i> Bandwidth Usage 
		</li>
		</ol>
		</div>
		</div>
	' > $out

	# checking /opt/loep_v1.0/conf/interface.conf
	if [ -f /opt/loep_v1.0/conf/interface.conf ] ; then

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

	n=`cat /opt/loep_v1.0/conf/interface.conf | wc -l`
	n=`expr $n - 10`
	iface=`cat /opt/loep_v1.0/conf/interface.conf | tail -n $n | cut -d " " -f 1`
	comment=`cat /opt/loep_v1.0/conf/interface.conf | tail -n $n | cut -d " " -f 2-`
	n=`echo "$iface" | wc -l`

	if [ -z "$iface" ] ; then

		echo '
			<div class="alert alert-danger">
			<strong>Config file is empty. </strong>Please see /opt/loep_v1.0/conf/interface.conf
			</div>
			' >> $out

	else

		echo '
			<div class="row">
			' >> $out
		for (( i=1 ; i <= $n ; i++ )) ; do

			echo '
				<div class="col-sm-4">
				<div class="panel panel-yellow">
				<div class="panel-heading">
				' >> $out
			echo "
				<h3 class="panel-title">`echo "$comment" | head -n $i | tail -n 1`</h3>
				" >> $out
			echo '
				</div>
				<div class="panel-body">
				' >> $out

			interface=`echo "$iface" | head -n $i | tail -n 1`
			download=`ifconfig $interface | grep RX | grep bytes | cut -d ')' -f 1 | cut -d '(' -f 2`
			upload=`ifconfig $interface | grep bytes | grep -o -P '.{0,0}TX.{0,}' | cut -d '(' -f 2 | tr -d ')'`

			if [ -z "$download" ] ; then
				echo '
					Command error
					' >> $out
			else
				echo "
					$download receive / $upload send
					" >> $out
			fi

			echo '
				</div>
				</div>
				</div>
				' >> $out

		done
		echo '
			</div>
			' >> $out

	fi

	else

	echo '
		<div class="alert alert-danger">
		<strong>Not found : </strong> /opt/loep_v1.0/conf/interface.conf
		</div>
		' >> $out

	fi

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