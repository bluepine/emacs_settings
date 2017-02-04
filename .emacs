(tool-bar-mode -1)
(scroll-bar-mode -1)

;; (require 'package) ;; You might already have this line
;; (add-to-list 'package-archives
;; 	     '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
;; (when (< emacs-major-version 24)
;;   ;; For important compatibility libraries like cl-lib
;;   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;; (package-initialize)



;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 sentence-end-double-space nil)

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; modes
(electric-indent-mode 0)

;; global keybindings
(global-unset-key (kbd "C-z"))

;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package ensime
  :ensure t
  :pin melpa-stable)

(load-theme 'blackboard t)


                                        ;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(js2-imenu-extras-mode)

;;; tern
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

;;;react native
(add-hook 'web-mode-hook (lambda () (tern-mode t)))
(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?$" . web-mode))
(setq web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2)
(setq js-indent-level 2)
(add-hook 'projectile-after-switch-project-hook 'mjs/setup-local-eslint)

(defun mjs/setup-local-eslint ()
  "If ESLint found in node_modules directory - use that for flycheck.
Intended for use in PROJECTILE-AFTER-SWITCH-PROJECT-HOOK."
  (interactive)
  (let ((local-eslint (expand-file-name "./node_modules/.bin/eslint")))
    (setq flycheck-javascript-eslint-executable
          (and (file-exists-p local-eslint) local-eslint))))
(with-eval-after-load 'flycheck
  (push 'web-mode (flycheck-checker-get 'javascript-eslint 'modes)))
