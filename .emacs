
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(package-selected-packages
   (quote
    (xref-js2 color-theme-sanityinc-tomorrow company-tern elpy rjsx-mode z3-mode racket-mode web-beautify web-mode flycheck zen-and-art-theme xlicense xcscope writegood-mode vlf typing todotxt symbols-mode sml-mode save-visited-files rainbow-mode python-pylint nose nhexl-mode modeline-posn mode-compile mic-paren magit keywiz json-mode json ioccur igrep git fuzzy-match auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(setq column-number-mode t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

(add-hook 'rjsx-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil) ;;Use space instead of tab
            (setq js-indent-level 2) ;;space width is 2 (default is 4)
            (setq js2-strict-missing-semi-warning nil))) ;;disable the semicolon warning

(require 'company)
(require 'company-tern)

(add-to-list 'company-backends 'company-tern)
(add-hook 'rjsx-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))
                           
;; Disable completion keybindings, as we use xref-js2 instead
(define-key tern-mode-keymap (kbd "M-.") nil)
(define-key tern-mode-keymap (kbd "M-,") nil)

(require 'flycheck)
;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

(add-hook 'after-init-hook #'global-flycheck-mode)
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
	  '(javascript-jshint)))

(flycheck-add-mode 'javascript-eslint 'rjsx-mode)
(flycheck-add-mode 'javascript-eslint 'javascript-mode)

(setq-default flycheck-temp-prefix ".flycheck")

(desktop-save-mode 1)

(autoload 'color-theme-approximate-on "color-theme-approximate")
(color-theme-approximate-on)

(require 'compile)
(setq compilation-error-regexp-alist-alist
      (cons '(node "^[  ]+at \\(?:[^\(\n]+ \(\\)?\\([a-zA-Z\.0-9_/-]+\\):\\([0-9]+\\):\\([0-9]+\\)\)?$"
                         1 ;; file
                         2 ;; line
                         3 ;; column
                         )
            compilation-error-regexp-alist-alist))
(setq compilation-error-regexp-alist
      (cons 'node compilation-error-regexp-alist))


(elpy-enable)

(setq shell-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list
         'comint-preoutput-filter-functions
         (lambda (output)
           (replace-regexp-in-string "\033\\[[0-9]+[GK]" "" output)))))

;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(display-time-mode 1)
(delete-selection-mode 1)

