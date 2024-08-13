@ECHO OFF
CALL ExportDataEscrow.bat svnurl_recruiting.txt

:MoveFiles
SET MM=%DATE:~4,2%
SET DD=%DATE:~7,2%
SET YYYY=%DATE:~10,4%

SET PROJ=\\denver2\escrow\CM\rawexport
SET P2=\\denver2\Escrow\REC\Media Content in SVN
SET P3=\\denver2\escrow\REC\Recruiting Help Site in SVN

copy %PROJ%\Recruiting.rar "%P2%\Recruiting_%YYYY%-%MM%-%DD%.rar"
copy %PROJ%\knowledge.ultipro.com.rar "%P3%\knowledge.ultipro.com_%YYYY%-%MM%-%DD%.rar"





CALL GITExport.cmd
:END
PAUSE