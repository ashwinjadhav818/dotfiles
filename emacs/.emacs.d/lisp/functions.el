(defun +org/refile-to-current-file ()
  "Refile the current subtree to the current file."
  (interactive)
  (let ((org-refile-targets `((,(buffer-file-name) :maxlevel . 3))))
    (org-refile)))

(defun +org/refile-to-running-clock ()
  "Refile the current subtree to the heading currently clocked in."
  (interactive)
  (let ((org-refile-targets '((nil :tag "CLOCKING" :maxlevel . 1))))
    (org-refile)))

(defun +org/refile-to-last-location ()
  "Refile the current subtree to the last refiling location."
  (interactive)
  (org-refile nil nil '(4))) ; 4 = use last refiling location

(defun +org/refile-to-file ()
  "Refile the current subtree to a heading in a selected Org file."
  (interactive)
  ;; Step 1: select a file from org-directory
  (let* ((org-files (directory-files org-directory t "\\.org$"))
         (file (completing-read "Refile to file: " org-files nil t)))
    ;; Step 2: select a heading in the chosen file
    (let ((org-refile-targets `((,file :maxlevel . 5)))  ;; all headings up to level 5
          (org-refile-use-outline-path 'full)          ;; show full path
          (org-outline-path-complete-in-steps nil)     ;; select in one step
          (org-refile-allow-creating-parent-nodes nil)) ;; don't auto-create
      (org-refile))))



(defun +org/refile-to-other-window ()
  "Refile the current subtree to a heading in another window."
  (interactive)
  (let ((org-refile-use-outline-path 'file)
        (org-refile-allow-creating-parent-nodes 'confirm))
    (org-refile nil nil nil t))) ; t = other window

(defun +org/refile-to-other-buffer ()
  "Refile the current subtree to another buffer."
  (interactive)
  (let ((org-refile-use-outline-path 'file))
    (call-interactively 'org-refile)))

(defun +org/refile-to-visible ()
  "Refile the current subtree to a visible heading in current buffer."
  (interactive)
  (let ((org-refile-targets '((nil :maxlevel . 3))))
    (org-refile)))

(provide 'functions)
