(load-file "~/../../Downloads/emacs-23.3/site-lisp/packages/cedet-1.0/common/cedet.el")
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu(global-ede-mode 1)

(provide 'cedet-config)
