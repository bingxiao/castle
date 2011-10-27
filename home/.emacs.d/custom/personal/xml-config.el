(require 'functions/format-xml)

;; Better xml editing
(load "nxhtml/autostart.el")
(nxml-where-global-mode)

;; automatically format XML on open
(add-hook 'nxml-mode-hook '(lambda ()
  (ny-format-xml)))

(provide 'personal/xml-config)
  
