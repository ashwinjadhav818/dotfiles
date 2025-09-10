;;; org-config.el --- Org and Org-roam configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Configuration for Org-mode and Org-roam in vanilla Emacs.

;;; Code:

;; -------------------------------
;; ORG-MODE
;; -------------------------------
(use-package org
  :ensure nil   ;; built-in
  :defer t)

(with-eval-after-load 'org
  (setq org-directory "~/org/")

  (setq org-agenda-files (list
                        "~/org/inbox.org"
                        "~/org/calendar.org"
                        "~/org/studies.org"))
  
  ;; TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WORKING(w!)" "WAIT(W@)" "|" "DONE(d!)" "CANC(c@)")))

  ;; Capture templates
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
           :prepend t))))


;; Ensure general is available
(use-package general
  :ensure t
  :config
  ;; Define SPC m as "localleader"
  (general-create-definer org-local-leader
    :prefix "SPC m"
    :states '(normal visual)
    :keymaps 'org-mode-map)

  ;; Org keybinds (similar to Doom)
  (org-local-leader
    "t" '(:ignore t :which-key "todo")
    "tt" '(org-todo :which-key "cycle todo")
    "ts" '(org-schedule :which-key "schedule")
    "td" '(org-deadline :which-key "deadline")

    "p" '(:ignore t :which-key "priority")
    "pa" '(org-priority-up :which-key "increase")
    "pd" '(org-priority-down :which-key "decrease")

    "r" '(:ignore t :which-key "refile")
    "r." '(+org/refile-to-current-file    :which-key "to current file")
    "rc" '(+org/refile-to-running-clock   :which-key "to running clock")
    "rl" '(+org/refile-to-last-location   :which-key "to last location")
    "rf" '(+org/refile-to-file            :which-key "to file")
    "ro" '(+org/refile-to-other-window    :which-key "to other window")
    "rO" '(+org/refile-to-other-buffer    :which-key "to other buffer")
    "rv" '(+org/refile-to-visible         :which-key "to visible")
    "rr" '(org-refile                     :which-key "refile")
    "rR" '(org-refile-reverse             :which-key "reverse"))

    "c" '(:ignore t :which-key "capture/clock")
    "cc" '(org-capture :which-key "capture")
    "ci" '(org-clock-in :which-key "clock in")
    "co" '(org-clock-out :which-key "clock out")

    "s" '(:ignore t :which-key "subtree")
    "sn" '(org-narrow-to-subtree :which-key "narrow")
    "sw" '(widen :which-key "widen")

    "l" '(:ignore t :which-key "links")
    "li" '(org-insert-link :which-key "insert")
    "lo" '(org-open-at-point :which-key "open"))


;; -------------------------------
;; ORG-ROAM
;; -------------------------------
(use-package org-roam
  :ensure t
  :defer t
  :custom
  (org-roam-directory (file-truename "~/org/notes/"))
  :config
  ;; Display template
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

  ;; Auto-sync database
  (org-roam-db-autosync-mode)

  ;; Optional: org-roam-protocol
  (require 'org-roam-protocol))

(provide 'org-config)
;;; org-config.el ends here

