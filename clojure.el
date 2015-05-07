;; Clojure
(require 'clojure-mode)
(setq auto-mode-alist (cons '("\\.cljs$" . clojure-mode) auto-mode-alist))
(setq inferior-lisp-program "lein repl")
 
;; clj-refactor
(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-o")))
 
;; align-cljlet
(require 'align-cljlet)
(global-set-key (kbd "C-c C-a") 'align-cljlet)
 
;; paredit
(require 'paredit)
(add-hook 'clojure-mode-hook 'paredit-mode)
 
;; projectile
(require 'projectile)
(add-hook 'clojure-mode-hook 'projectile-mode)
 
;; company-mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-etags)
(add-to-list 'company-etags-modes 'clojure-mode)
 
(defun get-clj-completions (prefix)
  (let* ((proc (inferior-lisp-proc))
         (comint-filt (process-filter proc))
         (kept ""))
    (set-process-filter proc (lambda (proc string) (setq kept (concat kept string))))
    (process-send-string proc (format "(complete.core/completions \"%s\")\n"
                                      (substring-no-properties prefix)))
    (while (accept-process-output proc 0.1))
    (setq completions (read kept))
    (set-process-filter proc comint-filt)
    completions))
 
(defun company-infclj (command &optional arg &rest ignored)
  (interactive (list 'interactive))
 
  (cl-case command
    (interactive (company-begin-backend 'company-infclj))
    (prefix (and (eq major-mode 'inferior-lisp-mode)
                 (company-grab-symbol)))
    (candidates (get-clj-completions arg))))
 
(add-to-list 'company-backends 'company-infclj)
 
;; yasnippet
(require 'yasnippet)
(require 'clojure-snippets)
(yas-global-mode 1)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
(yas-load-directory "~/.emacs.d/snippets")
 
;; Some handly key bindings
 
(global-set-key (kbd "C-c C-s") 'clojure-toggle-keyword-string)
 
(defun reload-current-clj-ns ()
  (interactive)
  (let ((current-point (point)))
    (goto-char (point-min))
    (let ((ns-idx (re-search-forward clojure-namespace-name-regex nil t)))
      (when ns-idx
        (goto-char ns-idx)
        (let ((sym (symbol-at-point)))
          (message (format "Loading %s ..." sym))
          (lisp-eval-string (format "(require '%s :reload)" sym))
          (lisp-eval-string (format "(in-ns '%s)" sym)))))
    (goto-char current-point)))
 
(defun find-tag-without-ns (next-p)
  (interactive "P")
  (find-tag (first (last (split-string (symbol-name (symbol-at-point)) "/")))
            next-p))
 
(defun erase-inf-buffer ()
  (interactive)
  (erase-buffer)
  (lisp-eval-string ""))
 
(add-hook 'clojure-mode-hook
          '(lambda ()
             (define-key clojure-mode-map "\C-c\C-k" 'reload-current-clj-ns)
             (define-key clojure-mode-map "\M-." 'find-tag-without-ns)))
(add-hook 'inferior-lisp-mode-hook
          '(lambda ()
             (define-key inferior-lisp-mode-map "\C-cl" 'erase-inf-buffer)))
