(defun sams-toggle-truncate ()		;[Jesper]
  "Toggle whether lines should be truncated or not.
Easy way to shift between truncate mode for a single buffer."
  (interactive "")
  (make-local-variable 'truncate-lines)
  (make-local-variable 'truncate-partial-width-windows)
  (if (< (window-width) (frame-width))
      (progn
        (setq truncate-lines nil)
        (setq truncate-partial-width-windows
	      (not truncate-partial-width-windows)))
    (setq truncate-lines (not truncate-lines))))
(defun sams-other-window-backwards (arg) ;[Jesper]
  "Like `other-window', but moves in the opposite direction."
  (interactive "p")
  (other-window (- 0 arg)))
(defun sams-other-frame-backwards (arg)	;[Jesper]
  "Like `other-frame', but moves in the opposite direction."
  (interactive "p")
  (other-frame (- 0 arg)))

(defun sams-find-file-dedicated-frame (name) ;[Jesper]
  "Load a file into a dedicated frame.
Create dedicated frame from file name."
  (interactive "ffind file: ")
  (special-display-popup-frame (find-file-noselect name)))

(defun sams-switch-buffer-dedicated-frame (name) ;[Jesper]
  "This functions loads an existing buffer into a dedicated frame"
  (interactive "bbuffer name: ")
  (special-display-popup-frame name))
