@ECHO OFF
setlocal enabledelayedexpansion
:VARIABLES
SET PK=%1
::SET SVNPRODURL=https://devsvn/svn/ultipro/trunk
SET EXPPATH=e:\E
::SET PROJ=\\denver2\git\SVNtoGIT\rawexport
SET MM=%DATE:~4,2%
SET DD=%DATE:~7,2%
SET YYYY=%DATE:~10,4%
::\\denver2\escrow\REC\Release Branches in GIT
::\\denver2\escrow\REC\Recruiting Help Site in SVN
::\\denver2\escrow\REC\Media Content in SVN

:CLEANUPWRKDIR
::rd /S /Q %EXPPATH%
::rd /S /Q %CD%\ultipro
::mkdir %EXPPATH%
::mkdir %PROJ%
::goto ExportSVNdata
::goto SVNtoGITMigration
goto WorkRepoNameList

:WorkRepoNameList

FOR /f "tokens=1 delims=," %%A in (10_RepoNames.txt) do (
SET OLD=%%A
SET REPO_NAME=%%A
ECHO !OLD!
ECHO !REPO_NAME!
SET NEWP=!OLD:/=\!
ECHO !NEWP!
ECHO variable NEWP = !NEWP! > %CD%\..\Mirror_Git_Repos.log
ECHO You are about to run: CALL 10_GIT_Mirror_OneTime.bat !REPO_NAME!.git
CALL C:\zPOC\10_GIT_Mirror_OneTime.bat !REPO_NAME!.git %PK%
 
)


GOTO END


:END
