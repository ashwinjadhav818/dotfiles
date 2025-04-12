;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Theme
(setq doom-theme 'doom-tokyo-night)

;; Editor
(setq display-line-numbers-type 'relative)

;; Font
(setq doom-font (font-spec :family "Maple Mono NF" :size 14)
      doom-variable-pitch-font (font-spec :family "Maple Mono NF" :size 13)
      doom-big-font (font-spec :family "Maple Mono NF" :size 20))

;; Org Mode Configuration
(setq org-directory "D:/Areas/org/")
(setq org-agenda-files '("D:/Areas/org/" "D:/Areas/org/todo.org"))

(after! org
  (setq org-capture-templates
        '(("j" "Daily Journal"
           entry (file+olp+datetree "D:/Areas/org/journal/%<%Y-%m-%d>.org")
           "* %U\n  %?"))))

;; Set the reload env command to bypass execution policy
(setq doom-reload-env-command
      "powershell -ExecutionPolicy Bypass -File %HOME%/.emacs.d/bin/doom.ps1")

; MDX Support
(add-to-list 'auto-mode-alist '("\\.\\(mdx\\)$" . markdown-mode))
(when (modulep! +lsp)
  (add-hook 'markdown-mode-local-vars-hook #'lsp! 'append))
