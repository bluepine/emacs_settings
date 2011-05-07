;;; ############################################################ &text ###

(defun sams-transpose-prev-chars ()	;[Jesper]
  "Transposes the previous typed character and the one before it.
Usefull if bound to C-S-t ot even as a replacement for C-t."
  (interactive)
  (backward-char 1)
  (transpose-chars 1))

(defun sams-fill ()			;[Jesper]
  "If area is selected call `fill-region' otherwise call `fill-paragraph'."
  (interactive)
  (if (region-active-p)
      (fill-region (region-beginning) (region-end))
    (fill-paragraph nil)))

(defun sams-count-matching-lines (regexp) ;[Jesper]
  "Count lines matching REGEXP."
  (let ((lines 0))
    (progn
      (save-excursion
        (while (re-search-forward regexp (point-max) t)
          (setq lines (+ 1 lines))
          (forward-line)))
      lines)))


;; This function deletes all lines which don't match a given regular
;; expression. The user is asked for the regular expression and is told
;; how many lines will be deleted, and is asked to confirm that he wants
;; to delete these lines.  If the buffer is readonly, it makes the file
;; writable (assuming the reader has permission to do so), deletes the
;; lines, and makes it readonly again. Otherwise if the buffers isn't
;; changed, the user is asked whether he wants to make the buffer readonly,
;; to avoid accidentally saving it.

(defun sams-keep-lines (regexp)		;[Jesper]
  "Count lines not matching REGEXP and ask to delete those lines.
The user is told how many lines this is, and is asked to confirm that he
wants to delete these lines. If the buffer isn't modified before the
action, the function offers to make the buffer readonly, to avoid accidentally
saving it and deleting all the lines for ever."
  (interactive "sRegexp to match: ")
  (let* ((lines (sams-count-matching-lines regexp))
         (rest (count-lines (point) (point-max)))
         (total (- rest lines))
         (modified (buffer-modified-p))
         (read-only buffer-read-only))
    (progn
      ;; if the buffer is readonly, toggle this, so we can delete the lines
      (if read-only
          (vc-toggle-read-only))
      ;; are there any lines to delete?
      (if (> total 0)
          (if (y-or-n-p (concat "Delete "
                                total
                                " lines, which don't match the regexp "))
              (progn
                (keep-lines regexp)
                (if (and (not modified) (not read-only))
                    (if (y-or-n-p "Make buffer read-only ")
                        (progn
                          (set-buffer-modified-p nil)
                          (vc-toggle-read-only)))))
            (message "No lines deleted"))
        (message "No match"))
      ;; if the buffer was readonly, set the buffer to "not modified"
      ;; and toggle the readonly flag again.
      (if read-only
          (progn
            (set-buffer-modified-p nil)
            (vc-toggle-read-only))))))


;; This function is equivalent to the function above, with the only
;; difference that it delete lines which match.

(defun sams-kill-lines (regexp)		;[Jesper]
  "Count lines matching REGEXP and ask for deleting of those lines.
The user is told how many lines this is, and are asked to confirm that he
wants to delete these lines. If the buffer isn't modified before the
action, the function offers to make the buffer readonly, to avoid accidentally
saving it and deleting all the lines for ever."
  (interactive "sRegexp to match: ")
  (let* ((total (sams-count-matching-lines regexp))
         (modified (buffer-modified-p))
         (read-only buffer-read-only))
    (progn
      ; if the buffer is readonly, toggle this, so we can delete the lines
      (if read-only
          (vc-toggle-read-only))
      ; are there any lines to delete?
      (if (> total 0)
          (if (y-or-n-p (concat "Delete "
                                total
                                " lines, which match the regexp "))
              (progn
                (flush-lines regexp)
                (if (and (not modified) (not read-only))
                    (if (y-or-n-p "Make buffer read-only ")
                        (progn
                          (set-buffer-modified-p nil)
                          (vc-toggle-read-only)))))
            (message "No lines deleted"))
        (message "No match"))
      ; if the buffer were readonly, set the buffer to "not modified"
      ; and toggle the readonly flag again.
      (if read-only
          (progn
            (set-buffer-modified-p nil)
            (vc-toggle-read-only))))))


(defun sams-make-buffer-copy ()		;[Jesper]
"Make an indirect copy to dedicated frame with same `major-mode'."
  (interactive)
  (let* ( (b-name (buffer-name))
         (new-name (generate-new-buffer-name
                    (concat b-name "-indirect")))
         (m-mode major-mode))
    (make-indirect-buffer (current-buffer) new-name)

    ;;; Use this to get the buffer in a dedicated frame
    (special-display-popup-frame new-name)

    ;;; use this instead to get the buffer in another frame
    ; (switch-to-buffer-other-frame new-name)

    ;;; Start the major mode
    (set-buffer new-name)
    (funcall m-mode)
    ))

(defun sams-apply-macro-on-region (start end command) ;[Jesper]
  "Evaluate a given function (or the last defined macro) on region.
I.e. it will continue until the point is position
outside the region.

This function is much like the function apply-macro-to-region-lines,
which is shipped with Emacs. It has one difference though. It
executes the macros until point is below the end of the region."
  (interactive "r\naCommand name (default:last keyboard macro).")
  (goto-char end)
  (let ((mark (point-marker)))
    (goto-char start)
    (while (< (point) (marker-position mark))
    (if (not (fboundp command))
        (call-last-kbd-macro)
      (command-execute command)))))

(defun sams-unbound-key ()		;[Jesper]
  "Ring the bell and show message that key is not bound to any function."
  (interactive)
  (message "This key is not bound to any function")
  (ding))
