;; Angry fruit salad - a mode for tailing log files
(defvar angry-fruit-salad-log-view-mode-map
  (make-sparse-keymap))

(define-minor-mode angry-fruit-salad-log-view-mode
  "View logs with colors.
   Angry colors."
  nil " AngryLog" nil

  (cond (angry-fruit-salad-log-view-mode
         ;; added due to the above settings - might not work
         ;; if the file will only change at the end, this is more efficient
         ;; (auto-revert-tail-mode 1)
         (auto-revert-mode 1)
         (highlight-changes-mode 1)
         (highlight-changes-visible-mode 1)
         (define-key angry-fruit-salad-log-view-mode-map
           (kbd "C-c C-r")
           'highlight-changes-rotate-faces)
         (if (current-local-map)
             (set-keymap-parent angry-fruit-salad-log-view-mode-map
                                (current-local-map)))
         ;; set the keymap
         (use-local-map angry-fruit-salad-log-view-mode-map))

        (t
         ;; (auto-revert-tail-mode -1)
         (auto-revert-mode -1)
         (highlight-changes-mode -1)
         (use-local-map (keymap-parent angry-fruit-salad-log-view-mode-map)))))

(provide 'functions/angry-fruit-salad)
