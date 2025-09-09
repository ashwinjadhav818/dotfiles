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
  "Open the personal Emacs config folder."
  (interactive)
  (dired "~/.emacs.d"))

(defun org-find-file ()
  "Fuzzy search and open a file in `org-directory`."
  (interactive)
  (find-file
   (completing-read "Find org file: "
                    (directory-files-recursively "~/org" "\\.org$"))))


(with-eval-after-load 'evil
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
  (evil-define-key 'normal 'global (kbd "<leader> b d") 'kill-current-buffer)
  (evil-define-key 'normal 'global (kbd "<leader> b s") 'save-buffer)
  (evil-define-key 'normal 'global (kbd "<leader> b c") 'outline-hide-sublevels)
  (evil-define-key 'normal 'global (kbd "<leader> b e") 'outline-show-all)
  (evil-define-key 'normal 'global (kbd "] b") 'switch-to-next-buffer)
  (evil-define-key 'normal 'global (kbd "[ b") 'switch-to-prev-buffer)

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
  (evil-define-key 'normal 'global (kbd "<leader> s g") 'consult-grep)
  (evil-define-key 'normal 'global (kbd "<leader> s r") 'consult-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader> /") 'consult-line)

  ;; -------------------------------
  ;; GIT
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "<leader> g g") 'magit-status)
  (evil-define-key 'normal 'global (kbd "<leader> g l") 'magit-log-current)
  (evil-define-key 'normal 'global (kbd "<leader> g d") 'magit-diff-buffer-file)
  (evil-define-key 'normal 'global (kbd "] c") 'diff-hl-next-hunk)
  (evil-define-key 'normal 'global (kbd "[ c") 'diff-hl-previous-hunk)

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
  (evil-define-key 'normal 'global (kbd "<leader> x x") 'consult-flymake)

  ;; -------------------------------
  ;; YANK / EMBARK
  ;; -------------------------------
  (evil-define-key 'normal 'global (kbd "P") 'consult-yank-from-kill-ring)
  (evil-define-key 'normal 'global (kbd "<leader> P") 'consult-yank-from-kill-ring)
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
  ;; WHICH-KEY DESCRIPTIONS
  ;; -------------------------------
  (with-eval-after-load 'which-key
    (which-key-add-key-based-replacements
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
      "SPC o r c" "capture node")))

(provide 'keymaps)
;;; keymaps.el ends here
