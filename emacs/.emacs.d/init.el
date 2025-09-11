;;; init.el --- Personal Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Entry point for my Emacs setup.
;; Loads custom Lisp modules, applies performance tweaks, and sets up packages.

;;; Code:

;; Load Path Setup
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/packages" user-emacs-directory))

;; Performance Tweaks
;; Increase garbage collection threshold to reduce GC pauses during heavy ops.
(setq gc-cons-threshold #x40000000)

;; Increase process output read size (default is 4KB, bump to 4MB).
(setq read-process-output-max (* 4 1024 1024))

;; reset GC threshold after startup for balance
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold #x1000000)))

;; Modules
(require 'packages)     ;; package.el / straight.el / use-package setup
(require 'config)       ;; general settings
(require 'functions)    ;; helper functions
(require 'keymaps)      ;; global + leader keymaps

(require 'editing)      ;; editing enhancements
(require 'terminal)     ;; terminal emulation (vterm/ansi-term/etc.)
(require 'misc)         ;; misc quality-of-life tweaks
(require 'org-config)   ;; org + org-roam
(require 'org-appearance) ;; org visuals (org-modern, bullets, etc.)
(require 'programming)  ;; prog-mode, lsp, treesit, etc.
(require 'themes)       ;; theme setup
(require 'ui)           ;; UI elements (modeline, dashboard, etc.)

(provide 'init)
;;; init.el ends here
