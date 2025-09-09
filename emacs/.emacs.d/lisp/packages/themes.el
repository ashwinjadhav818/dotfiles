;;; themes.el --- Theme configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Theme setup for Emacs, including Catppuccin and Tokyo theme.

;;; Code:

;; -------------------------------
;; Catppuccin Theme
;; -------------------------------
(use-package catppuccin-theme
  :ensure t
  :straight t
  :config
  (custom-set-faces
   ;; Diff-hl colors
   `(diff-hl-change ((t (:background unspecified :foreground ,(catppuccin-get-color 'blue)))))
   `(diff-hl-delete ((t (:background unspecified :foreground ,(catppuccin-get-color 'red)))))
   `(diff-hl-insert ((t (:background unspecified :foreground ,(catppuccin-get-color 'green))))))

  ;; Load Catppuccin theme by default
  (load-theme 'catppuccin :no-confirm))

;; -------------------------------
;; Tokyo Theme (extra theme option)
;; -------------------------------
(use-package tokyo-theme
  :straight (tokyo-theme
             :type git
             :host github
             :repo "rawleyfowler/tokyo-theme.el"
             :branch "main")
  :config
  ;; Uncomment this if you want Tokyo as default instead:
  ;; (load-theme 'tokyo t)
  )

(provide 'themes)
;;; themes.el ends here

