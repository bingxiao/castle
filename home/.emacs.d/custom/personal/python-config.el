(require 'python-mode)

;; (require 'ipython)
;; (setq python-python-command "ipython")
;; (setq py-python-command-args '("-pylab" "-colors" "LightBG"))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;; run python
(defun compile-python ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-name))))
(setq compilation-scroll-output t)

;; See also comint.el 
(provide 'personal/python-config)
