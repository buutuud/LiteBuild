taskkill -f -im et.exe
wk='trunk'
svn cleanup $wk
svn up $wk
cd $wk
TortoiseProc /command:commit /path:Assets/Scripts/*Assets/Resources/* /closeonend:0
svn log -v -r HEAD| awk '/^r[0-9]+ / {user=$3} /./{if (user=="happyyi") {print}}' | grep -E "^   M|^   G|^   A|^   D|^   C|^   U"| awk '{print $2}' | sort | uniq > ../tmp
