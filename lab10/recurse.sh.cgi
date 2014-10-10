#!/bin/sh

cat <<eof
Content-type: text/html

<!DOCTYPE html>
<html lang="en">
<head>
<title>Recurse</title>
</head
<body>
eof

url=`echo $REDIRECT_SCRIPT_URI`
level=`echo $QUERY_STRING`
level=`expr $level + 1`
echo "<b>Level $level</b>: <a href="$url\?$level">Run me again<a/>"

cat <<eof
</body>
</html>
eof

