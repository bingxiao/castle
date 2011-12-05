;; TODO:
;; - Replace myself with my Emacs and leave for Hawaii.
;;   Need to give Emacs unfettered access to irc, email, github repos, and blog.
;;   Should probably let Emacs train on some old datasets of personal info & conversations
;;
;; - CEldoc mode
;; - Use Emacs starter kit, dev kit, or emacs-kicker
;; - Make emacs more project oriented (e.g. auto-load TAGS when I open a new file in diff project)
;;   1. https://github.com/technomancy/find-file-in-project/blob/master/find-file-in-project.el
;;   2. http://code.google.com/p/emacs-project-mode/
;;   3. https://github.com/defunkt/textmate.el
;;   4. eproject
;; - Get bookmarks working and allow quickly opening files on Desktop, etc.
;; - Learn kill rings (M-y to cycle?)
;; - More customizations from starter kit and http://www.kieranhealy.org/esk/starter-kit-bindings.html
;; - Keep related buffers together with elscreen http://emacs-fu.blogspot.com/2009/07/keeping-related-buffers-together-with.html
;; - pavpanchekha's literate .emacs: https://github.com/pavpanchekha/dotfiles/blob/master/.emacs.d/emacs.org

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(inhibit-startup-screen t)
  '(org-link-search-must-match-exact-headline nil)
  '(org-return-follows-link t)
  '(send-mail-function (quote smtpmail-send-it))
  '(smtpmail-smtp-server "smtp.gmail.com" t)
  '(smtpmail-smtp-service "smtp" t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(highlight-80+ ((nil (:background "grey" :foreground "black"))))
  '(hl-line ((t (:underline "white"))))
  '(isearch ((t (:foreground "#b58900" :background "black"))))
  '(lazy-highlight ((t (:foreground "black" :background "#999999"))))
  '(mumamo-background-chunk-major ((t nil)))
  '(mumamo-background-chunk-submode1 ((t nil)))
  '(mumamo-background-chunk-submode2 ((t nil)))
  '(mumamo-background-chunk-submode3 ((t nil)))
  '(mumamo-background-chunk-submode4 ((t nil)))
  '(nxml-where-marking ((default nil) (nil nil)))
  '(org-level-1 ((t (:inherit default :foreground "dodger blue"))))
  '(org-tag ((t (:foreground "light green" :weight bold))))
  '(org-tag-face ((t (:inherit org-tag :foreground "green")))))

;; setup load paths
(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'load-path "~/.emacs.d/custom/packages")

;; Add executables to emacs' path
(when (eq window-system 'ns)
  ;; Add executables to Emacs' PATH so that it can find them
  (push "/usr/texbin" exec-path)
  (setenv "PATH" (concat (getenv "PATH") ":/usr/texbin"))

  ;; Sometimes Emacs executes commands indirectly via a shell
  ;; Mac OS X normally executes shells (bash, zsh) as login shells. For zsh,
  ;; this means .zshrc isn't loaded and zsh wont be able to find commands
  ;; that aren't in the default OS X $PATH. 
  ;; Adding -i ensures that we get an interactive shell and .zshrc is loaded
  (let ((switches shell-command-switch))
    (require 'cl)
    (unless (search "i" switches)
      (setq shell-command-switch (concat switches "i"))))
  ;; TODO: fix the RVM recipe or set this manually
  ;;(setq ruby-compilation-executable "TODO")
  )

;; TODO: setup smtp for sending through gmail
;; This is broken
(setq message-send-mail-function 'smtpmail-send-it
  user-email-address "aantny@gmail.com"
  gnus-email-address "aantny@gmail.com"
  smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
  smtpmail-auth-credentials '(("smtp.gmail.com" 587 "aantny@gmail.com" nil))
  smtpmail-default-smtp-server "smtp.gmail.com"
  smtpmail-smtp-server "smtp.gmail.com"
  smtpmail-smtp-service 587
  smtpmail-local-domain "technion")

;; el-get
;; bootstrap el-get if it doesn't exist
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
    "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
    (lambda (s)
      (end-of-buffer)
      (eval-print-last-sexp))))

;; install cedet and org-mode 
;; both are included in emacs itself, but I like to run the latest versions
;; they are installed from collosal repositories, so we don't block on their installation
;; TODO: will this crash in the autoload for packages below?
;;(el-get nil '(cedet org-mode))

;; custom el-get recipes
(setq el-get-sources
  '((:name dictionary
      :type git
      :url "https://github.com/myrkr/dictionary-el.git")
     (:name diction
       :type http
       :url "http://ftp.sunet.se/pub/gnu/emacs-lisp/archive/diction.el")))

