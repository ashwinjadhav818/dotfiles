;;; org-appearance.el --- Doom-like Org appearance -*- lexical-binding: t; -*-
;;; Commentary:
;; Pretty Org-mode visuals, inspired by Doom Emacs.

;;; Code:

;; Hide leading stars, pretty bullets
(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-star '("◉" "○" "✸" "✿"))
  (org-modern-block-name '("src" "quote"))
  (org-modern-table nil))

;; Indentation and bullets
(use-package org-indent
  :hook (org-mode . org-indent-mode))

;; Nice ellipsis instead of "..."
(setq org-ellipsis " ▼ ")

(provide 'org-appearance)
;;; org-appearance.el ends here
