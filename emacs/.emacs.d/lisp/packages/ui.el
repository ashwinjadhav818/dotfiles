;;; CORFU
;; Corfu Mode provides a text completion framework for Emacs.
;; It enhances the editing experience by offering context-aware
;; suggestions as you type.
;; Corfu Mode is highly customizable and can be integrated with
;; various modes and languages.
(use-package corfu
  :ensure t
  :straight t
  :defer t
  :custom
  (corfu-auto nil)                        ;; Only completes when hitting TAB
  ;; (corfu-auto-delay 0)                ;; Delay before popup (enable if corfu-auto is t)
  (corfu-auto-prefix 1)                  ;; Trigger completion after typing 1 character
  (corfu-quit-no-match t)                ;; Quit popup if no match
  (corfu-scroll-margin 5)                ;; Margin when scrolling completions
  (corfu-max-width 50)                   ;; Maximum width of completion popup
  (corfu-min-width 50)                   ;; Minimum width of completion popup
  (corfu-popupinfo-delay 0.5)            ;; Delay before showing documentation popup
  :config
  (if ek-use-nerd-fonts
    (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode t))


;;; NERD-ICONS-CORFU
;; Provides Nerd Icons to be used with CORFU.
(use-package nerd-icons-corfu
  :if ek-use-nerd-fonts
  :ensure t
  :straight t
  :defer t
  :after (:all corfu))

;;; ELDOC-BOX
;; eldoc-box enhances the default Eldoc experience by displaying documentation in a popup box,
;; usually in a child frame. This makes it easier to read longer docstrings without relying on
;; the minibuffer. It integrates seamlessly with Eldoc and activates when Eldoc is active.
;; Useful for graphical Emacs; terminal users may want to fall back to `eldoc-box-display-at-point-mode'.
(use-package eldoc-box
  :ensure t
  :straight t
  :defer t)


;;; DIFF-HL
;; The `diff-hl' package provides visual indicators for version control changes
;; directly in the margin of the buffer, showing lines added, deleted, or changed.
;; This is useful for tracking modifications while you edit files. When enabled,
;; it automatically activates in every buffer that has a corresponding version
;; control backend, offering a seamless experience.
;;
;; In comparison, Neovim users often rely on plugins like `gitsigns.nvim' or
;; `vim-signify', which provide similar functionalities by displaying Git
;; changes in the gutter and offer additional features like highlighting
;; changed lines and displaying blame information. `diff-hl' aims to provide
;; a comparable experience in Emacs with its own set of customizations.
(use-package diff-hl
  :defer t
  :straight t
  :ensure t
  :hook
  (find-file . (lambda ()
                 (global-diff-hl-mode)           ;; Enable Diff-HL mode for all files.
                 (diff-hl-flydiff-mode)          ;; Automatically refresh diffs.
                 (diff-hl-margin-mode)))         ;; Show diff indicators in the margin.
  :custom
  (diff-hl-side 'left)                           ;; Set the side for diff indicators.
  (diff-hl-margin-symbols-alist '((insert . "┃") ;; Customize symbols for each change type.
                                  (delete . "-")
                                  (change . "┃")
                                  (unknown . "┆")
                                  (ignored . "i"))))

;;; RAINBOW DELIMITERS
;; The `rainbow-delimiters' package provides colorful parentheses, brackets, and braces
;; to enhance readability in programming modes. Each level of nested delimiter is assigned
;; a different color, making it easier to match pairs visually.
(use-package rainbow-delimiters
  :defer t
  :straight t
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))

;;; PULSAR
;; The `pulsar' package enhances the user experience in Emacs by providing
;; visual feedback through pulsating highlights. This feature is especially
;; useful in programming modes, where it can help users easily track
;; actions such as scrolling, error navigation, yanking, deleting, and
;; jumping to definitions.
(use-package pulsar
  :defer t
  :straight t
  :ensure t
  :hook
  (after-init . pulsar-global-mode)
  :config
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.025)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'evil-ex-lazy-highlight)

  (add-to-list 'pulsar-pulse-functions 'evil-scroll-down)
  (add-to-list 'pulsar-pulse-functions 'flymake-goto-next-error)
  (add-to-list 'pulsar-pulse-functions 'flymake-goto-prev-error)
  (add-to-list 'pulsar-pulse-functions 'evil-yank)
  (add-to-list 'pulsar-pulse-functions 'evil-yank-line)
  (add-to-list 'pulsar-pulse-functions 'evil-delete)
  (add-to-list 'pulsar-pulse-functions 'evil-delete-line)
  (add-to-list 'pulsar-pulse-functions 'evil-jump-item)
  (add-to-list 'pulsar-pulse-functions 'diff-hl-next-hunk)
  (add-to-list 'pulsar-pulse-functions 'diff-hl-previous-hunk))


;;; DOOM MODELINE
;; The `doom-modeline' package provides a sleek, modern mode-line that is visually appealing
;; and functional. It integrates well with various Emacs features, enhancing the overall user
;; experience by displaying relevant information in a compact format.
(use-package doom-modeline
  :ensure t
  :straight t
  :defer t
  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)  ;; Set the buffer file name style to just the buffer name (without path).
  (doom-modeline-project-detection 'project)           ;; Enable project detection for displaying the project name.
  (doom-modeline-buffer-name t)                        ;; Show the buffer name in the mode line.
  (doom-modeline-vcs-max-length 25)                    ;; Limit the version control system (VCS) branch name length to 25 characters.
  :config
  (if ek-use-nerd-fonts                                ;; Check if nerd fonts are being used.
      (setq doom-modeline-icon t)                      ;; Enable icons in the mode line if nerd fonts are used.
    (setq doom-modeline-icon nil))                     ;; Disable icons if nerd fonts are not being used.
  :hook
  (after-init . doom-modeline-mode))


