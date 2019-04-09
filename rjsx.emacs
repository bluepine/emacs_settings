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
 '(package-selected-packages
   (quote
    (ag projectile-codesearch codesearch projectile alect-themes cyberpunk-theme eink-theme constant-theme rjsx-mode magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'alect-black t)

;; (require 'projectile-codesearch)
;; (global-set-key "\M-." 'projectile-codesearch-search)
(require 'rjsx-mode)
(require 'projectile)
(require 'ag)
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
;; (global-set-key "\M-." 'projectile-ag)
(define-key rjsx-mode-map (kbd "M-.") 'projectile-ag)

;; (substitute-key-definition
;;            'js2-jump-to-definition 'projectile-ag rjsx-mode-map)
