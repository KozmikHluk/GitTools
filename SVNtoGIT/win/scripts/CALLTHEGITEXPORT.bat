@ECHO OFF


FOR /f "tokens=1 delims=," %%A in (reponamesgit.txt) do (CALL GITExport_FILEINPUT.cmd %%A)

:END


