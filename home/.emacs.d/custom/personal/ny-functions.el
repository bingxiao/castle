;; functions mostly used for vimpulse leader shortcuts

(require 'follow)

(defun ny-now ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)
  (insert (format-time-string "%D %-I:%M %p")))

(defun ny-american-today ()
  "Insert string for today's date nicely formatted in American style,
e.g. Sunday, September 17, 2000."
  (interactive)
  (insert (format-time-string "%A, %B %e, %Y")))

(defun ny-today ()
  "Insert string for today's date formatted Israeli style (DD/MM/YY)"
  (interactive)
  (insert (format-time-string "%d/%m/%y")))

;; reverting buffers
(defun ny-revert-buffer-no-confirm ()
  (interactive)
  (revert-buffer t t))


;; splits and windows
(defun ny-new-vsplit ()
  "Like :vsplit in Vim"
  (interactive)
  (split-window-horizontally)
  (windmove-right))

(defun ny-new-hsplit ()
  "Like :split in Vim"
  (interactive)
  (split-window-vertically)
  (windmove-down))

(defun ny-4rectangle-split ()
  "Splits the screen into 4 rectangular windows"
  (interactive)
  (ny-maximize-spit)
  (split-window-horizontally)
  (split-window-vertically)
  (windmove-right)
  (split-window-vertically)
  (windmove-left))

(defun ny-maximize-spit ()
  (interactive)
  (delete-other-windows))

(defun ny-kill-other-buffer ()
  "Kill the other buffer, especially a pesky compilation window"
  (interactive)
  (other-window 1)
  (kill-buffer (current-buffer))
  (other-window -1))

(defun ny-transpose-windows ()
  "From http://stackoverflow.com/questions/1510091/with-emacs-how-do-you-swap-the-position-of-2-windows/1510133#1510133"
  (interactive)
  (let ((this-buffer (window-buffer (selected-window)))
	 (other-buffer (prog2
			 (other-window +1)
			 (window-buffer (selected-window))
			 (other-window -1))))
    (switch-to-buffer other-buffer)
    (switch-to-buffer-other-window this-buffer)
    (other-window -1)))


;; editing special files
(defun ny-edit-dot-emacs ()
  (interactive)
  (find-file "~/.emacs"))


;; follow-mode - activates and duplicates the current buffer
(defun ny-follow-mode-duplicate-buffer ()
  (interactive)
  (if follow-mode
    (progn
      (message "de-activating follow-mode")
      (turn-off-follow-mode))
    (progn
      (message "activating follow-mode")
      (follow-mode t)
      (switch-to-buffer-other-window (buffer-name)))))


;; eval lisp
(defun ny-eval-region-dwim ()
  "Evaluates the current region if it exists. Otherwise evals the current line"
  (interactive)
  ;; if there is no region, select current line
  (when (not (evil-visual-state-p))
    (evil-visual-line))
  (message "eval-region") ;; output from eval-region will overwrite this
  (eval-region (region-beginning) (region-end))
  ;; de-activate visual mode
  (evil-visual-line))

(defun ny-eval-buffer ()
  "Evaluates the current buffer and prints confirmation"
  (interactive)
  (message "eval-buffer") ;; output from eval-buffer will overwrite this
  (eval-buffer))

;; markerpen
(defun ny-markerpen-mark-line ()
  (interactive)
  (evil-visual-line)
  (markerpen-mark-region 4))

(defun ny-markerpen-clear-line ()
  (interactive)
  (evil-visual-line)
  (markerpen-clear-region))

(defun ny-markerpen-mark-dwim ()
  (interactive)
  (if (evil-visual-state-p)
    (progn
      (markerpen-mark-region 4)
      (message "marking region"))
    (progn
      (ny-markerpen-mark-line)
      (message "marking line"))))

(defun ny-markerpen-clear-dwim ()
  (interactive)
  (if (evil-visual-state-p)
    (progn
      (markerpen-clear-region)
      (message "clearing region"))
    (progn
      (ny-markerpen-clear-line)
      (message "clearing line"))))


;; indentation
(defun ny-indent-buffer ()
  (interactive)
  (indent-region (buffer-end -1) (buffer-end 1)))


;; highlighting
(defun ny-clear-highlights ()
  "Broken"
  (interactive)
  (hi-lock-unface-buffer ".*")) ;; This doesn't work unless we explicity hightlighted ".*"


;; pomodoro mode
(defun ny-pomodoro-toggle ()
  "Toggle pomodoro mode - doesn't work"
  (interactive)
  (if (string= pomodoro-state "work") ;; always true
    (pomodoro-stop)
    (pomodoro)))


;; minimap-mode
(defun ny-minimap-is-visible ()
  (interactive)
  (and minimap-bufname
    (get-buffer minimap-bufname)
    (get-buffer-window (get-buffer minimap-bufname))))

;; TODO: for a right-hand buffer in a split screen, create the minimap on the right
(defun ny-minimap-toggle ()
  (interactive)
  (if (ny-minimap-is-visible)
    (minimap-kill)
    (minimap-create)))


(provide 'personal/ny-functions)