;; install other el-get packages
(setq my-packages
  '(el-get
     ;; general
     ;; See: https://bitbucket.org/jek/dot-emacs/src/31c6d525e006/el/emacs-goodies-el/dict.el
     ;; and: https://code.google.com/p/my-emace-file/source/browse/dictionary.el
     ;; TODO: add midnight.el and ido-ubiquitous (test with rename-file-and-buffer)
     autopair auto-pair+ browse-kill-ring deft diction dictionary
     full-ack markerpen magit minimap nxhtml scratch smex
     sunrise-commander synonyms thingatpt+ typing emacs-w3m

     ;; ruby
     ;; rinari must be before flymake-ruby
     rinari flymake-ruby ;html5

     ;; More text modes
     markdown-mode haml-mode coffee-mode yaml-mode 
     
     ;; useless, but fun
     ;; see also: http://www.emacswiki.org/emacs/PrettySymbol
     pretty-mode
     
     ;; larger packages - fear these
     cedet org-mode
     
     ;; vim emulation
     evil evil-leader evil-surround evil-numbers undo-tree

     ;; color themes
     ;; TODO: add http://jblevins.org/projects/emacs-color-themes/
     color-theme color-theme-almost-monokai color-theme-ir-black
     color-theme-sanityinc color-theme-solarized color-theme-tango
     color-theme-tango-2 color-theme-zenburn))

(el-get 'sync my-packages) ;; Warning: this blocks

;; Setup and configuration
(require 'personal/ui)			;; fullscreen, themes, and fonts
(require 'personal/editing)		;; general editing settings
(require 'personal/checkpoint)		;; checkpoint specific settings
(require 'personal/desktop)		;; save sessions, recent files, and better backups
(require 'personal/recycling)		;; recycle old bytes and buffers
(require 'personal/show-unique-buffer-names)
(require 'personal/ny-functions)
(require 'personal/lisp)
(require 'personal/org-config)
(require 'personal/vim)
(require 'personal/deft)
(require 'personal/erudite)		;; dictionaries and thesauri
(require 'personal/autocomplete)
(require 'personal/unzip-files)
(require 'personal/coding) 
(require 'personal/python-config)
(require 'personal/comint-config)
(require 'personal/xml-config)
;;(require 'personal/colorify-hexs) broken and breaks other things
;;(require 'personal/snippets)

;; Useful functions
(require 'functions/rename-file-and-buffer)
(require 'functions/move-buffer-file)
(require 'functions/format-xml)
(require 'functions/angry-fruit-salad)
(require 'functions/pretty-mode)
(require 'functions/toggle-naming-conventions)

;; auto-indent pasted code & more
(require 'auto-indent-mode)

;; More 3rd party packages

;; (require 'rainbow-delimiters) - TODO: customize the faces and byte-compile before using this
;; (require 'clearcase)
;;(require 'ffap)
;;(require 'markerpen)
(require 'highlight-80+) ;; TODO: this is obsolete - see http://nschum.de/src/emacs/highlight-80+/

;;(require 'highlight-symbol)
;;(require 'typing-speed)

;; Indent when pasting - BAD! this dirties the buffer when moving from {} to {} and de-activates Visual Mode
;; (require 'auto-indent-mode)
;; (setq auto-indent-on-visit-file t) ;; If you want auto-indent on for files
;; (auto-indent-global-mode) ;; Always auto-indent

;; setup info paths (for glibc manual, etc.)
;; this might be ignored if $INFOPATH is already set
(setq Info-default-directory-list
  (append '("~/.emacs.d/info")
    Info-default-directory-list))

;; Switch to the buffer-menu when opening it (buffer-menu instead of list-buffers)
(global-set-key "\C-x\C-b" 'buffer-menu) ;; don't use ibuffer - it doesn't respect viper-mode
(global-set-key (kbd "C-x b") 'ido-switch-buffer) ;; unecessary, ido does this
;; by default, this is C-x C-f, but prefer consistency with switching buffers over consistency
;; with other emacsen
(global-set-key (kbd "C-x f") 'ido-find-file)  

;; change yes/no prompts to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Shortcuts for highlight-symbol
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-prev)

;; shortcut for M-x without the alt key
;; don't do this. see alternatives in http://stackoverflow.com/questions/1792326/
;;(global-set-key "\C-m" 'execute-extended-command)
;; and also in evil
;; (define-key evil-normal-state-map "\C-m" 'execute-extended-command)
(global-set-key (kbd "C-x m") 'smex)
(global-set-key (kbd "C-x C-M") 'smex-major-mode-commands)
;;(global-set-key (kbd "C-x C-M") 'smex-major-mode-commands)

;; TODO: this doesn't belong here!
;; customize ack
;; (setq ack-prompt-for-directory 't) ;; I want the current file by default
