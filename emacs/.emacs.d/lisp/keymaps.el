;;; keymaps.el --- Doom-style Evil keybindings -*- lexical-binding: t; -*-

;;; Commentary:
;; This file configures Evil mode, Evil-Collection, Evil-Surround,
;; Evil-Matchit, and Doom-style SPC leader keybindings with Which-Key
;; integration for descriptive labels.

;;; Code:

;; -------------------------------
;; EVIL
;; -------------------------------
(use-package evil
  :ensure t
  :straight t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-u-delete t
        evil-want-fine-undo t)
  :config
  (evil-set-undo-system 'undo-tree)
  (evil-mode 1)

  ;; Set leader key as SPC like Doom
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC")))

;; -------------------------------
;; EVIL COLLECTION
;; -------------------------------
(use-package evil-collection
  :ensure t
  :straight t
  :after evil
  :custom (evil-collection-want-find-usages-bindings t)
  :config
  (evil-collection-init))

;; -------------------------------
;; EVIL SURROUND
;; -------------------------------
(use-package evil-surround
  :ensure t
  :straight t
  :after evil-collection
  :config
  (global-evil-surround-mode 1))

;; -------------------------------
;; EVIL MATCHIT
;; -------------------------------
(use-package evil-matchit
  :ensure t
  :straight t
  :after evil-collection
  :config
  (global-evil-matchit-mode 1))

;; -------------------------------
;; DOOM-STYLE LEADER KEYBINDINGS
;; -------------------------------
(defun open-personal-config ()
  "Fuzzy search and open a file in `~/.emacs.d`."
  (interactive)
  (find-file
   (completing-read "Find config file: "
                    (directory-files-recursively "~/.emacs.d" "\\.el$"))))

(defun org-find-file ()
  "Fuzzy search and open a file in `org-directory`."
  (interactive)
  (find-file
   (completing-read "Find org file: "
                    (directory-files-recursively "~/org" "\\.org$"))))


(with-eval-after-load 'evil
  ;; Quit / neotree
  (evil-define-key 'normal 'global (kbd "<leader> q") 'save-buffers-kill-terminal)
  (evil-define-key 'normal 'global (kbd "<leader> e") 'neotree-toggle)

  ;; -------------------------------
  ;; FILES
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "<leader> w") 'save-buffer)
  (evil-define-key 'normal 'global (kbd "<leader> f f") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader> f r") 'recentf-open-files)
  (evil-define-key 'normal 'global (kbd "<leader> f d") 'dired)
  (evil-define-key 'normal 'global (kbd "<leader> f p") 'open-personal-config)

  ;; -------------------------------
  ;; BUFFERS
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "<leader> b b") 'consult-buffer)
  (evil-define-key 'normal 'global (kbd "<leader> b q") 'kill-current-buffer)
  (evil-define-key 'normal 'global (kbd "<leader> b s") 'save-buffer)
  (evil-define-key 'normal 'global (kbd "<leader> b c") 'outline-hide-sublevels)
  (evil-define-key 'normal 'global (kbd "<leader> b e") 'outline-show-all)
  (evil-define-key 'normal 'global (kbd "<leader> <tab>") 'switch-to-next-buffer)
  (evil-define-key 'normal 'global (kbd "<leader> S-<tab>") 'switch-to-prev-buffer)


  ;; -------------------------------
  ;; PROJECTS
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "<leader> p p") 'project-switch-project)
  (evil-define-key 'normal 'global (kbd "<leader> p f") 'project-find-file)
  (evil-define-key 'normal 'global (kbd "<leader> p b") 'consult-project-buffer)
  (evil-define-key 'normal 'global (kbd "<leader> p k") 'project-kill-buffers)

  ;; -------------------------------
  ;; SEARCH
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "<leader> s f") 'consult-find)
  (evil-define-key 'normal 'global (kbd "<leader> s g") 'consult-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader> /") 'consult-line)

  ;; -------------------------------
  ;; HELP
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "<leader> h f") 'describe-function)
  (evil-define-key 'normal 'global (kbd "<leader> h v") 'describe-variable)
  (evil-define-key 'normal 'global (kbd "<leader> h m") 'describe-mode)
  (evil-define-key 'normal 'global (kbd "<leader> h k") 'describe-key)

  ;; -------------------------------
  ;; TABS / WINDOWS
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "] t") 'tab-next)
  (evil-define-key 'normal 'global (kbd "[ t") 'tab-previous)

  ;; -------------------------------
  ;; DIAGNOSTICS / FLYMAKE
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "] d") 'flymake-goto-next-error)
  (evil-define-key 'normal 'global (kbd "[ d") 'flymake-goto-prev-error)

  ;; -------------------------------
  ;; YANK / EMBARK
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "<leader> .") 'embark-act)

  ;; -------------------------------
  ;; UNDO / TREE
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "<leader> u") 'undo-tree-visualize)

  ;; -------------------------------
  ;; ORG + ORG-ROAM
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "<leader> o a") 'org-agenda)
  (evil-define-key 'normal 'global (kbd "<leader> o c") 'org-capture)
  (evil-define-key 'normal 'global (kbd "<leader> o l") 'org-store-link)
  (evil-define-key 'normal 'global (kbd "<leader> o f") 'org-find-file)
  (evil-define-key 'normal 'global (kbd "<leader> o r f") 'org-roam-node-find)
  (evil-define-key 'normal 'global (kbd "<leader> o r i") 'org-roam-node-insert)
  (evil-define-key 'normal 'global (kbd "<leader> o r g") 'org-roam-graph)
  (evil-define-key 'normal 'global (kbd "<leader> o r c") 'org-roam-capture)

  ;; -------------------------------
  ;; ORG LOCAL LEADER (SPC m)
  ;; -------------------------------
  (with-eval-after-load 'org
    (evil-define-key '(normal visual) org-mode-map
      (kbd "<leader> m t t") 'org-todo
      (kbd "<leader> m t s") 'org-schedule
      (kbd "<leader> m t d") 'org-deadline

      (kbd "<leader> m p a") 'org-priority-up
      (kbd "<leader> m p d") 'org-priority-down

      (kbd "<leader> m r .") '+org/refile-to-current-file
      (kbd "<leader> m r c") '+org/refile-to-running-clock
      (kbd "<leader> m r l") '+org/refile-to-last-location
      (kbd "<leader> m r f") '+org/refile-to-file
      (kbd "<leader> m r o") '+org/refile-to-other-window
      (kbd "<leader> m r O") '+org/refile-to-other-buffer
      (kbd "<leader> m r v") '+org/refile-to-visible
      (kbd "<leader> m r r") 'org-refile
      (kbd "<leader> m r R") 'org-refile-reverse

      (kbd "<leader> m c c") 'org-clock-cancel
      (kbd "<leader> m c i") 'org-clock-in
      (kbd "<leader> m c o") 'org-clock-out

      (kbd "<leader> m s n") 'org-narrow-to-subtree
      (kbd "<leader> m s w") 'widen

      (kbd "<leader> m l i") 'org-insert-link
      (kbd "<leader> m l o") 'org-open-at-point)))

;; -------------------------------
;; WHICH-KEY DESCRIPTIONS
;; -------------------------------
(with-eval-after-load 'which-key
  (which-key-add-key-based-replacements
    "SPC q" "quit"
    "SPC w" "save file"

    "SPC f" "files"
    "SPC f f" "find file"
    "SPC f r" "recent files"
    "SPC f d" "dired"
    "SPC f p" "personal config"

    "SPC b" "buffers"
    "SPC b b" "list buffers"
    "SPC b d" "kill buffer"
    "SPC b s" "save buffer"
    "SPC b c" "collapse outline"
    "SPC b e" "expand outline"

    "SPC p" "projects"
    "SPC p p" "switch project"
    "SPC p f" "find file in project"
    "SPC p b" "project buffers"
    "SPC p k" "kill project buffers"

    "SPC s" "search"
    "SPC s f" "find file"
    "SPC s g" "grep"
    "SPC s r" "ripgrep"
    "SPC /" "search line"

    "SPC g" "git"
    "SPC g g" "magit status"
    "SPC g l" "magit log"
    "SPC g d" "magit diff"

    "SPC h" "help"
    "SPC h f" "describe function"
    "SPC h v" "describe variable"
    "SPC h m" "describe mode"
    "SPC h k" "describe key"

    "SPC u" "undo tree"

    "SPC x" "misc commands"
    "SPC x x" "flymake"

    "SPC o" "org"
    "SPC o a" "agenda"
    "SPC o c" "capture"
    "SPC o l" "store link"
    "SPC o f" "open file"
    "SPC o r" "org-roam"
    "SPC o r f" "find node"
    "SPC o r i" "insert node"
    "SPC o r g" "graph"
    "SPC o r c" "capture node"

    ;; Local leader (SPC m)
    "SPC m" "local-leader"
    "SPC m t" "todo"
    "SPC m p" "priority"
    "SPC m r" "refile"
    "SPC m c" "capture/clock"
    "SPC m s" "subtree"
    "SPC m l" "links"))

(provide 'keymaps)
;;; keymaps.el ends here

