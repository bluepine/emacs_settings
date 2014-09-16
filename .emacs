(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'cl)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar required-packages '(save-visited-files xcscope pymacs fuzzy-match igrep ioccur json json-mode keywiz mic-paren mode-compile modeline-posn nhexl-mode nose popup python-mode rainbow-mode s scala-mode smex sml-mode symbols-mode todotxt typing vlf windsize  writegood-mode xlicense zen-and-art-theme)
  "A list of packages to ensure are installed at launch.")
					; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

					; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
					; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
					; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(dolist (p required-packages) (require p))


(setq stack-trace-on-error t)
(setq ecb-layout-name "song")
(setq ecb-tip-of-the-day nil)
(linum-mode)
;(ido-mode t)
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(require 'auto-complete-config)
(ac-config-default)
(add-hook 'python-mode-hook '(lambda () 
			       (flycheck-mode) 
			       (setq flycheck-checker 'python-pyflakes)
			       (local-set-key [f2] 'previous-error)
			       (local-set-key [f3] 'next-error)
			       (local-set-key [(meta /)] 'dabbrev-expand)
			       ))
(require 'save-visited-files)
(turn-on-save-visited-files-mode)

(require 'xcscope)
(define-key global-map [(ctrl f3)] 'cscope-set-initial-directory)
(define-key global-map [(ctrl f4)] 'cscope-unset-initial-directory)
(define-key global-map [(ctrl f5)] 'cscope-find-this-symbol)
(define-key global-map [(ctrl f6)] 'cscope-find-global-definition)
(define-key global-map [(ctrl f7)] 'cscope-find-global-definition-no-prompting)
(define-key global-map [(ctrl f8)] 'cscope-pop-mark)
(define-key global-map [(ctrl f9)] 'cscope-next-symbol)
(define-key global-map [(ctrl f10)] 'cscope-next-file)
(define-key global-map [(ctrl f11)] 'cscope-prev-symbol)
(define-key global-map [(ctrl f12)] 'cscope-prev-file)
(define-key global-map [(meta f9)] 'cscope-display-buffer)
(define-key global-map [(meta f10)] 'cscope-display-buffer-toggle) 
(tool-bar-mode -1)
