;;; MAGIT
;; `magit' is a powerful Git interface for Emacs that provides a complete
;; set of features to manage Git repositories. With its intuitive interface,
;; you can easily stage, commit, branch, merge, and perform other Git
;; operations directly from Emacs. Magit’s powerful UI allows for a seamless
;; workflow, enabling you to visualize your repository's history and manage
;; changes efficiently.
;;
;; In the Neovim ecosystem, similar functionality is provided by plugins such as
;; `fugitive.vim', which offers a robust Git integration with commands that
;; allow you to perform Git operations directly within Neovim. Another popular
;; option is `neogit', which provides a more modern and user-friendly interface
;; for Git commands in Neovim, leveraging features like diff views and staging
;; changes in a visual format. Both of these plugins aim to replicate and
;; extend the powerful capabilities that Magit offers in Emacs.
(use-package magit
  :ensure t
  :straight t
  :config
  (if ek-use-nerd-fonts   ;; Check if nerd fonts are being used
	  (setopt magit-format-file-function #'magit-format-file-nerd-icons)) ;; Turns on magit nerd-icons
  :defer t)

(provide 'git)
