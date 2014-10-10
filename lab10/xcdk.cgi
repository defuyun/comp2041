#!/bin/sh
echo "Content-type: text/html
"
page=`wget -q -O-  "http://c.xkcd.com/random/comic/"`
link=`echo $page | egrep -o "embedding\): [^ ]+" | sed 's/embedding): //'`
echo "<img src=\"$link\">"

