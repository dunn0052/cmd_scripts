@echo off

IF NOT EXIST %~dp0go_shortcuts.txt (
  @echo. > %~dp0go_shortcuts.txt
)

IF [%1] == [] (
  @echo "The go command changes current directory to shortcut path"
  @echo "The shortcuts are located in %~dp0go_shortcuts.txt"
  @echo "You can shortcut the current directory by using . as the shortcut_path"
  @echo "usage:"
  @echo "go [-a] [shortcut_name] [shortcut_path]"
  @echo "go [shortcut]"
  GOTO EOF
)

IF -a == %1 (
  IF NOT [%2] == [] (
    IF NOT [%3] == [] (

    IF "%~3" == "." (
    findstr /v /b %2 %~dp0go_shortcuts.txt > go_shortcuts.txt
    @echo %2;%CD%>>%~dp0go_shortcuts.txt
    @echo Added add %2 as a shortcut to %CD%
    GOTO EOF
    )

    IF NOT EXIST "%~3" (
    @echo %3 does not exist
    GOTO EOF
    )

    findstr /v /b %2 %~dp0go_shortcuts.txt > go_shortcuts.txt
    @echo %2;%3>>%~dp0go_shortcuts.txt
    @echo Added %2 as a shortcut to %3
    GOTO EOF


     )
   )
  GOTO EOF
)

for /F "tokens=1,2 delims=;" %%a in (%~dp0go_shortcuts.txt) do (
  IF %%a == %1 (
    cd %%b
    GOTO EOF
  )
)

@echo The shortcut %1 is not found
GOTO EOF

:EOF
EXIT /B
