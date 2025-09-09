;;; VERTICO
;; Vertico enhances the completion experience in Emacs by providing a
;; vertical selection interface for both buffer and minibuffer completions.
;; Unlike traditional minibuffer completion, which displays candidates
;; in a horizontal format, Vertico presents candidates in a vertical list,
;; making it easier to browse and select from multiple options.
;;
;; In buffer completion, `switch-to-buffer' allows you to select from open buffers.
;; Vertico streamlines this process by displaying the buffer list in a way that
;; improves visibility and accessibility. This is particularly useful when you
;; have many buffers open, allowing you to quickly find the one you need.
;;
;; In minibuffer completion, such as when entering commands or file paths,
;; Vertico helps by showing a dynamic list of potential completions, making
;; it easier to choose the correct one without typing out the entire string.
(use-package vertico
  :ensure t
  :straight t
  :hook
  (after-init . vertico-mode)           ;; Enable vertico after Emacs has initialized.
  :custom
  (vertico-count 10)                    ;; Number of candidates to display in the completion list.
  (vertico-resize nil)                  ;; Disable resizing of the vertico minibuffer.
  (vertico-cycle nil)                   ;; Do not cycle through candidates when reaching the end of the list.
  :config
  ;; Customize the display of the current candidate in the completion list.
  ;; This will prefix the current candidate with “» ” to make it stand out.
  ;; Reference: https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow
  (advice-add #'vertico--format-candidate :around
              (lambda (orig cand prefix suffix index _start)
                (setq cand (funcall orig cand prefix suffix index _start))
                (concat
                 (if (= vertico--index index)
                     (propertize "» " 'face '(:foreground "#80adf0" :weight bold))
                   "  ")
                 cand))))


;;; ORDERLESS
;; Orderless enhances completion in Emacs by allowing flexible pattern matching.
;; It works seamlessly with Vertico, enabling you to use partial strings and
;; regular expressions to find files, buffers, and commands more efficiently.
;; This combination provides a powerful and customizable completion experience.
(use-package orderless
  :ensure t
  :straight t
  :defer t                                    ;; Load Orderless on demand.
  :after vertico                              ;; Ensure Vertico is loaded before Orderless.
  :init
  (setq completion-styles '(orderless basic)  ;; Set the completion styles.
        completion-category-defaults nil      ;; Clear default category settings.
        completion-category-overrides '((file (styles partial-completion))))) ;; Customize file completion styles.


;;; MARGINALIA
;; Marginalia enhances the completion experience in Emacs by adding
;; additional context to the completion candidates. This includes
;; helpful annotations such as documentation and other relevant
;; information, making it easier to choose the right option.
(use-package marginalia
  :ensure t
  :straight t
  :hook
  (after-init . marginalia-mode))


;;; CONSULT
;; Consult provides powerful completion and narrowing commands for Emacs.
;; It integrates well with other completion frameworks like Vertico, enabling
;; features like previews and enhanced register management. It's useful for
;; navigating buffers, files, and xrefs with ease.
(use-package consult
  :ensure t
  :straight t
  :defer t
  :init
  ;; Enhance register preview with thin lines and no mode line.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult for xref locations with a preview feature.
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))


;;; EMBARK
;; Embark provides a powerful contextual action menu for Emacs, allowing
;; you to perform various operations on completion candidates and other items.
;; It extends the capabilities of completion frameworks by offering direct
;; actions on the candidates.
;; Just `<leader> .' over any text, explore it :)
(use-package embark
  :ensure t
  :straight t
  :defer t)


;;; EMBARK-CONSULT
;; Embark-Consult provides a bridge between Embark and Consult, ensuring
;; that Consult commands, like previews, are available when using Embark.
(use-package embark-consult
  :ensure t
  :straight t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode)) ;; Enable preview in Embark collect mode.

(provide 'misc)
