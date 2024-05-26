;;;;;;;;;;;;;;;;;;;;package
;slime
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'cl)
(require 'package)
					;(setq package-list '(f dash projectile-rails rake inflections inf-ruby let-alist json-reformat json-snatcher git-commit-mode git-rebase-mode pkg-info epl android-mode ascii auctex auto-complete dired+ flycheck flymake-ruby flymake-easy fuzzy-match json json-mode keywiz lua-mode magit mic-paren mode-compile modeline-posn nhexl-mode nose popup projectile rainbow-mode s save-visited-files scala-mode smex sml-mode smooth-scrolling symbols-mode todotxt typing vlf windsize writegood-mode xlicense flx-ido enh-ruby-mode ag smartparens grizzl robe project-explorer js2-mode textmate js-comint clojure-mode clj-refactor align-cljlet paredit company clojure-snippets))
(setq package-list '( dash    let-alist json-snatcher  pkg-info  auctex auto-complete flycheck  flymake-easy  json json-mode magit mic-paren nhexl-mode  popup projectile rainbow-mode s save-visited-files  smex sml-mode smooth-scrolling  todotxt typing vlf windsize writegood-mode ag smartparens grizzl robe project-explorer  textmate  paredit company markdown-mode treesit-auto julia-ts-mode flycheck-julia eglot-jl gh-md jupyter vterm-toggle vterm julia-snail  dired-git-info))
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
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



;;;;;;;;;;;;;;;;ido
;; (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;; (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
;; (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
;;   (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
;;   (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
;; (add-hook 'ido-setup-hook 'ido-define-keys)
;; (ido-mode)
;;;;;;;;;;;;;;;;;;;;projectile
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "s-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)

;;;;;;;;;;;;;;;;;;;;c and cpp
(require 'xcscope)
(add-hook 'c-mode-hook (function cscope:hook))
(add-hook 'c++-mode-hook (function cscope:hook))
;(linum-mode)
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
(add-hook 'python-mode-hook '(lambda () 
			       (flycheck-mode) 
			       (semantic-mode) 
			       (setq flycheck-checker 'python-pyflakes)
			       (local-set-key [f2] 'previous-error)
			       (local-set-key [f3] 'next-error)
			       (local-set-key [(meta /)] 'dabbrev-expand)
			       ))


;;;;;;;;;;;;;;;;;;;;;ruby
;; (require 'flymake-ruby)
;; (add-hook 'ruby-mode-hook 'flymake-ruby-load)
;; (setq ruby-deep-indent-paren nil)
;; (add-hook 'ruby-mode-hook 'projectile-on)
;;Display ido results vertically, rather than horizontally
;(add-hook 'projectile-mode-hook 'projectile-rails-on)



;;;;;;;;;;;;;;;;;;;;;;;javascript
;; (autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (setq inferior-js-mode-hook
;;       (lambda ()
;;         ;; We like nice colors
;;         (ansi-color-for-comint-mode-on)
;;         ;; Deal with some prompt nonsense
;;         ;; (add-to-list
;;         ;;  'comint-preoutput-filter-functions
;;         ;;  (lambda (output)
;;         ;;    (replace-regexp-in-string "\033\\[[0-9]+[GK]" "" output)))
;; 	))
;; (setenv "NODE_NO_READLINE" "1")
;; (setq inferior-js-program-command "node --interactive")
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

;;clojure
;; (load "clojure")

;; (require 'package)
;; (setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;                          ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;; (package-initialize) ;; You might already have this line


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    '("8746b94181ba961ebd07c7397339d6a7160ee29c75ca1734aa3744274cbe0370" "b5c3c59e2fff6877030996eadaa085a5645cc7597f8876e982eadc923f597aca" "2628939b8881388a9251b1bb71bc9dd7c6cffd5252104f9ef236ddfd8dbbf74a" "ee29cabce91f27eb1f9540ceb2bb69b4c509cd5d3bb3e6d8ad3a4ab799ebf8f7" "2415b0f51d27e127c8d0980865c79420bc0da21da68d019a09684856320f537f" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "ae69a486b10ff74fc6eb24cb01793bb1092a951e90e42a1084e8ecaf8b9c5258" "6a948097182a7f975fbff55da5979989a8dc1f1ed47a6344c5c9579c0a55316e" "ee0785c299c1d228ed30cf278aab82cf1fa05a2dc122e425044e758203f097d2" default))
;;  '(ispell-dictionary nil)
;;  '(package-selected-packages
;;    '(markdown-mode treesit-auto julia-ts-mode flycheck-julia eglot-jl gh-md jupyter vterm-toggle vterm julia-snail magit dired-git-info)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
;; (tool-bar-mode -1) 
;; ;(load-theme 'modus-vivendi  t)
(setq visible-bell t) 
(set-face-attribute 'default nil :family "Hack" :height 140) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(counsel-at-point counsel swiper ivy-fuz ivy xcscope writegood-mode windsize vterm-toggle vlf typing treesit-auto todotxt textmate smooth-scrolling sml-mode smex smartparens save-visited-files robe rainbow-mode projectile project-explorer pkg-info paredit nhexl-mode mic-paren markdown-mode magit jupyter julia-ts-mode julia-snail json-mode grizzl gh-md flymake-easy flycheck-julia eglot-jl dired-git-info company auto-complete auctex ag)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(use-package counsel-at-point
  :commands (counsel-at-point-file-jump
             counsel-at-point-git-grep
             counsel-at-point-imenu))

;; Example key bindings.
(define-key prog-mode-map (kbd "M-n") 'counsel-at-point-git-grep)
(define-key prog-mode-map (kbd "M-o") 'counsel-at-point-imenu)
(define-key prog-mode-map (kbd "M-p") 'counsel-at-point-file-jump)

(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(counsel-mode)
