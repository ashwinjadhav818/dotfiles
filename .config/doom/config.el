;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; ---- UI ----
;; Theme
(setq doom-theme 'doom-tokyo-night)
;; Editor
(setq display-line-numbers-type 'relative)

;; Font
(setq doom-font (font-spec :family "MonoLisa" :size 16)
      doom-variable-pitch-font (font-spec :family "MonoLisa" :size 16)
      doom-big-font (font-spec :family "MonoLisa" :size 22))

(setq
 ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-fold-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-agenda-tags-column 0
 org-ellipsis "…"
 )

;; Org Modern
(after! org-modern
  (setq org-modern-star "◉"
        org-modern-stars '("◉" "○" "✸" "✿" "✜" "◆" "▶"))
  (global-org-modern-mode))

;; You can also place the global mode inside the org module hook
;; to be even more specific.
(add-hook 'org-mode-hook #'org-modern-mode)
;; ---- Editor ---
;; Org Mode Configuration
(setq org-directory "~/org/")
(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WORKING(w!)" "WAIT(W@)" "|" "DONE(d!)" "CANC(c@)")))
  )

;; Capture templates
(after! org
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "~/org/inbox.org" "Inbox")
           "* TODO %^{Task}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("e" "Event" entry
           (file+headline "~/org/calendar.org" "Events")
           "* %^{Event}\n%^{SCHEDULED}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("d" "Deadline" entry
           (file+headline "~/org/calendar.org" "Deadlines")
           "* TODO %^{Task}\nDEADLINE: %^{Deadline}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("p" "Project" entry
           (file+headline "~/org/projects.org" "Projects")
           "* PROJ %^{Project name}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n** TODO %?")
          ("i" "Idea" entry
           (file+headline "~/org/ideas.org" "Ideas")
           "** IDEA %^{Idea}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("n" "Note" entry
           (file+headline "~/org/notes.org" "Inbox")
           "* [%<%Y-%m-%d %a>] %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?"
           :prepend t)))
  )

;; Org Roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org/notes/"))
  :config
  ;; Set up the key bindings
  (map! :leader
        (:prefix ("r" . "roam")
         :desc "Toggle buffer"    "l" #'org-roam-buffer-toggle
         :desc "Find node"        "f" #'org-roam-node-find
         :desc "Show graph"       "g" #'org-roam-graph
         :desc "Insert node"      "i" #'org-roam-node-insert
         :desc "Capture"          "c" #'org-roam-capture
         :desc "Dailies today"    "j" #'org-roam-dailies-capture-today))

  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

;; Collapes Headings
(map! :leader
      :desc "Collapse all headings" "o c" #'outline-hide-sublevels
      :desc "Expand all headings" "o e" #'outline-show-all)
