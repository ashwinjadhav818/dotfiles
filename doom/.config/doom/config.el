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

;; ---- ORG ----
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

;; ---- KEYBINDS ----
;; Collapes Headings
(map! :leader
      :desc "Collapse all headings" "o c" #'outline-hide-sublevels
      :desc "Expand all headings" "o e" #'outline-show-all)
