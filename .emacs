(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'cl)
(require 'package)
;zen-and-art-theme
(setq package-list '(f dash projectile-rails rake inflections inf-ruby let-alist json-reformat json-snatcher git-commit-mode git-rebase-mode pkg-info epl android-mode ascii auctex auto-complete dired+ flycheck flymake-ruby flymake-easy fuzzy-match json json-mode keywiz lua-mode magit mic-paren mode-compile modeline-posn nhexl-mode nose popup projectile rainbow-mode s save-visited-files scala-mode smex sml-mode smooth-scrolling symbols-mode todotxt typing vlf windsize writegood-mode xlicense flx-ido))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'load-path "~/.emacs.d/elpa")  ;; add elpa load paths
(package-initialize) 

(when (not package-archive-contents)
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))




(require 'xcscope)
(add-hook 'c-mode-hook (function cscope:hook))
(add-hook 'c++-mode-hook (function cscope:hook))
(setq stack-trace-on-error t)
(setq ecb-layout-name "song")
(setq ecb-tip-of-the-day nil)
(linum-mode)
;; (ido-mode t)
;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")
(require 'auto-complete-config)
(ac-config-default)
;; (add-hook 'python-mode-hook '(lambda () 
;; 			       (flycheck-mode) 
;; ;			       (semantic-mode) 
;; 			       (setq flycheck-checker 'python-pyflakes)
;; 			       (local-set-key [f2] 'previous-error)
;; 			       (local-set-key [f3] 'next-error)
;; 			       (local-set-key [(meta /)] 'dabbrev-expand)
;; 			       ))

(add-hook 'c-mode-hook '(lambda () 
			       (flycheck-mode) 
			       (semantic-mode) 
			       (local-set-key [f2] 'previous-error)
			       (local-set-key [f3] 'next-error)
			       (local-set-key [(meta /)] 'dabbrev-expand)
			       ))

;; (define-key global-map [(ctrl f3)] 'cscope-set-initial-directory)
;; (define-key global-map [(ctrl f4)] 'cscope-unset-initial-directory)
;; (define-key global-map [(ctrl f5)] 'cscope-find-this-symbol)
;; (define-key global-map [(ctrl f6)] 'cscope-find-global-definition)
;; (define-key global-map [(ctrl f7)] 'cscope-find-global-definition-no-prompting)
;; (define-key global-map [(ctrl f8)] 'cscope-pop-mark)
;; (define-key global-map [(ctrl f9)] 'cscope-next-symbol)
;; (define-key global-map [(ctrl f10)] 'cscope-next-file)
;; (define-key global-map [(ctrl f11)] 'cscope-prev-symbol)
;; (define-key global-map [(ctrl f12)] 'cscope-prev-file)
;; (define-key global-map [(meta f9)] 'cscope-display-buffer)
;; (define-key global-map [(meta f10)] 'cscope-display-buffer-toggle) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;(define-key ropemacs-local-keymap [(meta /)] 'dabbrev-expand)
(define-key global-map [(ctrl f5)] 'compile)
(define-key global-map [(ctrl r)] 'replace-string)
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(setq ruby-deep-indent-paren nil)
(add-hook 'ruby-mode-hook 'projectile-on)
;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
  (add-hook 'ido-setup-hook 'ido-define-keys)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(tool-bar-mode -1)


(require 'save-visited-files)
(turn-on-save-visited-files-mode)
