;; from http://www.emacswiki.org/emacs/hexcolour.el
(require 'hexcolour)

;; alternative from same place
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property (match-beginning 0)
	   (match-end 0)
	   'face (list :background 
		   (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

(add-hook 'emacs-lisp-mode 'hexcoulour-add-to-font-lock)

;; A better version from http://www.emacswiki.org/emacs/HexColour
(require 'cl)
(defun hexcolour-luminance (color)
  "Calculate the luminance of a color string (e.g. \"#ffaa00\", \"blue\").
  This is 0.3 red + 0.59 green + 0.11 blue and always between 0 and 255."
  (let* ((values (x-color-values color))
	  (r (car values))
	  (g (cadr values))
	  (b (caddr values)))
    (floor (+ (* .3 r) (* .59 g) (* .11 b)) 256)))
(defun hexcolour-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil
    `((,(concat "#[0-9a-fA-F]\\{3\\}[0-9a-fA-F]\\{3\\}?\\|"
	  (regexp-opt (x-defined-colors) 'words))
        (0 (let ((colour (match-string-no-properties 0)))
             (put-text-property
	       (match-beginning 0) (match-end 0)
	       'face `((:foreground ,(if (> 128.0 (hexcolour-luminance colour))
				       "white" "black"))
			(:background ,colour)))))))))


(defun hexcolour-working-mode ()
  (interactive)
  (hexcolour-add-to-font-lock)
  (hexcolour-mode))

(provide 'personal/colorify-hexs)
