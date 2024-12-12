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
(setq org-directory "D:/org")
(setq org-agenda-files '("D:/org" "D:/org/todo.org"))

(after! org
  (setq org-capture-templates
        '(("j" "Daily Journal"
           entry (file+datetree+prompt "D:/org/journal/%<%Y-%m-%d>.org")
           "* %U\n  %?"))))  ;; Each journal entry in its own file


;; OPTIMIZATIONS
;; Make startup faster by reducing the frequency of garbage
;; collection.  The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; The rest of the init file.

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;; Set the reload env command to bypass execution policy
(setq doom-reload-env-command
      "powershell -ExecutionPolicy Bypass -File %HOME%/.emacs.d/bin/doom.ps1")


;; Astro Development
(use-package! treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package! astro-ts-mode
  :init
  (when (modulep! +lsp)
    (add-hook 'astro-ts-mode-hook #'lsp! 'append))
  :config
  (let ((astro-recipe (make-treesit-auto-recipe
                       :lang 'astro
                       :ts-mode 'astro-ts-mode
                       :url "https://github.com/virchau13/tree-sitter-astro"
                       :revision "master"
                       :source-dir "src")))
    (add-to-list 'treesit-auto-recipe-list astro-recipe)))

(set-formatter! 'prettier-astro
  '("npx" "prettier" "--parser=astro"
    (apheleia-formatters-indent "--use-tabs" "--tab-width" 'astro-ts-mode-indent-offset))
  :modes '(astro-ts-mode))

(use-package! lsp-tailwindcss
  :when (modulep! +lsp)
  :init
  (setq! lsp-tailwindcss-add-on-mode t)
  :config
  (add-to-list 'lsp-tailwindcss-major-modes 'astro-ts-mode))

;; MDX Support
(add-to-list 'auto-mode-alist '("\\.\\(mdx\\)$" . markdown-mode))
(when (modulep! +lsp)
  (add-hook 'markdown-mode-local-vars-hook #'lsp! 'append))
