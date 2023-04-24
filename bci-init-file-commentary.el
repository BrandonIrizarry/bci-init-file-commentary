;;;###autoload
(defun bci-init-file-commentary--isolate-heading ()
  "Given the ';;@' init file convention, return the corresponding
heading text that belongs (or should be found) in the
index/commentary file."
  (interactive)
  (save-excursion
    (goto-char (line-beginning-position))
    (when (looking-at "^;;@[[:space:]]+\\(.*\\)$")
      (let ((all-bounds (match-data 'integers)))
        (buffer-substring-no-properties (third all-bounds)
                                        (fourth all-bounds))))))

;;;###autoload
(defun bci-init-file-commentary-goto-heading-create ()
  "Go to the heading point is on, or else create it."
  (interactive)
  (let* ((heading-text (bci-init-helper--isolate-heading))
         (new-heading (format "* %s" heading-text)))
    (find-file (locate-user-emacs-file "index-and-commentary.org"))
    (goto-char (point-min))
    (unless (re-search-forward (concat "^" new-heading) nil t)
      (goto-char (point-max))
      (insert "\n")
      (insert new-heading))))

(provide 'bci-init-file-commentary)
