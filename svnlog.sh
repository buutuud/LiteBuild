wk=trunk && cd $wk
svn log -v -r{2017-03-22}:HEAD| awk '/^r[0-9]+ / {user=$3} /./{if (user=="happyyi") {print}}' | grep -E "^   M|^   G|^   A|^   D|^   C|^   U"| awk '{print $2}' | sort | uniq > ../log.txt
