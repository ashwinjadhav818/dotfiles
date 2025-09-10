(setq explicit-shell-file-name (getenv "DEFAULT_SHELL"))
(setq explicit-sh-args '("--login" "-i"))

(defun open-lazygit-term ()
  "Open lazygit in a term buffer."
  (interactive)
  (let ((buf (get-buffer-create "*lazygit*")))
    (pop-to-buffer buf)
    (unless (term-check-proc buf)
      (term "sh")
      (term-send-string buf "lazygit\n"))))


(provide 'terminal)
