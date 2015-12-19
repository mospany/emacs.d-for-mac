
@echo off


SET EMACS_BIN=F:\DevPlatform\emacs-23.4\bin
SET PATH=%EMACS_BIN%;%PATH%;

emacs -Q -l cedet-build.el -f cedet-build

pause
