@ECHO OFF
setlocal enabledelayedexpansion
:VARIABLES
SET SVNPRODURL=https://devsvn/svn
SET EXPPATH=e:\E
SET PROJ=\\denver2\escrow\CM\rawexport
SET MM=%DATE:~4,2%
SET DD=%DATE:~7,2%
SET YYYY=%DATE:~10,4%
::\\denver2\escrow\REC\Release Branches in GIT
::\\denver2\escrow\REC\Recruiting Help Site in SVN
::\\denver2\escrow\REC\Media Content in SVN

:CLEANUPWRKDIR
rd /S /Q %EXPPATH%
rd /S /Q %CD%\recruiting
mkdir %EXPPATH%
mkdir %PROJ%
goto ExportSVNdata

:ExportSVNdata

FOR /f "tokens=1 delims=," %%A in (svnurl.txt) do (
SET OLD=%%A
ECHO !OLD!
SET NEWP=!OLD:/=\!
ECHO !NEWP!
ECHO variable NEWP = !NEWP! > %CD%\ExportdataEscrow.log
svn export --username syncuser --password syncuser --force %SVNPRODURL%/%%A %EXPPATH%\%%A
"C:\Program Files (x86)\WinRAR\WinRAR.exe" a -r %EXPPATH%\%%A_test.rar %EXPPATH%\%%A\*.* %EXPPATH%\%%A"'
copy /B %EXPPATH%\!NEWP!\..\*.rar E:\e
copy /B %EXPPATH%\!NEWP!\..\*.rar %PROJ%)
)
:END
