@echo OFF
REM "mk a" to make all and install
IF "%1"=="a" (
    copy Textures\InstaFlakTextures.utx ..\Textures
    copy Animations\InstaFlak.ukx ..\Animations
)
del ..\System\InstaFlak.* && ..\System\ucc.exe make