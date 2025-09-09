;;; TREESITTER-AUTO
;; Treesit-auto simplifies the use of Tree-sitter grammars in Emacs,
;; providing automatic installation and mode association for various
;; programming languages. This enhances syntax highlighting and
;; code parsing capabilities, making it easier to work with modern
;; programming languages.
(use-package treesit-auto
  :ensure t
  :straight t
  :after emacs
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode t))


;;; MARKDOWN-MODE
;; Markdown Mode provides support for editing Markdown files in Emacs,
;; enabling features like syntax highlighting, previews, and more.
;; It’s particularly useful for README files, as it can be set
;; to use GitHub Flavored Markdown for enhanced compatibility.
(use-package markdown-mode
  :defer t
  :straight t
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)            ;; Use gfm-mode for README.md files.
  :init (setq markdown-command "multimarkdown")) ;; Set the Markdown processing command.


;;; LSP
;; Emacs comes with an integrated LSP client called `eglot', which offers basic LSP functionality.
;; However, `eglot' has limitations, such as not supporting multiple language servers
;; simultaneously within the same buffer (e.g., handling both TypeScript, Tailwind and ESLint
;; LSPs together in a React project). For this reason, the more mature and capable
;; `lsp-mode' is included as a third-party package, providing advanced IDE-like features
;; and better support for multiple language servers and configurations.
;;
;; NOTE: To install or reinstall an LSP server, use `M-x install-server RET`.
;;       As with other editors, LSP configurations can become complex. You may need to
;;       install or reinstall the server for your project due to version management quirks
;;       (e.g., asdf or nvm) or other issues.
;;       Fortunately, `lsp-mode` has a great resource site:
;;       https://emacs-lsp.github.io/lsp-mode/
(use-package lsp-mode
  :ensure t
  :straight t
  :defer t
  :hook (;; Replace XXX-mode with concrete major mode (e.g. python-mode)
         (lsp-mode . lsp-enable-which-key-integration)  ;; Integrate with Which Key
         ((js-mode                                      ;; Enable LSP for JavaScript
           tsx-ts-mode                                  ;; Enable LSP for TSX
           typescript-ts-base-mode                      ;; Enable LSP for TypeScript
           css-mode                                     ;; Enable LSP for CSS
           go-ts-mode                                   ;; Enable LSP for Go
           js-ts-mode                                   ;; Enable LSP for JavaScript (TS mode)
           prisma-mode                                  ;; Enable LSP for Prisma
           python-base-mode                             ;; Enable LSP for Python
           ruby-base-mode                               ;; Enable LSP for Ruby
           rust-ts-mode                                 ;; Enable LSP for Rust
           web-mode) . lsp-deferred))                   ;; Enable LSP for Web (HTML)
  :commands lsp
  :custom
  (lsp-keymap-prefix "C-c l")                           ;; Set the prefix for LSP commands.
  (lsp-inlay-hint-enable nil)                           ;; Usage of inlay hints.
  (lsp-completion-provider :none)                       ;; Disable the default completion provider.
  (lsp-session-file (locate-user-emacs-file ".lsp-session")) ;; Specify session file location.
  (lsp-log-io nil)                                      ;; Disable IO logging for speed.
  (lsp-idle-delay 0.5)                                  ;; Set the delay for LSP to 0 (debouncing).
  (lsp-keep-workspace-alive nil)                        ;; Disable keeping the workspace alive.
  ;; Core settings
  (lsp-enable-xref t)                                   ;; Enable cross-references.
  (lsp-auto-configure t)                                ;; Automatically configure LSP.
  (lsp-enable-links nil)                                ;; Disable links.
  (lsp-eldoc-enable-hover t)                            ;; Enable ElDoc hover.
  (lsp-enable-file-watchers nil)                        ;; Disable file watchers.
  (lsp-enable-folding nil)                              ;; Disable folding.
  (lsp-enable-imenu t)                                  ;; Enable Imenu support.
  (lsp-enable-indentation nil)                          ;; Disable indentation.
  (lsp-enable-on-type-formatting nil)                   ;; Disable on-type formatting.
  (lsp-enable-suggest-server-download t)                ;; Enable server download suggestion.
  (lsp-enable-symbol-highlighting t)                    ;; Enable symbol highlighting.
  (lsp-enable-text-document-color t)                    ;; Enable text document color.
  ;; Modeline settings
  (lsp-modeline-code-actions-enable nil)                ;; Keep modeline clean.
  (lsp-modeline-diagnostics-enable nil)                 ;; Use `flymake' instead.
  (lsp-modeline-workspace-status-enable t)              ;; Display "LSP" in the modeline when enabled.
  (lsp-signature-doc-lines 1)                           ;; Limit echo area to one line.
  (lsp-eldoc-render-all t)                              ;; Render all ElDoc messages.
  ;; Completion settings
  (lsp-completion-enable t)                             ;; Enable completion.
  (lsp-completion-enable-additional-text-edit t)        ;; Enable additional text edits for completions.
  (lsp-enable-snippet nil)                              ;; Disable snippets
  (lsp-completion-show-kind t)                          ;; Show kind in completions.
  ;; Lens settings
  (lsp-lens-enable t)                                   ;; Enable lens support.
  ;; Headerline settings
  (lsp-headerline-breadcrumb-enable-symbol-numbers t)   ;; Enable symbol numbers in the headerline.
  (lsp-headerline-arrow "▶")                            ;; Set arrow for headerline.
  (lsp-headerline-breadcrumb-enable-diagnostics nil)    ;; Disable diagnostics in headerline.
  (lsp-headerline-breadcrumb-icons-enable nil)          ;; Disable icons in breadcrumb.
  ;; Semantic settings
  (lsp-semantic-tokens-enable nil))                     ;; Disable semantic tokens.


;;; LSP Additional Servers
;; You can extend `lsp-mode' by integrating additional language servers for specific
;; technologies. For example, `lsp-tailwindcss' provides support for Tailwind CSS
;; classes within your HTML files. By using various LSP packages, you can connect
;; multiple LSP servers simultaneously, enhancing your coding experience across
;; different languages and frameworks.
(use-package lsp-tailwindcss
  :ensure t
  :straight t
  :defer t
  :config
  (add-to-list 'lsp-language-id-configuration '(".*\\.erb$" . "html")) ;; Associate ERB files with HTML.
  :init
  (setq lsp-tailwindcss-add-on-mode t))


;; UNDO TREE
;; The `undo-tree' package provides an advanced and visual way to
;; manage undo history. It allows you to navigate and visualize your
;; undo history as a tree structure, making it easier to manage
;; changes in your buffers.
(use-package undo-tree
  :defer t
  :ensure t
  :straight t
  :hook
  (after-init . global-undo-tree-mode)
  :init
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t
        ;; Increase undo limits to avoid losing history due to Emacs' garbage collection.
        ;; These values can be adjusted based on your needs.
        ;; 10X bump of the undo limits to avoid issues with premature
        ;; Emacs GC which truncates the undo history very aggressively.
        undo-limit 800000                     ;; Limit for undo entries.
        undo-strong-limit 12000000            ;; Strong limit for undo entries.
        undo-outer-limit 120000000)           ;; Outer limit for undo entries.
  :config
  ;; Set the directory where `undo-tree' will save its history files.
  ;; This keeps undo history across sessions, stored in a cache directory.
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/.cache/undo"))))

(provide 'editing)
