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

(provide 'personal/org-config)
