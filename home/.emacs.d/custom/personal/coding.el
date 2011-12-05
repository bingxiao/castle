;;; Coding settings

;; Automatic indentation
;; Also see tabs/spaces settings below
(define-key global-map (kbd "RET") 'newline-and-indent) ;; doesn't work for ruby, might work for others
(add-hook 'c-mode-common-hook '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'lisp-mode-hook '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'emacs-lisp-mode-hook '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'html-mode-hook '(lambda () (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'ruby-mode-hook '(lambda () (local-set-key (kbd "RET") 'reindent-then-newline-and-indent)))
(add-hook 'asm-mode-hook '(lambda () (local-set-key (kbd "RET") 'newline)))

;; HAML mode (added acc to http://www.emacswiki.org/emacs/HamlMode)
(add-hook 'haml-mode-hook
  '(lambda ()
     (setq indent-tabs-mode nil)
     (define-key haml-mode-map "\C-m" 'newline-and-indent)))

(add-hook 'css-mode-hook '(lambda () (css-color-mode 1)))

;; File associations
(add-to-list 'auto-mode-alist '("\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;; Flymake
;; this is ugly, but not as bad as the default
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

;; Use nxhtml-mode for html files
;; I use mumamo instead
;;(add-to-list 'auto-mode-alist '("\.html$" . nxhtml-mode))

;; Indentation styles for C-like languages
(setq c-default-style
  '((java-mode . "java") (awk-mode . "awk") (other . "linux")))

;; Lisp indentation
(setq lisp-indent-offset 2)

;; Use TAB for smart indentation, not a single, literal, tab
(global-set-key (kbd "TAB") 'self-insert-command)

;; Use tabs, not spaces, for indentation globally
;; TODO: Change this?
(setq indent-tabs-mode t)
(setq-default indent-tabs-mode t)
(setq ruby-indent-level 4)

(mapcar (lambda (hooksym)
	  (add-hook hooksym
	    (lambda ()
	      (setq tab-width 4)
	      (setq c-basic-indent 4)
	      (setq c-basic-offset 4)
	      (setq indent-tabs-mode t))))
  '(
     c-mode-common-hook
     ;; add other hook functions here, one for each mode you use :-(
     ))

;; keyboard shortcut - Use `C-x o` to swtich between header/implementation files
;; when evil is enabled, ,o also does this
(add-hook 'c-mode-common-hook (lambda() (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; highlight TODO, FIXME, and BUG in cc-mode
(add-hook 'c-mode-common-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))


;; enable folding (use vim keybindings - za, zm, etc.)
(load-library "hideshow")
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; autopair - see http://emacs-fu.blogspot.com/2010/06/automatic-pairing-of-brackets-and.html
(require 'autopair)
(setq autopair-autowrap t)
;; (autopair-global-mode 1)

;; show matching parenthesis
(show-paren-mode t)
;; (setq show-paren-style 'expression)

;; show the current function in the header line - from http://www.emacswiki.org/emacs/WhichFuncMode
(load "which-func")
(which-func-mode)

(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq which-func-header-line-format
  '(which-func-mode
     ("" which-func-format)))
(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (delete (assoc 'which-func-mode mode-line-format) mode-line-format)
    (setq header-line-format which-func-header-line-format)))


;; compile remotely 
(require 'tramp-util)

;; don't indent extern "C" { }
(add-hook 'c-mode-common-hook
  (lambda()
    (c-set-offset 'inextern-lang 0)))

(provide 'personal/coding)

