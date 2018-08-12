(setq org-publish-project-alist
      '(
        ("mospan-blog"
         ;; Path to org files
         :base-directory "/myblog/org-content/"
         :base-extension "org"

         ;; Path to hugo project
         :publishing-directory "/myblog/content/"
         :recursive t
         :publishing-function gp-org-gfm-publish-to-md
         )

        ))

(defun gp-org-gfm-publish-to-md (plist filename pub-dir)
  "Publish an org file to Github Flavoured Markdown.

FILENAME is the filename of the Org file to be published.  PLIST
is the property list for the given project.  PUB-DIR is the
publishing directory.

Return output file name."
  (org-publish-org-to 'gfm filename ".md" plist pub-dir))

(global-set-key (kbd "C-c C-e P m") 'gp-org-gfm-publish-to-md)

(provide 'org2hugo-single)
