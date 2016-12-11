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
		web_server=`echo -n "$web_server"/index.html`
		delay=`grep 'update "Dashboard" page after' /opt/loep_v1.0/conf/general.conf | cut -d '=' -f 2 | cut -d ' ' -f 2`
	else
		echo '[-] Not found : /opt/loep_v1.0/conf/general.conf '
		exit 1
	fi

	# check loep directory
	if [ -d /opt/loep_v1.0/html/ ] ; then
		out='/opt/loep_v1.0/html/index.html'
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
		<li class="active"><a href="index.html"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a></li>
		<li><a href="services.html"><i class="fa fa-fw fa-desktop"></i> Server Services</a></li>
		<li><a href="heartbeat.html"><i class="fa fa-fw fa-wrench"></i> Network Heartbeat</a></li>
		<li><a href="bandwidth.html"><i class="fa fa-fw fa-bar-chart-o"></i> Bandwidth Usage</a></li>
		<li><a href="resources.html"><i class="fa fa-fw fa-table"></i> Server Resources</a></li>
		<li><a href="authentication.html"><i class="fa fa-fw fa-edit"></i> Authentication Logs</a></li>
		<li><a href="about.html"><i class="fa fa-fw fa-file"></i> About Program</a></li>
		</div>
		</nav>
		<div id="page-wrapper">
		<div class="container-fluid">
		<div class="row">
		<div class="col-lg-12">
		<h1 class="page-header">Dashboard</h1>
		<ol class="breadcrumb">
		<li class="active">
		<i class="fa fa-dashboard"></i> Dashboard
		</li>
		</ol>
		</div>
		</div>

		<div class="well">
		<h3>Loep v1.0 [ Monitoring Linux Events and Resources ]</h3>
		<p>Loep is an open source program for monitoring linux events and resources. It can create a static html pages for presentation system logs such as Authentication, ssh, tinyproxy and other services. Please visit live demo using <a target="_blank" href="#">this link</a>.</p>
	 	<p>The installation is very simple and easy and do not need many dependency and library. Before installation, please watch tutorial video using <a target="_blank" href="#">this link</a>.</p>
		<a href="https://loep.github.io/documentation.html" class="btn btn-primary">Documentation</a>
		<a href="https://loep.github.io/download.html" class="btn btn-success">Download</a>
		</p>
		</div>

		<div class="row">
		<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	' > $out

	echo "<i class='fa fa-info-circle'></i>  <strong>Update automatically after $delay second</strong>" >> $out
		
	echo '
		</div>
		</div>
		</div>

		<div class="row">
		<div class="col-lg-12">
		<div class="alert alert-info alert-dismissable">
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	' >> $out

	curent='1.0'
	version=`curl http://loep.ir/last-version/version.txt 2> /dev/null`

	n=`echo "$version > $curent" | bc 2> /dev/null`

	if [ "$n" = "0" ] ; then
		echo '<i class="fa fa-info-circle"></i>  <strong>The latest version is installed</strong>' >> $out
	elif [ "$n" = "1" ] ; then
		echo "<i class='fa fa-info-circle'></i>  <strong>New version ($version) is available. </strong>Please see http://Loep.ir" >> $out
	else
		echo '<i class="fa fa-info-circle"></i>  <strong>Command error</strong>' >> $out
	fi

	echo '
		</div>
		</div>
		</div>

		<div class="row">
		<div class="col-lg-12">
		<h2>Loep resources usage</h2>
		<div class="table-responsive">
		<table class="table table-bordered table-hover table-striped">
		<thead>
		<tr>
		<th>USER</th>
		<th>PID</th>
		<th>%CPU</th>
		<th>%MEM</th>
		<th>START</th>
		<th>COMMAND</th>
		</tr>
		</thead>
		<tbody>
	' >> $out


	table=`ps ux | grep loep | grep /bin/bash | tr -s ' '`

	if [ -z "$table" ] ; then
		echo '<tr>' >> $out
		echo '<td>Command error</td>' >> $out
		echo '<td>Command error</td>' >> $out
		echo '<td>Command error</td>' >> $out
		echo '<td>Command error</td>' >> $out
		echo '<td>Command error</td>' >> $out
		echo '<td>Command error</td>' >> $out
		echo '</tr>' >> $out
	else
		n=`echo "$table" | wc -l`

		for (( i=1 ; i <= $n ; i++ )) ; do
			echo '<tr>' >> $out
			echo "<td>`echo "$table" | head -n $i | tail -n 1 | cut -d ' ' -f 1`</td>" >> $out
			echo "<td>`echo "$table" | head -n $i | tail -n 1 | cut -d ' ' -f 2`</td>" >> $out
			echo "<td>`echo "$table" | head -n $i | tail -n 1 | cut -d ' ' -f 3`</td>" >> $out
			echo "<td>`echo "$table" | head -n $i | tail -n 1 | cut -d ' ' -f 4`</td>" >> $out
			echo "<td>`echo "$table" | head -n $i | tail -n 1 | cut -d ' ' -f 9`</td>" >> $out
			echo "<td>`echo "$table" | head -n $i | tail -n 1 | cut -d ' ' -f 11,12`</td>" >> $out
			echo '</tr>' >> $out
		done
	fi

	echo '
			</tbody>
			</table>
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
	unset web_server
	unset delay
done