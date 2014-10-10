#!/bin/sh

cat <<eof
Content-type: text/html

<!DOCTYPE html>
<CTYPE html>
<html lang="en">
<head>
<title>IP, Host and Browser IP</title>
<style type="text/css">
table{border-collapse:collapse;margin:0 auto;line-height:20px;width:728px;table-layout:fixed;}
tr{height:30px;}
td{border: solid 1px;padding: 0px 10px;}
</style>
</head>
<body>
<table id="info_table" >
eof

Id=`echo $REMOTE_ADDR`
name=`host $Id|egrep -o "Name:.*"|sed s/Name://`
browser=`echo $HTTP_USER_AGENT`
echo "<tr><td>Browser IP Address<td>$Id"
echo "<tr><td>Browser Hostname<td>$name"
echo "<tr><td>Browser<td>$browser"

cat <<eof
</table>
</body>
</html>
eof

