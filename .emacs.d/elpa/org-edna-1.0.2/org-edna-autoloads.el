;;; org-edna-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "org-edna" "org-edna.el" (0 0 0 0))
;;; Generated autoloads from org-edna.el

(autoload 'org-edna-load "org-edna" "\
Setup the hooks necessary for Org Edna to run.

This means adding to `org-trigger-hook' and `org-blocker-hook'.

\(fn)" t nil)

(autoload 'org-edna-unload "org-edna" "\
Unload Org Edna.

Remove Edna's workers from `org-trigger-hook' and
`org-blocker-hook'.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-edna" '("org-edna-")))

;;;***

;;;### (autoloads nil "org-edna-tests" "org-edna-tests.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from org-edna-tests.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-edna-tests" '("org-edna-")))

;;;***

;;;### (autoloads nil nil ("org-edna-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-edna-autoloads.el ends here
