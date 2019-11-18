(setq package-enable-at-startup nil) (package-initialize)
(load-theme 'gruvbox-dark-hard t)
(setq my_name "V.Shishkin")
;;(setq run-on-win t)
;;(setq koi8-coding t)

;; fonts-settings
(add-to-list 'default-frame-alist '(font . "-SRC-Hack-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"))

;;abbrew mode
(setq-default abbrev-mode t)
(desktop-save-mode 1)
(blink-cursor-mode -1)
;; show tabs
(setq x-stretch-cursor t)
(mouse-avoidance-mode 'exile)

(defun my-clipboard-copy(beg end)
  "Save selected text to clipboard."
  (interactive "r")
  (setq select-enable-clipboard 't)
  (kill-ring-save beg end)
  (setq select-enable-clipboard 'nil)
  )

;; Line wrapping

(setq word-wrap t) ;; переносить  по словам

;;
;; my hotkeys
;;

(global-set-key [A-insert] 'my-clipboard-copy)
(global-unset-key [home])
(global-set-key [home] 'beginning-of-line)
(global-unset-key [end])
(global-set-key [end] 'end-of-line)
(global-set-key [C-home] 'beginning-of-buffer)
(global-set-key [C-end] 'end-of-buffer)
(global-unset-key [f2])
(global-set-key [f2] 'save-buffer)
(defun my-save-all ()
  "Unconditionally save all file buffers"
  (interactive)
  (save-some-buffers 't nil)
  )
(global-set-key [C-f2] 'my-save-all)
(global-set-key [f3] 'find-file)
(defun find-current-file ()
  (interactive)
  (find-file (buffer-file-name))
  )
(global-set-key [C-f3] 'find-current-file) ;in fact - reload
(global-set-key [f4] 'switch-to-buffer)
(global-set-key [C-f4] 'kill-buffer)
(global-set-key [f7] 'compile)
(global-set-key [C-f8] 'next-error)

(global-set-key [f10] 'man)

(global-set-key [S-delete] 'delete-region)
(global-set-key [delete] 'delete-char)
(global-set-key [C-backspace] 'backward-kill-word)
(global-set-key [C-delete] 'kill-word)
(global-set-key [M-backspace] 'join-line)
(global-set-key [S-backspace] 'kill-whole-line)

(global-set-key [f11] 'delete-trailing-whitespace)
(global-set-key [f12] 'expand-abbrev)
(global-set-key [C-f12] 'abbrev-mode)
(global-set-key [C-f11] 'toggle-truncate-lines)

;; TODO - read about abbrev mode

;;----------------------MELPA repo-------------------------
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
(package-initialize)
;;------------------------some mode settings-----------------
(ivy-mode 1) ;; ivy for better search
(tool-bar-mode -1) ;;disable toolbar
(menu-bar-mode -1)
(global-visual-line-mode t)
(show-paren-mode 1)
(setq show-paren-style 'expression)
(global-linum-mode t)

;; Eshell tab completion like in bash
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))
(setq eshell-cmpl-cycle-completions nil)

;;Tramp mode
(setq tramp-default-method "ssh")
;;-----Electric-modes settings----------
(electric-pair-mode 1)

;; Delete trailing whitespaces, format buffer and untabify when save buffer
(defun format-current-buffer()
  (indent-region (point-min) (point-max)))
(defun untabify-current-buffer()
  (if (not indent-tabs-mode)
      (untabify (point-min) (point-max)))
  nil)
;; (add-to-list 'write-file-functions 'format-current-buffer) -- Do not uncomment that thing. It will break saving
(add-to-list 'write-file-functions 'untabify-current-buffer)
(add-to-list 'write-file-functions 'delete-trailing-whitespace)

;; -----------------------Ibuffer settings-------------------
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(setq ibuffer-expert t)
;; Define ibuffer filter groups for each known project
(setq ibuffer-saved-filter-groups
      '(("home"
	 ("emacs-config" (or (filename . ".emacs.d")
			     (filename . "emacs")))
	 ("Org" (or (mode . org-mode)
		    (filename . "OrgMode")))
	 ("remote" (or (filename . "sftp")
		       (filename . "ssh")))
	 )))
;;-----------------------Neotree settings--------------------
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;;----------------------memoize----------------------------
(add-to-list 'load-path "~/.emacs.d/emacs-memoize")
(require 'memoize)

;;-----------------------All-the-icons----------------------
(add-to-list 'load-path "~/.emacs.d/all-the-icons")
(require 'all-the-icons)

;;-----------------------Company-completion----------------
(add-hook 'after-init-hook 'global-company-mode)

;;-----------------------Tramp activation------------------
(require 'tramp)
(setq tramp-verbose 10)
(setq tramp-default-method "sftp")
(define-key global-map (kbd "C-c s") 'counsel-tramp)
(setq dired-dwim-target t)

;;-------------------------Magit---------------------------
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)
;;ack-mode-hook 'turn-on-font-lock)
(add-hook 'html-mode-hook 'turn-on-font-lock)
(add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
(add-hook 'sgml-mode-hook 'turn-on-font-lock)
(add-hook 'diff-mode-hook 'turn-on-font-lock)
(add-hook 'text-mode-hook 'auto-fill-mode)

(setq grep-find-use-xargs 't)
(fset 'my-split-params
      [home ?\C-s ?, left right return tab])

(defun my-insert-file-name()
  (interactive)
  (insert (file-name-nondirectory (buffer-file-name)))
  )

;; print expression on alt-left mouse button
(defun my-gprint(event)
  ;; print expression on mouse click
  (interactive "e")
  (mouse-set-point event)
  (gud-print (point))
  )
;; print *expression on shift-alt-left mouse
(defun my-gprint-deref(event)
  ;; print dereferenced expression on mouse click
  (interactive "e")
  (mouse-set-point event)
  (gud-print-deref (point))
  )
(defun my-gud-print-reg(beg end)
  (interactive "r")
  (let (regval)
    (setq regval (buffer-substring beg end))
    (gud-call (concat "print " regval))
    )
  )

;; add FILE, *_t, t_* to types list

(defun c-semi&comma-my-inside-parenlist ()
  "Controls newline insertion after semicolons in parenthesis lists.
TODO : no newline after comma inside 'for' statement"
  (cond ((eq last-command-char ?\,)
	 (save-excursion
	   (c-end-of-statement)
	   (not (eq (char-before) ?\())
	   ;;(up-list -1)
	   ;;(eq (char-after) ?\()
	   )
         )

	nil;; continue checking
	)
  )

(defconst c-expand-list
  '(
    ("main" "int\nmain(\nint argc,\n char **argv){\n   \n}\n" 39)
    ("if" "if (){\n\n}\n" (5 8))
    ("else" "else\n{\n\n}\n" (8))
    ("elsi" "else if ()\n{\n\n}\n" (10 12 21))
    ("ife" "if ()\n{\n\n}\nelse\n{\n\n}\n" (5 10 21))
    ("for" "for (;;)\n{\n\n}\n" (6 7 9 13))
    ("fori" "for (i = 0 ; i <  ; ++i)\n{\n\n}\n" (18))
    ("forj" "for (j = 0 ; j <  ; ++j)\n{\n\n}\n" (18))
    ("fork" "for (k = 0 ; k <  ; ++k)\n{\n\n}\n" (18))
    ("switch" "switch ()\n{\ncase :\nbreak;\ndefault:\nbreak;\n}\n" (9 13))
    ("case" "case :\n\nbreak;\n" (6 8 16))
    ("do" "do\n{\n  \n}\n while ();\n" (8 17))
    ("while" "while ()\n{\n\n}\n" (8 12))
    ("ifr" "if (ret == RET_OK)\n{\n\n}\n" (22))
    ("ifrok" "if (ret == RET_OK)\n{" (20))
    ("ifnr" "if (ret != RET_OK)\n{\n\n}\n" (22))
    ("rok" "ret == RET_OK" (14))
    ("break" " /* BREAK LOOP */\nbreak;\n" (25))
    ("cont" " /* CONTINUE */\ncontinue;\n" (26))
    ("fdoc" "/**\n * @brief \n * \n *\n * @param \n *\n * @return \n */" (15))
    ("par" " * @param " (10))
    )
  "Expansions for C mode")

(defconst my-c-style
  '("ellemtel"
    (c-basic-offset . 2)
    (c-offsets-alist
     (inclass . +)
     )
    )
  )

(defun my-center-line(in-line line-len)
  (let (
	(left-off (/ (- line-len (length in-line)) 2))
	)
    (concat (make-string left-off ? ) in-line
	    (make-string (- line-len (length in-line) left-off) ? ))
    )
  )

(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (c-add-style "my" my-c-style)
	     (c-set-style "my")
	     (c-toggle-auto-state -1)
	     (imenu-add-menubar-index)
	     (font-lock-mode 1)
	     (expand-add-abbrevs c-mode-abbrev-table c-expand-list)
	     (expand-add-abbrevs c++-mode-abbrev-table c-expand-list)
	     (abbrev-mode -1)
	     (setq show-trailing-whitespace t)
					;      (gtags-mode 1)
	     (c-toggle-hungry-state 1)
	     (hl-line-mode 1)
	     (auto-fill-mode -1)
	     (set-fill-column 80)
	     (unless (or (file-exists-p "makefile")
			 (file-exists-p "Makefile"))
	       (set (make-local-variable 'compile-command)
		    (concat "gcc -W -Wall -g -o " (file-name-base buffer-file-name) " " (file-name-nondirectory buffer-file-name)))
	       )
	     )
	  )

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (c-add-style "my" my-c-style)
	     (c-set-style "my")
	     (c-toggle-auto-state -1)
	     (imenu-add-menubar-index)
	     (font-lock-mode 1)
             (expand-add-abbrevs c-mode-abbrev-table c-expand-list)
             (expand-add-abbrevs c++-mode-abbrev-table c-expand-list)
             (abbrev-mode -1)
             (setq show-trailing-whitespace t)
                                        ;      (gtags-mode 1)
             (c-toggle-hungry-state 1)
             (hl-line-mode 1)
             (auto-fill-mode -1)
             (set-fill-column 80)
             (unless (or (file-exists-p "makefile")
                         (file-exists-p "Makefile"))
               (set (make-local-variable 'compile-command)
                    (concat "g++ -W -Wall -g -o " (file-name-base buffer-file-name) " " (file-name-nondirectory buffer-file-name) " -std=c++11"))
               )
             )
          )

;;Fortran90
(add-hook 'f90-mode-hook
          '(lambda ()
             (imenu-add-menubar-index)
             (font-lock-mode 1)
             (abbrev-mode -1)
             (setq show-trailing-whitespace t)
             (hl-line-mode 1)
             (auto-fill-mode -1)
             (set-fill-column 100)
             (unless (or (file-exists-p "makefile")
                         (file-exists-p "Makefile"))
               (set (make-local-variable 'compile-command)
                    (concat "gfortran -W -Wall -g -o " (file-name-base buffer-file-name) " " (file-name-nondirectory buffer-file-name)))
               )
             )
          )


;;Pascal mode
(require 'compile)
(defun pascal-mode-additional-init ()
  (local-set-key "\C-c\C-c" 'compile)
  (unless (or (file-exists-p "makefile")
	      (file-exists-p "Makefile"))
    (set (make-local-variable 'compile-command)
	 (concat "fpc -g " buffer-file-name)))
  (font-lock-add-keywords 'pascal-mode
			  '(("^[ \t]*\\(uses\\)\\>[ \t]*\\([a-z]\\)" 1 font-lock-keyword-face prepend))))

					;("^\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\),\\([0-9]+\\))\s\\(.*$\\)" 1 2 3)


(add-hook 'pascal-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "fpc -g " (file-name-nondirectory (buffer-file-name)))
                 )
	    )
	  t)

;;Pascal mode
					; '(compilation-error-regexp-alist
					;   '("^\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\),\\([0-9]+\\))\s\\(.*$\\)" 1 2 3))


(defun pas-auto-insert-file()
  (interactive)
  (insert   "(*\n"
	    " * Copyright (c) " (format-time-string "%Y" (current-time)) " " my_name "\n"
	    " *)\n")
  )

(defun c-auto-insert-file()
  (interactive)
  (insert   "/*\n"
	    " * Copyright (c) " (format-time-string "%Y" (current-time)) " " my_name "\n"
	    " *\n"
	    " */\n"
	    "\n"
	    "#include <stdio.h>\n"
	    )
  )

(defun cpp-auto-insert-file()
  (interactive)
  (insert   "/*\n"
	    " * Copyright (c) " (format-time-string "%Y" (current-time)) " " my_name "\n"
	    " *\n"
	    " */\n"
	    "\n"
	    "#include <iostream>\n"
	    )
  )
(defun f90-auto-insert-file()
  (interactive)
  (insert "!\n"
	  "! Copyright (c) " (format-time-string "%Y" (current-time)) " " my_name "\n"
	  "!\n\n\n"
	  "program  \nimplicit none\n\n"
	  "end program"
	  )
  )

(defun my-auto-insert ()
  (cond
   ((string-match "\\.pas$" (buffer-file-name)) (pas-auto-insert-file))
   ((string-match "\\.c$" (buffer-file-name)) (c-auto-insert-file))
   ((string-match "\\.cpp$" (buffer-file-name)) (cpp-auto-insert-file))
   ((string-match "\\.f90$" (buffer-file-name)) (f90-auto-insert-file))
                                        ;((string-match "\\.tex$" (buffer-file-name)) (tex-auto-insert-file))
   nil
   )
  )

;;----------------------Hooks--------------------------------
(add-hook 'find-file-not-found-functions 'my-auto-insert)
(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "home")))


;;###########################################################
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default)))
 '(package-check-signature nil)
 '(package-selected-packages
   (quote
    (counsel-tramp magit elpy color-theme gruvbox-theme company org-edna ivy-explorer hydra ivy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
