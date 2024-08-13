::##GIT ARCHIVE for DATA ESCROW 
@ECHO OFF

SET REPO_NAME=%1
SET PLATFORM=4
SET PK=%2
SET UTIL=c:\zPOC
SET TEST=0

SET PROJ=\\denver2\escrow\REC\rawexport

SET EXPPATH=e:\e
SET gitlab=d52tglbwb01.dev.us.corp
SET gitlaburl=git@%gitlab%:%pk%/%repo_name%
set github=d52tghbap01.dev.us.corp
set githuburl=git@%github%:ultimate/%pk%-%repo_name%
set bbssh=ssh://git@ultigit02.ultimatesoftware.com:7999
set bburl=%bbssh%/%PK%/%REPO_NAME%
SET MM=%DATE:~4,2%
SET DD=%DATE:~7,2%
SET YYYY=%DATE:~10,4%
SET FILE_NAME=%REPO_NAME%_%YYYY%-%MM%-%DD%
SET LOGFILE=%CD%\%REPO_NAME%.log
SET SERVERURL=ultigit.ultimatesoftware.com
ECHO #%YYYY%:%MM%:%%DD% >> %LOGFILE%
ECHO %YYYY%:%MM%:%%DD%:%TIME% START CLONE of %REPO_NAME% >>  %LOGFILE%
ECHO ----------------------------------------------------
ECHO     -----------------------------------------
ECHO           ----------------------------
ECHO                 ---------------
ECHO                       ---

ECHO You are about to run: git clone --mirror ssh://git@%SERVERURL%:7999/%PK%/%REPO_NAME% %UTIL%\%REPO_NAME%
ECHO Are you in testmode 1=Yes 0=No: 
IF %TEST%==1 GOTO END
git clone --mirror ssh://git@%SERVERURL%:7999/%PK%/%REPO_NAME% %UTIL%\%REPO_NAME%
ECHO %YYYY%:%MM%:%%DD%:%TIME% CLONE COMPLETE of %REPO_NAME% >>  %LOGFILE%
cd %UTIL%\%REPO_NAME%

ECHO %YYYY%:%MM%:%%DD%:%TIME% START EXPORT of %REPO_NAME% >>  %LOGFILE%
::#git archive --format zip --output %EXPPATH%\%FILE_NAME%.zip master
git lfs fetch --all
ECHO %YYYY%:%MM%:%%DD%:%TIME% EXPORT COMPLETE of %REPO_NAME% >>  %LOGFILE%
ECHO %YYYY%:%MM%:%%DD%:%TIME% START COPY TO SHARE of %REPO_NAME% >>  %LOGFILE%
::#copy /B %EXPPATH%\%FILE_NAME%.zip %PROJ%
git remote -v
if %platform%==2 SET newrepourl=%gitlaburl%
if %platform%==3 SET newrepourl=%githuburl%
if %platform%==4 SET newrepourl=%bburl%
if %platform%==1 GOTO :END
git remote set-url origin %newrepourl%
git remote -v

ECHO %YYYY%:%MM%:%%DD%:%TIME% COPY COMPLETE of %REPO_NAME% >>  %LOGFILE%
:FINALCOPY
git push --mirror
git lfs push --all origin
if %platform%==4 goto :END
::Reset the same local repo with other platform
:TWO_AT_THE_SAME_TIME
::When platform is 2 then it will just run this section
SET newrepourl=%githuburl%
git remote set-url origin %newrepourl%
git remote -v
git push --mirror
git lfs push --all origin

echo Exported Repo %REPO_NAME% as %FILE_NAME% in %PROJ%

cd %UTIL%
rd /S /Q %UTIL%\%REPO_NAME%
::SET P1=\\denver2\escrow\REC\Release Branches in GIT
::copy %PROJ%\%FILE_NAME%.zip "%P1%"
GOTO END

:END
ECHO                       ---
ECHO                 ---------------
ECHO           ----------------------------
ECHO     -----------------------------------------
ECHO ----------------------------------------------------
