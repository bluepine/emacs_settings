					;(load "~/adk/android-sdk-mac_x86/tools/lib/android.el")

					;(setq mac-command-modifier 'meta)
(setq load-path (cons "~/git/emacs_settings/etc" load-path))
(load "xcscope.el")
(load "mark.el")
(load "sams-lib.el")
(load "text.el")
(load "window.el")
(load "yic-buffer.el")
(load "flymake-cursor.el")
					;(load "jtags.el")
					;(load "jtags-extras.el")
					;(setq tags-auto-read-changed-tag-files 't)
(require 'git)
(require 'git-blame)
					;(require 'android)
(require 'xcscope)
(require 'color-theme)

(ansi-color-for-comint-mode-on)
(set-cursor-color "red")
(display-time)
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1))
(setq transient-mark-mode t)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 
					;(autoload 'matlab-mode "~/etc/matlab.el" "Enter Matlab mode." t)
					;(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
					;(autoload 'matlab-shell "~/etc/matlab.el" "Interactive Matlab mode." t)
(add-hook 'java-mode-hook (function cscope:hook))
(add-hook 'python-mode-hook (function cscope:hook))

					;(color-theme-euphoria)
(load "key.el")
					;(setq x-select-enable-clipboard t)
(tool-bar-mode -1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.9))
;; add pylookup to your loadpath, ex) ~/.emacs.d/pylookup
(setq pylookup-dir "/home/song/git/pylookup")
(add-to-list 'load-path pylookup-dir)
(eval-when-compile (require 'pylookup))
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)
(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
					;(pymacs-load "ropemacs" "rope-")
					;(setq ropemacs-enable-autoimport t)
(require 'auto-complete)
(global-auto-complete-mode t)
					;(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
					;)
(require 'ecb)
(setq stack-trace-on-error t)
(setq ecb-source-file-regexps (quote ((".*" ("\\(^\\(\\.\\|#\\)\\|\\(~$\\|\\.\\(pyc\\|elc\\|obj\\|o\\|class\\|lib\\|dll\\|a\\|so\\|cache\\)$\\)\\)") ("^\\.\\(emacs\\|gnus\\)$")))))
(setq ecb-show-sources-in-directories-buffer '("python2"))
(setq ecb-layout-name "python2")
(setq ecb-tip-of-the-day nil)
(require 'cedet-files)
(semantic-mode t)
;; Turn on semantic
(setq semantic-load-turn-everything-on t)

(setq pycodechecker "pyflakes")
(require 'tramp-cmds)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
					; Make sure it's not a remote buffer or flymake would not work
    (when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "pyflakes" (list local-file)))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'python-mode-hook 
	  (lambda () 
	    (unless (eq buffer-file-name nil) (flymake-mode 1)) ;dont invoke flymake on temporary buffers for the interpreter
	    (local-set-key [f2] 'flymake-goto-prev-error)
	    (local-set-key [f3] 'flymake-goto-next-error)
	    ))

(require 'el-get)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.
(setq
 el-get-sources
 '(el-get				; el-get is self-hosting
   escreen            			; screen for emacs, C-\ C-h
   switch-window			; takes over C-x o
   ac-python
   smart-operator
   zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
))


;; install new packages and init already installed packages
(el-get 'sync)
(add-hook 'c-mode-common-hook 'smart-insert-operator-hook)
