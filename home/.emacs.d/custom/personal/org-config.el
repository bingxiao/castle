;; TODO: setup org-capture from Firefox for links
(require 'org)

;; Add TODO extra keywords
;; Warning: the shortcuts in parenthesis might mess with vim emulation
;; See org-use-fast-todo-selection
(setq org-todo-keywords
  (quote ((sequence "TODO(t)" "|" "DONE(d)" "DEFER(f)"))))

;; File locations
;; TODO: Fixme
(org-agenda-files (quote ("c:/Users/natany/Desktop/projects.org")))
(require 'org-latex)


;; Latex export
;; from http://orgmode.org/worg/org-tutorials/org-latex-export.html
;; for prettier exports, see:
;; - http://emacs-fu.blogspot.com/2011/04/nice-looking-pdfs-with-org-mode-and.html
;; Export to PDF w/ "C-c C-e p"
;; first you need to fix Emacs' PATH so that zsh will find pdflatex.
;; See http://stackoverflow.com/questions/4393628/emacs-shell-command-not-found
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))

(add-to-list 'org-export-latex-classes
             `("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}"))
             )
(add-to-list 'org-export-latex-classes
             `("natan-writing"
               ,(concat
		 "\\documentclass{article}"
		 "\\linespread{1.2}" ;; TODO: only set this for the body
		 "\\setlength{\\parskip}{1ex plus 0.5ex minus 0.2ex}")
               ("\\section{%s}" . "\\section*{%s}")))

;; create an org-mode link from my old links
;; e.g. creates a link from the following
;; link name
;;    link
;; note the indentation before link
(fset 'turn-name-\\n-link-to-org-link
   "Djjpk0xxxi[[\C-e]\C-f[\C-e]]jkkJxkJ")

(provide 'personal/org-config)
