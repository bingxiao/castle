;; Auto-completion and ido-mode
;; For tips on ido-mode:
;; - http://emacsblog.org/2008/05/19/giving-ido-mode-a-second-chance/
;; - http://www0.fh-trier.de/~politza/emacs/ido-hacks.el.gz

;; Better auto-completion
;; To customize see hippie-expand-try-functions-list
;; TODO: Use M-? (shift /) for prior dabbrev expansion
(global-set-key "\M-/" 'dabbrev-expand) ;; expand word
(global-set-key "\M--" 'hippie-expand)	;; expand lines

;; ???
;; (add-to-list 'load-path "~/.emacs.d/")
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;; (ac-config-default)

;; Configure Ido
;; See also http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-use-virtual-buffers t)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".org" ".c" ".h" ".cc" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))
(set-face-italic-p 'ido-virtual t) ;; italicize virtual buffers
(ido-everywhere 1)
(ido-mode 1)

;; Enable smex autocompletion in the minibuffer with ido
(require 'smex)
(smex-initialize)
(smex-auto-update)
(global-set-key (kbd "M-x") 'smex)

;; restore the normal behavior of <space> in the minibuffer
;; from http://www.emacswiki.org/emacs/Smex
(defadvice smex (around space-inserts-hyphen activate compile)
  (let ((ido-cannot-complete-command 
	  `(lambda ()
	     (interactive)
	     (if (string= " " (this-command-keys))
	       (insert ?-)
	       (funcall ,ido-cannot-complete-command)))))
    ad-do-it))

;; This tab override shouldn't be necessary given ido's default 
;; configuration, but minibuffer-complete otherwise dominates the 
;; tab binding because of my custom tab-completion-everywhere 
;; configuration.
;;(add-hook 'ido-setup-hook 
;;          (lambda () 
;;            (define-key ido-completion-map (kbd "TAB") 'ido-complete)))

;; Keyboard shortcuts inside the completion minibuffer
(define-key ido-file-dir-completion-map "\C-a" 'beginning-of-line) ;; this used to toggle hidden files
(define-key ido-buffer-completion-map "\C-a" 'beginning-of-line) 

;; Auto-complete recent files
;; From http://git.sanityinc.com/?p=emacs.d.git;a=blob;f=init.el;hb=HEAD
(require 'recentf)
(setq recentf-max-saved-items 100)
(defun steve-ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (find-file (ido-completing-read "Open file: " recentf-list nil t)))
(global-set-key [(meta f11)] 'steve-ido-choose-from-recentf)

;; auto-complete bookmarks - from http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings#toc6
;;(setq enable-recursive-minibuffers t)
;;(define-key ido-file-dir-completion-map [(meta control ?b)] 'ido-goto-bookmark)
;;(defun ido-goto-bookmark (bookmark)
;;  (interactive
;;    (list (bookmark-completing-read "Jump to bookmark"
;;	    bookmark-current-bookmark)))
;;  (unless bookmark
;;    (error "No bookmark specified"))
;;  (let ((filename (bookmark-get-filename bookmark)))
;;    (ido-set-current-directory
;;      (if (file-directory-p filename)
;;	filename
;;	(file-name-directory filename)))
;;    (setq ido-exit        'refresh
;;      ido-text-init   ido-text
;;      ido-rotate-temp t)
;;    (exit-minibuffer)))

(provide 'personal/autocomplete)
