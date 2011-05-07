;(setq x-select-enable-clipboard t)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


(setq load-path (cons "~/etc" load-path))
(load "key.el")
(load "mark.el")
(load "sams-lib.el")
(load "text.el")
(load "window.el")
(load "yic-buffer.el")
					; interpret and use ansi color codes in shell output windows
(ansi-color-for-comint-mode-on)

;(global-set-key "\C-m" 'set-mark-command)
(set-cursor-color "red")


(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 

(autoload 'matlab-mode "~/etc/matlab.el" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "~/etc/matlab.el" "Interactive Matlab mode." t)

					;(load "lua-mode.el")

(display-time)

(define-key global-map [(ctrl g)] 'goto-line)
(define-key global-map [(meta space)] 'set-mark-command)
(define-key global-map [(meta s)] 'cscope-find-this-symbol)
(define-key global-map [(meta d)] 'cscope-find-global-definition)
;; enable visual feedback on selections
(setq transient-mark-mode t)

					;(load "psvn")

(desktop-load-default)
(desktop-read)

(load-file "/usr/share/emacs/site-lisp/xcscope.el")
(require 'xcscope)
;(tool-bar-mode -1)