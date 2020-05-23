(display-time-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("59e82a683db7129c0142b4b5a35dbbeaf8e01a4b81588f8c163bd255b76f4d21" "bffb799032a7404b33e431e6a1c46dc0ca62f54fdd20744a35a57c3f78586646" "ba913d12adb68e9dadf1f43e6afa8e46c4822bb96a289d5bf1204344064f041e" default)))
 '(markdown-command "/home/song/dlconda3/envs/tensorflow/bin/pandoc")
 '(package-selected-packages
   (quote
    (pyim-cangjie5dict pyim pdf-tools julia-mode markdown-mode jupyter js2-highlight-vars imenus imenu-list imenu-anywhere counsel-projectile counsel-css counsel-codesearch counsel ivy-explorer tide ag projectile-codesearch codesearch projectile alect-themes cyberpunk-theme eink-theme constant-theme rjsx-mode magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(unless package-archive-contents
  (package-refresh-contents))


					; install the missing packages
(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))

(load-theme 'alect-black t)

;; (require 'projectile-codesearch)
;; (global-set-key "\M-." 'projectile-codesearch-search)
(require 'rjsx-mode)
(require 'julia-mode)
(require 'projectile)
(require 'ag)
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
;; (global-set-key "\M-." 'projectile-ag)
(define-key rjsx-mode-map (kbd "M-.") 'projectile-ag)
(define-key julia-mode-map (kbd "M-.") 'projectile-ag)

;; (substitute-key-definition
;;            'js2-jump-to-definition 'projectile-ag rjsx-mode-map)
;; (global-set-key (kbd "C-.") 'imenu-anywhere)
(global-set-key (kbd "C-\\") 'imenu-list-minor-mode)
(global-set-key (kbd "C-.") 'highlight-symbol-at-point)
(global-set-key (kbd "C-,") 'unhighlight-regexp)
(global-set-key (kbd "C-r") 'replace-string)
(global-set-key (kbd "C-;") 'comment-region)

(counsel-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq js2-strict-missing-semi-warning nil)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)


(setq compilation-error-regexp-alist-alist
      (cons '(node "^[  ]+at \\(?:[^\(\n]+ \(\\)?\\([a-zA-Z\.0-9_/-]+\\):\\([0-9]+\\):\\([0-9]+\\)\)?$"
		   1 ;; file
		   2 ;; line
		   3 ;; column
		   )
            compilation-error-regexp-alist-alist))

(setq compilation-error-regexp-alist
      (cons 'node compilation-error-regexp-alist))

(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
(require 'pyim-cangjie5dict)
(pyim-cangjie5-enable)
(pyim-isearch-mode 1)
(setq default-input-method "pyim")
