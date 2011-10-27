;; Deft settings
;; TODO: Use better filesnames for defts 
;; TODO: New deft notes are created in the root text/ directory
(require 'deft)
(eval-when-compile (require 'cl))

;; list of deft setups - each one is (name path ext mode)
(setq ny-defts
  '(("blogging" "~/Dropbox/text/blogging" "txt" text-mode)
     ("notes" "~/Dropbox/text/notes" "org" org-mode)
     ;;("academic" "~/Dropbox/text/academic" "org" org-mode)
     ("writing" "~/Dropbox/text/writing" "txt" text-mode)))

(defun ny-activate-deft (name)
  "Activates a deft setup from ny-defts"
  (let ((deft (assoc name ny-defts)))
    (when deft
      (setq deft-directory (second deft))
      (setq deft-extension (third deft))
      (setq deft-text-mode (fourth deft))
      )))

(defun ny-switch-deft ()
  "Switches between deft setups"
  (interactive)
  (let ((ny-deft-names (mapcar 'first ny-defts)))
    (ny-activate-deft (ido-completing-read "Choose a deft: " ny-deft-names)))
  ;; kill the existing buffer. if we were in deft, reactivate
  (when (get-buffer "*Deft*")
    (kill-buffer "*Deft*")
    (message "Foo"))
  (deft))

(ny-activate-deft "notes")

(provide 'personal/deft)
