wk=trunk
cd $wk
svn up xls
svn up ResDB_CS
svn up tools/TRESCONV
TortoiseProc /command:commit /path:ResDB_CS/*xls/*tools/* /closeonend:0
