;; ----------------------------------------------------------------------
;;     Original yic-buffer.el
;;     From: choo@cs.yale.edu (young-il choo)
;;     Date: 7 Aug 90 23:39:19 GMT
;;
;;     Little more sophisticated for my private use:
;;     Aug 7 1995 "Jari Aalto" <jaalto@tre.tele.nokia.fi> Public domain.
;; ----------------------------------------------------------------------


(defconst yic-ignore-re
  (concat
   "^ "                 ;hidden buffers
   "\\|completion\\|summary\\|messages\\|Compile-Log|\\tags"
   "\\|buffer list\\|help\\|ispell"
   "\\|temp\\|tmp\\|post\\|tff"
   )
  "*Buffers to ignore when changing to another.")

(defun yic-next (list)
  "Switch to next buffer in list skipping unwanted ones."
  (let* ((ptr list)
         (re  yic-ignore-re)
         bf bn go
         )

    (while (and ptr (null go))
      (setq bf (car ptr)  bn (buffer-name bf))
;;;      (d! (string-match re bn) bn)
      (if (null (string-match re bn))           ;skip over
          (setq go bf)
        (setq ptr (cdr ptr))
        )

      )
    (if go
         (switch-to-buffer go))
    ))

(defun yic-prev-buffer ()
  "Switch to previous buffer in current window."
  (interactive)
  (yic-next (reverse (buffer-list))))

(defun yic-next-buffer ()
  "Switch to the other buffer (2nd in list-buffer) in current window."
  (interactive)
  (bury-buffer (current-buffer))
  (yic-next (buffer-list)))

