;; This is GPLv2. If you still don't know the details, read
;; http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html

(defvar hugo-content-dir "~/www.hugo/content/"
  "Path to Hugo's content directory")

;; This is GPLv2. If you still don't know the details, read
;; http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html

(defun hugo-ensure-property (property)
  "Make sure that a property exists. If not, it will be created.

Returns the property name if the property has been created,
otherwise nil."
  (if (org-entry-get nil property)
      nil
    (progn (org-entry-put nil property "")
           property)))

(defun hugo-ensure-properties ()
  "This ensures that several properties exists. If not, these
properties will be created in an empty form. In this case, the
drawer will also be opened and the cursor will be positioned
at the first element that needs to be filled.

Returns list of properties that still must be filled in"
  (require 'dash)
  (let ((current-time (format-time-string (org-time-stamp-format t t) (org-current-time)))
        first)
    (save-excursion
      (unless (org-entry-get nil "TITLE")
        (org-entry-put nil "TITLE" (nth 4 (org-heading-components))))
      (setq first (--first it (mapcar #'hugo-ensure-property '("HUGO_TAGS" "HUGO_TOPICS" "HUGO_FILE"))))
      (unless (org-entry-get nil "HUGO_DATE")
        (org-entry-put nil "HUGO_DATE" current-time)))
    (when first
      (goto-char (org-entry-beginning-position))
      ;; The following opens the drawer
      (forward-line 1)
      (beginning-of-line 1)
      (when (looking-at org-drawer-regexp)
        (org-flag-drawer nil))
      ;; And now move to the drawer property
      (search-forward (concat ":" first ":"))
      (end-of-line))
    first))


;; This is GPLv2. If you still don't know the details, read
;; http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html

(defun hugo ()
  (interactive)
  (unless (hugo-ensure-properties)
    (let* ((title    (concat "title = \"" (org-entry-get nil "TITLE") "\"\n"))
           (date     (concat "date = \"" (format-time-string "%Y-%m-%d" (apply 'encode-time (org-parse-time-string (org-entry-get nil "HUGO_DATE"))) t) "\"\n"))
           (topics   (concat "topics = [ \"" (mapconcat 'identity (split-string (org-entry-get nil "HUGO_TOPICS") "\\( *, *\\)" t) "\", \"") "\" ]\n"))
           (tags     (concat "tags = [ \"" (mapconcat 'identity (split-string (org-entry-get nil "HUGO_TAGS") "\\( *, *\\)" t) "\", \"") "\" ]\n"))
           (fm (concat "+++\n"
                       title
                       date
                       tags
                       topics
                       "+++\n\n"))
           (file     (org-entry-get nil "HUGO_FILE"))
           (coding-system-for-write buffer-file-coding-system)
           (backend  'md)
           (blog))
      ;; try to load org-mode/contrib/lisp/ox-gfm.el and use it as backend
      (if (require 'ox-gfm nil t)
          (setq backend 'gfm)
        (require 'ox-md))
      (setq blog (org-export-as backend t))
      ;; Normalize save file path
      (unless (string-match "^[/~]" file)
        (setq file (concat hugo-content-dir file))
      (unless (string-match "\\.md$" file)
        (setq file (concat file ".md")))
      ;; save markdown
      (with-temp-buffer
        (insert fm)
        (insert blog)
        (untabify (point-min) (point-max))
        (write-file file)
        (message "Exported to %s" file))
      ))))

(global-set-key (kbd "M-g h") 'hugo)

(provide 'org2hugo-subtree)
