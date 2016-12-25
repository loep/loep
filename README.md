# Loep - Monitoring linux events and resources
## Introduction
Loep is an open source program for monitoring linux events and resources. It can create static html pages for presentation system logs such as Authentication, ssh, tinyproxy and other services.

The project page is located at https://loep.github.io

Live Demo (running on VPS) : http://demo.loep.ir/

See [loep Online Manual (English translation, Persian translation)](https://loep.github.io/documentation.html) to learn how to use loep.

## What distributions are supported ?
Tested on all popular linux distributions such as debian 7, debian 8, CentOS 6 and CentOS 7

* Linux Debian 7.x
* Linux Debian 8.x
* Linux CentOS 6.x
* Linux CentOS 7.x

## Features
Here is a list of features:

* Easy installation
* No need of sophisticated configuration and dependencies
* Low usage of resources
* Showing cpu usage to percentage
* Showing memory usage to MB
* Showing disk usage to percentage
* Showing server uptime
* Showing cpu model and frequency
* Showing number of attacks in ssh service
* Showing number of active users in server
* Showing ping time from google server
* Login monitoring to ssh service
* Monitoring attacks to ssh service
* Monitoring Viewed websites in tinyproxy service
* Login monitoring to server from console way
* Login monitoring to other users by su command
* Auto check new version
* Auto check dependencies in system
* Configuration ability
* Network Heartbeat
* Monitoring Bandwidth Usage
* Consistent and coordinate for debian 7 & 8
* Consistent and coordinate for centos 6 & 7
* Monitoring Servers Resources
* Monitoring Authentication Logs
* Monitoring Services logs

## Dependencies

| Dependency | Description |
| ---------- | ----------- |
| whoami     | Print the user name associated with the current effective user ID.  Same as id -un. |
| grep       | grep searches the named input FILEs (or standard input if no files are named, or if a single hyphen-minus (-) is given as file name) for lines containing a match to the given PATTERN.  By default, grep prints the matching lines. |
| free       | free displays the total amount of free and used physical and swap memory in the system, as well as the buffers used by the kernel. |
| users      | Output who is currently logged in according to FILE.  If FILE is not specified, use /var/run/utmp.  /var/log/wtmp as FILE is common. |
| df         | df displays the amount of disk space available on the file system containing each file name argument. |
| cut        | Print selected parts of lines from each FILE to standard output. |
| cat        | Concatenate FILE(s), or standard input, to standard output. |
| tr         | Translate, squeeze, and/or delete characters from standard input, writing to standard output. |
| tac        | Write each FILE to standard output, last line first.  With no FILE, or when FILE is -, read standard input. |
| head       | Print  the first 10 lines of each FILE to standard output. |
| tail       | Print  the  last 10 lines of each FILE to standard output. |
| wc         | Print  newline,  word, and byte counts for each FILE, and a total line if more than one FILE is specified. |
| rev        | The rev utility  copies  the specified files to standard output, reversing the order of characters in every line. |
| date       | Display the current time in the given FORMAT, or set the system date. |
| cp         | Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY. |
| sleep      | Pause for NUMBER seconds. |
| expr       | evaluate expressions |
| ifconfig   | Ifconfig is used to configure the kernel-resident network interfaces. |
| ping       | ping uses the ICMP protocol's mandatory ECHO_REQUEST datagram to elicit an ICMP ECHO_RESPONSE from a host or gateway. |
| curl       | curl is a tool to transfer data from or to a server. |
| wget       | GNU Wget is a free utility for non-interactive download of files from the Web. |
| bc         | bc is a language that supports arbitrary precision numbers with interactive execution of statements. |
| iostat     | The iostat command is used for monitoring system input/output device loading by observing the time the devices are active in relation to their average transfer rates. |
| sort       | Write sorted concatenation of all FILE(s) to standard output. |
| unzip      | unzip will list, test, or extract files from a ZIP archive, commonly found on MS-DOS systems. |
| uptime     | uptime gives a one line display of the following information. |
| sed        | Sed is a stream editor. A stream editor is used to perform basic text transformations on an input stream (a file or input from a pipeline). |

## How to get source code ?
You can download and view source code from github : https://github.com/loep/loep/

Also to get the latest source code, run following command:
```
# git clone https://github.com/loep/loep.git
```
This will create loep directory in your current directory and source files are stored there.

## How to check dependencies on system ?
In the first step, set execute permission for install.sh :
```
# cd loep
# chmod +x install.sh
```
Then, check dependencies, using -c switch :
```
# ./install -c
```
## How to install dependencies on debian ?
By using apt-get command; for example :
```
# apt-get install sysstat
# apt-get install bc
# apt-get install curl
...
```
## How to install dependencies on centos ?
By using yum command; for example :
```
# yum install sysstat
# yum install bc
# yum install curl
# yum install expr
...
```
## How to install loep ?
By using -i switch :
```
# ./install.sh -i
```

## License
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
