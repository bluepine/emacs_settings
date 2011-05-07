;;; ##################################################### &cycle-marks ###

(defvar sams-cm-ring nil
  "List of markers that points to buffer-positions.")

(defun sams-cm-same-pos ()
  (and sams-cm-ring
       (equal (point) (marker-position (car sams-cm-ring)))
       (equal (current-buffer) (marker-buffer (car sams-cm-ring)))))

(defun sams-cm-save-point (arg)
  (interactive "P")
  (if (or (and arg (< (prefix-numeric-value arg) 0))
          (sams-cm-same-pos))
      (progn
        (setq sams-cm-ring (cdr sams-cm-ring))
        (message "Point deleted from stack (%d left)" (length sams-cm-ring)))
    (setq sams-cm-ring (cons (point-marker) sams-cm-ring))
    (message "Point saved (%d saved)" (length sams-cm-ring))))


(defun sams-cm-rotate (num)
  "If point differ from first position in ring then goto that.
Otherwise rotate the ring of points and go to the now newest point in the ring"
  (interactive "P")
  (if (not sams-cm-ring)
      (error "No points saved!"))
  (setq num
        (if (null num) (if (sams-cm-same-pos) 1 0)
          (prefix-numeric-value num)))
  (setq num (mod num (length sams-cm-ring)))
  (let ((top nil))
    (while (> num 0)
      (setq top (cons (car sams-cm-ring) top))
      (setq sams-cm-ring (cdr sams-cm-ring))
      (setq num (1- num)))
    (setq sams-cm-ring (append sams-cm-ring (nreverse top)))
    (if (marker-position (car sams-cm-ring))
        (progn
          (switch-to-buffer (marker-buffer (car sams-cm-ring)))
          (goto-char (car sams-cm-ring)))
      (setq sams-cm-ring (cdr sams-cm-ring))
      (sams-cm-rotate 1))))

(defun sams-cm-reverse-rotate (num)
  (interactive "P")
  (if (not sams-cm-ring)
      (error "No points saved!"))
  (sams-cm-rotate -1))