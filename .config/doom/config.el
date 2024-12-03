;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Theme
(setq doom-theme 'doom-tokyo-night)

;; Editor
(setq display-line-numbers-type relative)
(set-frame-font "Maple Mono NF 16":doom)

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