;;; NEOTREE
;; The `neotree' package provides a file tree explorer for Emacs, allowing easy navigation
;; through directories and files. It presents a visual representation of the file system
;; and integrates with version control to show file states.
(use-package neotree
  :ensure t
  :straight t
  :custom
  (neo-show-hidden-files t)                ;; By default shows hidden files (toggle with H)
  (neo-theme 'nerd)                        ;; Set the default theme for Neotree to 'nerd' for a visually appealing look.
  (neo-vc-integration '(face char))        ;; Enable VC integration to display file states with faces (color coding) and characters (icons).
  :defer t                                 ;; Load the package only when needed to improve startup time.
  :config
  (if ek-use-nerd-fonts                    ;; Check if nerd fonts are being used.
      (setq neo-theme 'nerd-icons)         ;; Set the theme to 'nerd-icons' if nerd fonts are available.
    (setq neo-theme 'nerd)))               ;; Otherwise, fall back to the 'nerd' theme.

;;; CENTUAR TABS
;; The `centuar-tabs` package provides a sleek and modern tab bar
(use-package centaur-tabs
  :straight t
  :defer nil
  :config
  ;; Enable the tab bar
  (centaur-tabs-mode t)

  ;; Style and markers
  (setq centaur-tabs-style "wave")
  (setq centaur-tabs-set-bar 'over)
  (setq centaur-tabs-modified-marker "*")

  ;; Enable icons
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-icon-type 'nerd-icons)

  ;; Grouping behavior
  (setq centaur-tabs-group-by-projectile-project t)
  (setq centaur-tabs-headline-match t)

  "Hide centaur-tabs in the *dashboard* buffer."
  (defun my/dashboard-hide-tabs ()
  (when (string= (buffer-name) "*dashboard*")
    (centaur-tabs-local-mode t)))

  (add-hook 'dashboard-mode-hook #'my/dashboard-hide-tabs)


  :bind
  ("C-<tab>"   . centaur-tabs-forward)
  ("C-S-<tab>" . centaur-tabs-backward))

;;; DASHBOARD
;; An extensible emacs startup screen showing you what’s most important.
(use-package dashboard
  :straight t
  :config
  ;; Initialize
  (add-hook 'after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'after-init-hook #'dashboard-initialize)

  ;; Set dashboard as startup screen
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (dashboard-setup-startup-hook))

;; Config
(setq dashboard-startup-banner "~/.emacs.d/icons/emacs.svg")    ; custom emacs icon
(setq dashboard-image-banner-max-height 200)
(setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
(setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
(setq dashboard-center-content t)
(setq dashboard-items '((recents   . 5)
                        (projects  . 5)
                        (agenda    . 5)))

;;; NERD ICONS
;; The `nerd-icons' package provides a set of icons for use in Emacs. These icons can
;; enhance the visual appearance of various modes and packages, making it easier to
;; distinguish between different file types and functionalities.
(use-package nerd-icons
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :straight t
  :defer t)                               ;; Load the package only when needed to improve startup time.


;;; NERD ICONS Dired
;; The `nerd-icons-dired' package integrates nerd icons into the Dired mode,
;; providing visual icons for files and directories. This enhances the Dired
;; interface by making it easier to identify file types at a glance.
(use-package nerd-icons-dired
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :straight t
  :defer t                                ;; Load the package only when needed to improve startup time.
  :hook
  (dired-mode . nerd-icons-dired-mode))


;;; NERD ICONS COMPLETION
;; The `nerd-icons-completion' package enhances the completion interfaces in
;; Emacs by integrating nerd icons with completion frameworks such as
;; `marginalia'. This provides visual cues for the completion candidates,
;; making it easier to distinguish between different types of items.
(use-package nerd-icons-completion
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :straight t
  :after (:all nerd-icons marginalia)     ;; Load after `nerd-icons' and `marginalia' to ensure proper integration.
  :config
  (nerd-icons-completion-mode)            ;; Activate nerd icons for completion interfaces.
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)) ;; Setup icons in the marginalia mode for enhanced completion display.

(provide 'ui)
