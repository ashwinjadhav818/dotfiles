;;; org-appearance.el --- Doom-like Org appearance -*- lexical-binding: t; -*-

;;; Commentary:
;; Pretty Org-mode visuals, inspired by Doom Emacs.

;;; Code:

;; Hide leading stars, pretty bullets
(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-star nil)
  (org-modern-hide-stars t)
  (org-modern-block-name '("src" "quote"))
  (org-modern-table nil)
  (org-modern-ellipsis " ? "))

;; Pretty bullets
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

;; Indentation and bullets (pretty indentation lines)
(use-package org-modern-indent
  :straight (org-modern-indent :type git :host github :repo "jdtsmith/org-modern-indent")
  :after org-modern
  :hook (org-mode . org-modern-indent-mode))

;; Enable number line even with org-indent
(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode 1)
            (display-line-numbers-mode 1)))

(provide 'org-appearance)
;;; org-appearance.el ends here

