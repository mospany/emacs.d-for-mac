#!/bin/sh
#tar -zcvf mosp_emacs_YYMMDD.tgz .emacs .emacs.d .emacs-places .eshell .stardict .todos .xmodmap .emacs-install .todos .mew.el .signature
rm -rf .emacs.d/semantic.cache/*
cd ~
sudo tar -zcvf mosp_mac_emacs24.5.2_vi_`date +%F`.tgz  .emacs.d .emacs-places .eshell .stardict .xmodmap .mew.el .signature \
      .config/system-config/emacs-font-size

