#!/bin/bash

echo "<html>" > report.html
echo "<head><title>Security Incident Report - Kerry</title>" >> report.html
echo "<style>
table{
	border-collapse: collapse;
	width: 100%;
}
th, td{
	border: 1px solid #dddddd;
	text-align: center;
	padding: 10px;
}
tr:nth-child(even){
	background-color: #d3d3d3;
}
th{
	bacground-color: white;
	color: #de6a31;
}
</style>" >> report.html
echo "</head>" >> report.html
echo "<body>" >> report.html
echo "<h1>Security Incident Report for Kerry's Final</h1>" >> report.html
echo "<table>" >> report.html
echo "<tr><th>IP Address</th><th>Date/Time</th><th>Page Was Accessed </th></tr>" >> report.html

while IFS= read -r line; do
	ip=$(echo $line | awk '{print $1}')
	datetime=$(echo $line | awk '{print $2, $3}')
	page=$(echo $line | awk '{print $4}')

	echo "<tr><td>$ip</td><td>$datetime</td><td>$page</td></tr>"  >> report.html
done < "report.txt"

echo "</table>" >> report.html
echo "</body>" >> report.html
echo "</html>" >> report.html

sudo mv report.html /var/www/html/

echo "Confirmation everything moved over properly"
