					;(load "~/adk/android-sdk-mac_x86/tools/lib/android.el")

					;(setq mac-command-modifier 'meta)
(setq load-path (cons "~/git/emacs_settings/etc" load-path))
(load "xcscope.el")
(load "mark.el")
(load "sams-lib.el")
(load "text.el")
(load "window.el")
(load "yic-buffer.el")
(load "flymake-cursor.el")
					;(load "jtags.el")
					;(load "jtags-extras.el")
					;(setq tags-auto-read-changed-tag-files 't)
(require 'git)
(require 'git-blame)
					;(require 'android)
(require 'xcscope)
(require 'color-theme)

(ansi-color-for-comint-mode-on)
(set-cursor-color "red")
(display-time)
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1))
(setq transient-mark-mode t)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 
					;(autoload 'matlab-mode "~/etc/matlab.el" "Enter Matlab mode." t)
					;(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
					;(autoload 'matlab-shell "~/etc/matlab.el" "Interactive Matlab mode." t)
(add-hook 'java-mode-hook (function cscope:hook))
(add-hook 'python-mode-hook (function cscope:hook))

					;(color-theme-euphoria)
(load "key.el")
					;(setq x-select-enable-clipboard t)
(tool-bar-mode -1)
(custom-set-variables
 '(help-at-pt-timer-delay 0.9)
 '(help-at-pt-display-when-idle '(flymake-overlay)))
;; add pylookup to your loadpath, ex) ~/.emacs.d/pylookup
(setq pylookup-dir "/home/song/git/pylookup")
(add-to-list 'load-path pylookup-dir)
(eval-when-compile (require 'pylookup))
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)
(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
					; Make sure it's not a remote buffer or flymake would not work
    (when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "pyflakes" (list local-file)))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
