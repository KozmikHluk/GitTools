@ECHO OFF

SET WorkingDIr=c:\zPOC
::===========================
:: New BB 5.16.11 testing inline editing via UI
:: Removed individual copies of the gitattributes 
MKDIR "%WorkingDir%"
XCOPY /D /E /I "%CD%\Scripts\*" "%WorkingDir%"
XCOPY /D /E /I "%CD%\Files\*" "%WorkingDir%"

:END
