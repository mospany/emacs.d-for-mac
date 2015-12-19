
;;(add-to-list 'load-path "~/.emacs-config/plugins")

;;   ;; make bookmarks persistent as default
(setq-default bm-buffer-persistence t)

;;   Use the function `bm-toggle-buffer-persistence' to toggle
;;   bookmark persistence.
;;
;;   To have automagic bookmark persistence we need to add some
;;   functions to the following hooks. Insert the following code
;;   into your .emacs file:
;;
;;   If you are using desktop or other packages that restore buffers
;;   on start up, bookmarks will not be restored. When using
;;   `after-init-hook' to restore the repository, it will be restored
;;   *after* .emacs is finished. To load the repository when bm is
;;   loaded set the variable `bm-restore-repository-on-load' to t,
;;   *before* loading bm (and don't use the `after-init-hook').
;;
;;   ;; Make sure the repository is loaded as early as possible
(setq bm-restore-repository-on-load t)
(require 'bm)
;;
;;   ;; Loading the repository from file when on start up.
(add-hook' after-init-hook 'bm-repository-load)
;;
;;   ;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)
;;
;;   ;; Saving bookmark data on killing a buffer
(add-hook 'kill-buffer-hook 'bm-buffer-save)
;;
;;   ;; Saving the repository to file when on exit.
;;   ;; kill-buffer-hook is not called when Emacs is killed, so we
;;   ;; must save all bookmarks first.
(add-hook 'kill-emacs-hook '(lambda nil
                                                          (bm-buffer-save-all)
                                                          (bm-repository-save)))
;;
;;   ;; Update bookmark repository when saving the file.
(add-hook 'after-save-hook 'bm-buffer-save)
;;
;;   ;; Restore bookmarks when buffer is reverted.
(add-hook 'after-revert-hook 'bm-buffer-restore)
;;
;;
;;   The `after-save-hook' and `after-revert-hook' is not necessary to
;;   use to achieve persistence, but it makes the bookmark data in
;;   repository more in sync with the file state.
;;
;;   The `after-revert-hook' might cause trouble when using packages
;;   that automatically reverts the buffer (like vc after a check-in).
;;   This can easily be avoided if the package provides a hook that is
;;   called before the buffer is reverted (like `vc-before-checkin-hook').
;;   Then new bookmarks can be saved before the buffer is reverted.
;;
;;   ;; make sure bookmarks is saved before check-in (and revert-buffer)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)

;;   If you would like the markers on the right fringe instead of the
;;   left, add the following to line:
;;
;;   (setq bm-marker 'bm-marker-right)


;;ÊéÇ©¸ßÁÁÑùÊ½£¨ÈýÑ¡Ò»£©
;;(setq bm-highlight-style 'bm-highlight-only-line)     ;;ÐÐ¼ÓÁÁ
(setq bm-highlight-style 'bm-highlight-only-fringe)     ;;±ß¿ò¼ÓÁÁ
;;(setq bm-highlight-style 'bm-highlight-line-and-fringe) ;;ÐÐÓë±ß¿ò¶¼¼ÓÁÁ


(provide 'bookmark-settings)
