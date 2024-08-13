@ECHO OFF
SET REV=276098
SET REPO_NAME=WebHelp

CALL 30_GITExport.cmd

::IF NOT EXIST .gitattributes 
::copy \\denver2\git\GITLFS\AttributesFile\.gitattributes .gitattributes
::GOTO

CALL %CD%/../20_ExportDataEscrow.bat svnurl_%REPONAME%.txt %REV%

:PUSHTOGIT
git push origin master


:MoveFiles
SET MM=%DATE:~4,2%
SET DD=%DATE:~7,2%
SET YYYY=%DATE:~10,4%

SET PROJ=\\denver2\GIT\SVNtoGIT\rawexport
SET P2=\\denver2\GIT\SVNtoGIT\Media Content in SVN
::SET P3=\\denver2\GIT\SVNtoGIT\Recruiting Help Site in SVN

::copy %PROJ%\deployment-and-tools.rar "%P2%\deployment-and-tools_%YYYY%-%MM%-%DD%.rar"
::copy %PROJ%\knowledge.ultipro.com.rar "%P3%\knowledge.ultipro.com_%YYYY%-%MM%-%DD%.rar"





:END
PAUSE