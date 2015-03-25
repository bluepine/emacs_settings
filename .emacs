;;;;;;;;;;;;;;;;;;;;package
;slime
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'cl)
(require 'package)
(setq package-list '(f dash projectile-rails rake inflections inf-ruby let-alist json-reformat json-snatcher git-commit-mode git-rebase-mode pkg-info epl android-mode ascii auctex auto-complete dired+ flycheck flymake-ruby flymake-easy fuzzy-match json json-mode keywiz lua-mode magit mic-paren mode-compile modeline-posn nhexl-mode nose popup projectile rainbow-mode s save-visited-files scala-mode smex sml-mode smooth-scrolling symbols-mode todotxt typing vlf windsize writegood-mode xlicense flx-ido enh-ruby-mode ag smartparens grizzl robe project-explorer js2-mode textmate cider js-comint))
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

;;;;;;;;;;;;;;;;general
(require 'auto-complete-config)
(ac-config-default)
(define-key global-map [(ctrl f5)] 'compile)
(define-key global-map [(ctrl r)] 'replace-string)

;;;;;;;;;;;;;;;;;;;;c and cpp
(require 'xcscope)
(add-hook 'c-mode-hook (function cscope:hook))
(add-hook 'c++-mode-hook (function cscope:hook))
(linum-mode)
(add-hook 'c-mode-hook '(lambda () 
			  (flycheck-mode) 
			  (semantic-mode) 
			  (local-set-key [f2] 'previous-error)
			  (local-set-key [f3] 'next-error)
			  (local-set-key [(meta /)] 'dabbrev-expand)))
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
					;(define-key ropemacs-local-keymap [(meta /)] 'dabbrev-expand)
;;			  ))

;;;;;;;;;;;;;;;;;;;python
;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")
;; (add-hook 'python-mode-hook '(lambda () 
;; 			       (flycheck-mode) 
;; ;			       (semantic-mode) 
;; 			       (setq flycheck-checker 'python-pyflakes)
;; 			       (local-set-key [f2] 'previous-error)
;; 			       (local-set-key [f3] 'next-error)
;; 			       (local-set-key [(meta /)] 'dabbrev-expand)
;; 			       ))


;;;;;;;;;;;;;;;;;;;;;ruby
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
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "s-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)



;;;;;;;;;;;;;;;;;;;;;;;javascript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        ;; (add-to-list
        ;;  'comint-preoutput-filter-functions
        ;;  (lambda (output)
        ;;    (replace-regexp-in-string "\033\\[[0-9]+[GK]" "" output)))
	))
(setenv "NODE_NO_READLINE" "1")
(setq inferior-js-program-command "node --interactive")
;; (global-set-key [f5] 'slime-js-reload)
;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (slime-js-minor-mode 1)))
;; (add-hook 'css-mode-hook
;;           (lambda ()
;;             (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
;;             (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))

;;;;;;;;;;;;;;;;;;final


(tool-bar-mode -1)
(require 'save-visited-files)
(turn-on-save-visited-files-mode)


