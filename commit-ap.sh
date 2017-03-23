ap='applerelease'
svn up $ap
cd $ap
TortoiseProc /command:commit /path:Assets/Scripts/*Assets/Resources/* 
             /closeonend:0
