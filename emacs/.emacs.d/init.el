(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/packages" user-emacs-directory))

;; Performance Hacks
;; Emacs is an Elisp interpreter, and when running programs or packages,
;; it can occasionally experience pauses due to garbage collection.
;; By increasing the garbage collection threshold, we reduce these pauses
;; during heavy operations, leading to smoother performance.
(setq gc-cons-threshold #x40000000)

;; Set the maximum output size for reading process output, allowing for larger data transfers.
(setq read-process-output-max (* 1024 1024 4))


(require 'packages)
(require 'config)
(require 'functions)

;; Per-package configs
(require 'editing)
(require 'git)
(require 'keymaps)
(require 'misc)
(require 'org-config)
(require 'org-appearance)
(require 'programming)
(require 'themes)
(require 'ui)

(provide 'init)
;;; init.el ends here
