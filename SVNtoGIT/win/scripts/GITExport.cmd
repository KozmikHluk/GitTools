::##GIT ARCHIVE for DATA ESCROW 
@ECHO OFF
SET REPO_NAME=recruiting
SET GITSERVER=ultigit.ultimatesoftware.com
SET PROJ=\\denver2\escrow\REC\rawexport
SET EXPPATH=e:\e
SET MM=%DATE:~4,2%
SET DD=%DATE:~7,2%
SET YYYY=%DATE:~10,4%
SET FILE_NAME=%REPO_NAME%_%YYYY%-%MM%-%DD%
SET LOGFILE=%CD%\%REPO_NAME%.log
IF %REPO_NAME%==recruiting set GITPROJ=REC

SET PROTOCOL=https
IF %PROTOCOL%==https set urlstring=443/scm/%GITPROJ%
IF %PROTOCOL%==ssh set urlstring=7999/%GITPROJ%
ECHO %URLSTRING%

SET BORDER=-----------------------------------------------------------------------
IF EXIST %LOGFILE% GOTO :START
ECHO #%YYYY%:%MM%:%DD% > %LOGFILE%
ECHO %BORDER% >> %LOGFILE%
:START
ECHO %BORDER% >> %LOGFILE%
ECHO %YYYY%:%MM%:%DD% : ExportJob %REPO_NAME% >> %LOGFILE%
ECHO %YYYY%:%MM%:%DD% : %TIME% : Check For local repo of %REPO_NAME% >>  %LOGFILE%

IF NOT EXIST %CD%\%REPO_NAME% GOTO :CLONE
rd /s /q %CD%\%REPO_NAME%
ECHO %YYYY%:%MM%:%DD% : %TIME% : Local git repo cleanup completed of %REPO_NAME% >>  %LOGFILE%

:CLONE
ECHO %YYYY%:%MM%:%DD% : %TIME% : Local Copy of %REPO_NAME% being created >>  %LOGFILE%
ECHO %YYYY%:%MM%:%DD% : %TIME% : START CLONE of %REPO_NAME% >>  %LOGFILE%

git clone %PROTOCOL%://git@%GITSERVER%:%URLSTRING%/%REPO_NAME%.git %REPO_NAME%
ECHO %YYYY%:%MM%:%DD% : %TIME% : CLONE COMPLETE of %REPO_NAME% >>  %LOGFILE%
cd %REPO_NAME%
ECHO %YYYY%:%MM%:%DD% : %TIME% : START EXPORT of %REPO_NAME% >>  %LOGFILE%
git archive --format zip --output %EXPPATH%\%FILE_NAME%.zip master
ECHO %YYYY%:%MM%:%DD% : %TIME% : EXPORT COMPLETE of %REPO_NAME% >>  %LOGFILE%
ECHO %YYYY%:%MM%:%DD% : %TIME% : START COPY TO SHARE of %REPO_NAME% >>  %LOGFILE%
copy /B %EXPPATH%\%FILE_NAME%.zip %PROJ%
ECHO %YYYY%:%MM%:%DD% : %TIME% : COPY COMPLETE of %REPO_NAME% >>  %LOGFILE%
:FINALCOPY
echo Exported Repo %REPO_NAME% as %FILE_NAME% in %PROJ%

SET P1=\\denver2\escrow\REC\Release Branches in GIT
copy %PROJ%\%FILE_NAME%.zip "%P1%"
ECHO %YYYY%:%MM%:%DD% : %TIME% : FINAL COPY COMPLETE of %REPO_NAME% TO "%P1%" >>  %LOGFILE%

:END
ECHO %BORDER% >> %LOGFILE%
