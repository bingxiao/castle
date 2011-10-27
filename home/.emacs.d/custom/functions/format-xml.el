;; Functions for XML
;; from http://stackoverflow.com/questions/12492/pretty-printing-xml-files-on-emacs
(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. The function inserts linebreaks to separate
   tags that have nothing but whitespace between them. It then indents the markup
   by using indentation rules."
  (interactive "r")
  (save-excursion
		(goto-char begin)
		(while (search-forward-regexp "\>[ \\t]*\<" nil t) 
			(backward-char) (insert "\n"))
		(indent-region begin end))
  (message "Ah, much better!"))

(defun ny-format-xml ()
  (interactive)
  (save-excursion
		(goto-char (point-min))
		(while (search-forward-regexp "\>[ \\t]*\<" nil t) 
			(backward-char) (insert "\n"))
		(indent-region (point-min) (point-max)))
  (message "Ah, much better!"))

(provide 'functions/format-xml)

