;; rename a file along w/ buffer - thanks to Steve Yegge
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
				(filename (buffer-file-name)))
    (if (not filename)
				(message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
					(message "A buffer named '%s' already exists!" new-name)
				(progn
					(rename-file name new-name 1)
					(rename-buffer new-name)
					(set-visited-file-name new-name)
					(set-buffer-modified-p nil))))))

(provide 'functions/rename-file-and-buffer)
