;; Save recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Desktop saving - always save a list of open files 
(setq desktop-save 't)
(desktop-save-mode 1)
;; save the desktop file automatically if it already exists
;; (setq desktop-save 'if-exists)`
;; (setq desktop-restore-eager 3)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))

;; store backups in ~/.save, autosaves in ~/.autosaves, and save more backups!
;; see http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files

;; (setq backup-directory-alist `(("." . "~/.saves")))
;; (setq auto-save-file-name-transforms `((".*" "~/.autosaves/\\1" t)))
;; create the autosave dir if necessary, since emacs won't.
;; (make-directory "~/.autosaves/" t)

;; just save to window's temp dir
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; save more old versions
(setq delete-old-versions t
			kept-new-versions 6
			kept-old-versions 2
			version-control t)

;; workgroups
;; (require 'workgroups)
;; (setq wg-prefix-key (kbd "C-c w"))
;; (workgroups-mode 1)

(provide 'personal/desktop)
