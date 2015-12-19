;;本文件主要用来画数据结构对配置
;;添加人： 莫生平  日期： 2012/07/29 22:51:47 

;; Function used to add fields of struct into a dot file (for Graphviz).
(defconst yyc/dot-head "subgraph cluster_%s {
	node [shape=record fontsize=12 fontname=Courier style=filled];
	color = lightgray;
	style=filled;
	label = \"Struct %s\";
	edge[color=\"#2e3436\"];"
  "Header part of dot file.")
(defconst yyc/dot-tail "
}"
  "Tail part of dot")
(defconst yyc/dot-node-head
  "
		node_%s[shape=record label=\"<f0>*** STRUCT %s ***|\\"
  "Format of node.")
(defconst yyc/dot-node-tail "
\"];"
  "Format of node.")
(defconst r_attr_str "[ \t]+\\(.*+\\)[ \t]+\\(.*\\)?;"
  "Regular expression for matching struct fields.")
(defconst r_name "\\_<\\(typedef[ \t]+\\)?struct[ \t]+\\(.*\\)?[ \t]*{"
  "Regular expression for mating struct name")
(defconst attr_str "
<f%d>%s %s\\l|\\" "nil")
(defun yyc/datastruct-to-dot (start end)
  "generate c++ function definition and insert it into `buffer'"
  (interactive "rp")
  (setq var-defination (buffer-substring-no-properties start end))
  (let* ((tmp_str "")
		 (var-name "")
		 (var-type "")
		 (counter 0)
		 (struct-name "")
		 (header-str "")
		 )
	(defun iter (pos)
	  (setq counter (+ counter 1))
	  (message (format "Counter: %d, pos: %d"
					   counter pos))
	  (if (string-match r_name var-defination pos)
		  (progn
			(message "A")
			(setq struct-name
				  (match-string 2 var-defination))
			(setq header-str
				  (format yyc/dot-head struct-name struct-name))
			(setq tmp_str
				  (format yyc/dot-node-head struct-name struct-name))
			(iter (match-end 0)))
		(if (string-match r_attr_str var-defination pos)
			(progn
			  (message "B")
			  (setq var-type
					(match-string 1 var-defination))
			  (setq var-name
					(match-string 2 var-defination))
			  (setq tmp_str
					(concat tmp_str
							(format attr_str counter var-type var-name)))
			  (iter (match-end 0)))
		  nil)))
	(save-excursion
	  (iter 0)
	  (set-buffer (get-buffer-create "tmp.dot"))
	  (graphviz-dot-mode)
	  (setq pos (point-max))
	  (insert  header-str tmp_str )
	  (goto-char (point-max))
	  (delete-char -1)
	  (insert "<f999>\\"yyc/dot-node-tail yyc/dot-tail)
	  )
	(if (one-window-p)
		(split-window-vertically))
	(switch-to-buffer-other-window "tmp.dot")
	(goto-char (point-min))
	)
  (message "Finished, please see *tmp.dot* buffer.")
  )


;; ************** Autoinsert templates *****************
(require 'autoinsert)
(setq auto-insert-mode t)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory "~/.emacs.d/templates/auto-insert/")
(setq auto-insert 'other)
(setq auto-insert-query nil)
;; auto-insert stuff
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-alist
	  '(
		("\\.cpp$" . ["insert.cpp" auto-update-c-source-file])
		("\\.h$"   . ["header.h" auto-update-header-file])
		("\\.c$" . ["insert.c" auto-update-c-source-file])
		("\\.org$" . ["insert.org" auto-update-defaults])
		("\\.sh$" . ["insert.sh" auto-update-defaults])
		("\\.lisp$" . ["insert.lisp" auto-update-defaults])
		("\\.el$" . ["insert.el" auto-update-defaults])
		("\\.dot$" . ["insert.dot" auto-update-defaults])
		("\\.erl$" . ["insert.err" auto-update-defaults])
		("\\.py$" . ["insert.py" auto-update-defaults])
		("\\.tex$" . ["insert.tex" auto-update-defaults])
		("\\.html$" . ["insert.html" auto-update-defaults])
		("\\.devhelp2$" . ["insert.devhelp2" auto-update-defaults])
		("\\.ebuild$" . ["insert.ebuild" auto-update-defaults])
		("\\.sh$" . ["insert.sh" auto-update-defaults])
		("Doxyfile$" . ["insert.doxyfile" auto-update-defaults])
		))
;; function replaces the string '@@@' by the current file
;; name. You could use a similar approach to insert name and date into
;; your file.
(defun auto-update-header-file ()
  (save-excursion
	(while (search-forward "@@@" nil t)
	  (save-restriction
		(narrow-to-region (match-beginning 0) (match-end 0))
		(replace-match (upcase (file-name-nondirectory buffer-file-name)))
		(subst-char-in-region (point-min) (point-max) ?. ?_)
		))
	)
  )
(defun insert-today ()
  "Insert today's date into buffer"
  (interactive)
  (insert (format-time-string "%m-%e-%Y" (current-time))))
(defun auto-update-c-source-file ()
  (save-excursion
	;; Replace HHHH with file name sans suffix
	(while (search-forward "HHHH" nil t)
	  (save-restriction
		(narrow-to-region (match-beginning 0) (match-end 0))
		(replace-match (concat (file-name-sans-extension (file-name-nondirectory buffer-file-name)) ".h") t
					   )
		))
	)
  (save-excursion
	;; Replace @@@ with file name
	(while (search-forward "@@@" nil t)
	  (save-restriction
		(narrow-to-region (match-beginning 0) (match-end 0))
		(replace-match (file-name-nondirectory buffer-file-name))
		))
	)
  (save-excursion
	;; replace DDDD with today's date
	(while (search-forward "DDDD" nil t)
	  (save-restriction
		(narrow-to-region (match-beginning 0) (match-end 0))
		(replace-match "")
		(insert-today)
		))
	)
  )
(defun auto-replace-file-name ()
  (save-excursion
	;; Replace @@@ with file name
	(while (search-forward "(>>FILE<<)" nil t)
	  (save-restriction
		(narrow-to-region (match-beginning 0) (match-end 0))
		(replace-match (file-name-nondirectory buffer-file-name) t)
		))
	)
  )
(defun auto-update-defaults ()
  (auto-replace-file-name)
  (auto-replace-file-name-no-ext)
  (auto-replace-date-time)
  )
(defun auto-replace-file-name-no-ext ()
  (save-excursion
	;; Replace @@@ with file name
	(while (search-forward "(>>FILE_NO_EXT<<)" nil t)
	  (save-restriction
		(narrow-to-region (match-beginning 0) (match-end 0))
		(replace-match (file-name-sans-extension (file-name-nondirectory buffer-file-name)) t)
		))
	)
  )
(defun auto-replace-date-time ()
  (save-excursion
	(while (search-forward "(>>DATE<<)" nil t)
	  (save-restriction
		(narrow-to-region (match-beginning 0) (match-end 0))
		(replace-match "" t)
		(insert-today)
		))))

