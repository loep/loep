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
		web_server=`echo -n "$web_server"/ssh-service.html`
		grep_attack=`grep 'grep number of ssh attack in log file' /opt/loep_v1.0/conf/general.conf | cut -d '=' -f 2 | cut -d ' ' -f 2`
		grep_login=`grep 'grep number of ssh login in log file' /opt/loep_v1.0/conf/general.conf | cut -d '=' -f 2 | cut -d ' ' -f 2`
		delay=`grep 'update "SSH Service" page after' /opt/loep_v1.0/conf/general.conf | cut -d '=' -f 2 | cut -d ' ' -f 2`
	else
		echo '[-] Not found : /opt/loep_v1.0/conf/general.conf '
		exit 1
	fi

	# check loep directory
	if [ -d /opt/loep_v1.0/html/ ] ; then
		out='/opt/loep_v1.0/html/ssh-service.html'
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
		<li class="active"><a href="services.html"><i class="fa fa-fw fa-desktop"></i> Server Services</a></li>
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
		<h1 class="page-header">SSH Service</h1>
		<ol class="breadcrumb">
		<li><i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a></li>
		<li><i class="fa fa-fw fa-desktop"></i>  <a href="services.html">Server Services</a></li>
		<li class="active">
		<i class="fa fa-edit"></i> SSH Service
		</li>
		</ol>
		</div>
		</div>
	' > $out

	if [ -f /var/log/auth.log ] ; then

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
			<div class="col-lg-12">
			<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			<i class="fa fa-info-circle"></i>  <strong>Logs address : /var/log/auth.log*</strong>
			</div>
			</div>
			</div>
		' >> $out

		log_file=`cat $(ls /var/log/auth.log* | sort -r | grep -v gz) | tr -s ' '`
		ssh_login=`echo "$log_file" | grep ssh2 | grep 'Accepted password for' | tr -s ' ' | cut -d ' ' -f 1,2,3,9,11 | tac | head -n $grep_login`

		if [ -z "$ssh_login" ] ; then

			echo '
				<div class="row">
				<div class="col-lg-12">
				<div class="alert alert-info alert-dismissable">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				<i class="fa fa-info-circle"></i>  <strong>No SSH login ! Please see /var/log/auth.log*</strong>
				</div>
				</div>
				</div>
			' >> $out

		fi

		ssh_attack=`echo "$log_file" | grep ssh2 | grep 'Failed password for' | tr -s ' ' | tac | head -n $grep_attack`

		if [ -z "$ssh_attack" ] ; then

			echo '
				<div class="row">
				<div class="col-lg-12">
				<div class="alert alert-info alert-dismissable">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				<i class="fa fa-info-circle"></i>  <strong>No SSH attack ! Please see /var/log/auth.log*</strong>
				</div>
				</div>
				</div>
			' >> $out

		fi

		n=`echo "$ssh_login" | wc -l`

		echo '
			<div class="row">
			<div class="col-lg-6">
		' >> $out

		echo "<h2>Last $grep_login SSH Login</h2>" >> $out

		echo '
			<div class="table-responsive">
			<table class="table table-bordered table-hover table-striped">
			<thead>
			<tr>
			<th>ID</th>
			<th>IP</th>
			<th>Date</th>
			<th>User</th>
			</tr>
			</thead>
			<tbody>
		' >> $out

		for (( i=1 ; i <= $n ; i++ )) ; do

			echo '<tr>' >> $out
			echo "<td>$i</td>" >> $out
			echo "<td>`echo "$ssh_login" | cut -d ' ' -f 5 | head -n $i | tail -n 1`</td>" >> $out
			echo "<td>`echo "$ssh_login" | cut -d ' ' -f 1,2,3 | head -n $i | tail -n 1`</td>" >> $out
			echo "<td>`echo "$ssh_login" | cut -d ' ' -f 4 | head -n $i | tail -n 1`</td>" >> $out
			echo '</tr>' >> $out

		done

		echo '
			</tbody>
			</table>
			</div>
			</div>
			<div class="col-lg-6">
		' >> $out
		
		echo "<h2>Last $grep_attack SSH Attack</h2>" >> $out

		echo '
			<div class="table-responsive">
			<table class="table table-bordered table-hover table-striped">
			<thead>
			<tr>
			<th>ID</th>
			<th>IP</th>
			<th>Date</th>
			<th>User</th>
			</tr>
			</thead>
			<tbody>
		' >> $out

		n=`echo "$ssh_attack" | wc -l`

		for (( i=1 ; i <= $n ; i++ )) ; do

			echo '<tr>' >> $out
			echo "<td>$i</td>" >> $out
			echo "<td>`echo "$ssh_attack" | rev | cut -d ' ' -f 4 | rev | head -n $i | tail -n 1`</td>" >> $out
			echo "<td>`echo "$ssh_attack" | cut -d ' ' -f 1,2,3 | head -n $i | tail -n 1`</td>" >> $out
			echo "<td>`echo "$ssh_attack" | rev | cut -d ' ' -f 6 | rev | head -n $i | tail -n 1`</td>" >> $out
			echo '</tr>' >> $out

		done

		echo '
			</tbody>
			</table>
			</div>
			</div>
			</div>
			<br>
		' >> $out

	elif [ -f /var/log/secure ] ; then

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
			<div class="col-lg-12">
			<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			<i class="fa fa-info-circle"></i>  <strong>Logs address : /var/log/secure*</strong>
			</div>
			</div>
			</div>
		' >> $out

		log_file=`cat $(ls /var/log/secure* | sort -r | grep -v gz) | tr -s ' '`
		ssh_login=`echo "$log_file" | grep sshd | grep 'Accepted password for' | tr -s ' ' | tac`

		if [ -z "$ssh_login" ] ; then

			echo '
				<div class="row">
				<div class="col-lg-12">
				<div class="alert alert-info alert-dismissable">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				<i class="fa fa-info-circle"></i>  <strong>No SSH login ! Please see /var/log/secure*</strong>
				</div>
				</div>
				</div>
			' >> $out

		fi

		ssh_attack=`echo "$log_file" | grep sshd | grep 'Failed password for' | tr -s ' ' | tac`

		if [ -z "$ssh_attack" ] ; then

			echo '
				<div class="row">
				<div class="col-lg-12">
				<div class="alert alert-info alert-dismissable">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				<i class="fa fa-info-circle"></i>  <strong>No SSH attack ! Please see /var/log/secure*</strong>
				</div>
				</div>
				</div>
				' >> $out

		fi

		n=`echo "$ssh_login" | wc -l`

		echo '
			<div class="row">
			<div class="col-lg-6">
		' >> $out

		echo "<h2>Last $grep_login SSH Login</h2>" >> $out

		echo '
			<div class="table-responsive">
			<table class="table table-bordered table-hover table-striped">
			<thead>
			<tr>
			<th>ID</th>
			<th>IP</th>
			<th>Date</th>
			<th>User</th>
			</tr>
			</thead>
			<tbody>
		' >> $out

		for (( i=1 ; i <= $n ; i++ )) ; do

			echo '<tr>' >> $out
			echo "<td>$i</td>" >> $out
			echo "<td>`echo "$ssh_login" | head -n $i | tail -n 1 | rev | cut -d ' ' -f 4 | rev`</td>" >> $out
			echo "<td>`echo "$ssh_login" | head -n $i | tail -n 1 | cut -d ' ' -f 1,2,3`</td>" >> $out
			echo "<td>`echo "$ssh_login" | head -n $i | tail -n 1 | rev | cut -d ' ' -f 6 | rev`</td>" >> $out
			echo '</tr>' >> $out

		done

		echo '
			</tbody>
			</table>
			</div>
			</div>
			<div class="col-lg-6">
		' >> $out
		
		echo "<h2>Last $grep_attack SSH Attack</h2>" >> $out

		echo '
			<div class="table-responsive">
			<table class="table table-bordered table-hover table-striped">
			<thead>
			<tr>
			<th>ID</th>
			<th>IP</th>
			<th>Date</th>
			<th>User</th>
			</tr>
			</thead>
			<tbody>
		' >> $out

		n=`echo "$ssh_attack" | wc -l`

		for (( i=1 ; i <= $n ; i++ )) ; do

			echo '<tr>' >> $out
			echo "<td>$i</td>" >> $out
			echo "<td>`echo "$ssh_attack" | head -n $i | tail -n 1 | rev | cut -d ' ' -f 4 | rev`</td>" >> $out
			echo "<td>`echo "$ssh_attack" | head -n $i | tail -n 1 | cut -d ' ' -f 1,2,3`</td>" >> $out
			echo "<td>`echo "$ssh_attack" | head -n $i | tail -n 1 | rev | cut -d ' ' -f 6 | rev`</td>" >> $out
			echo '</tr>' >> $out

		done

		echo '
			</tbody>
			</table>
			</div>
			</div>
			</div>
			<br>
		' >> $out

	else

		echo '
			<div class="alert alert-danger">
			<strong>Not found : </strong> /var/log/auth.log or /var/log/secure
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

	unset log_file
	unset ssh_login
	unset ssh_attack
	mv $out $web_server
	echo '[+] Finish'
	echo "[+] Sleep $delay second"
	echo '[+]'
	sleep $delay

done