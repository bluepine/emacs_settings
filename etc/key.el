(define-key global-map "\C-]" 'search-forward)
(define-key global-map "\C-g" 'goto-line)
(define-key global-map "\C-r" 'replace-string)
(define-key global-map "\M-m" 'compile)
(define-key global-map "\C-f" 'find-name-dired)
(define-key global-map "\M-o" 'sams-cm-save-point)
(define-key global-map "\M-p" 'sams-cm-rotate)
(define-key global-map "\M-n" 'sams-cm-reverse-rotate)
(define-key global-map [(meta space)] 'set-mark-command)
(define-key global-map [(meta s)] 'cscope-find-this-symbol)
(define-key global-map [(meta d)] 'cscope-find-global-definition)
