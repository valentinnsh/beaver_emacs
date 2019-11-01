(setq my_name "V.Shishkin")
;;(setq run-on-win t)
;;(setq koi8-coding t)

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

;; -----------------------Ibuffer settings-------------------
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;-----------------------Electric-modes settings-------------
(electric-pair-mode 1)

;; Delete trailing whitespaces, format buffer and untabify when save buffer
(defun format-current-buffer()
  (indent-region (point-min) (point-max)))
(defun untabify-current-buffer()
  (if (not indent-tabs-mode)
      (untabify (point-min) (point-max)))
  nil)

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
    (gruvbox-theme company org-edna ivy-explorer hydra ivy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
