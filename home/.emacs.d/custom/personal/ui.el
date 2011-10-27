;; Functions
; Go fullscreen on Mac OS X
(defun ny-fullscreen ()
  (interactive)
  ;; inside Cocoa windows
  (when (string= (framep-on-display) "ns")
    (ns-toggle-fullscreen)))

;; Hide crap in Emacs' user interface
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Stop those bloody beeps!
;;(setq ring-bell-function (lambda () (message "beep")))
;; Okay, only beep when it matters
(setq ring-bell-function 
  (lambda ()
    (unless (memq this-command
	      '(isearch-abort abort-recursive-edit 
		 exit-minibuffer
		 keyboard-quit))
      (ding))))

;; Go fullscreen
(ny-fullscreen)

;; Choose color theme
(require 'color-theme)
(require 'color-theme-solarized)
(require 'color-theme-almost-monokai)
(require 'color-theme-tango-2)
(require 'color-theme-ir-black)
(require 'color-theme-sanityinc)
(color-theme-solarized-dark)
;;(color-theme-solarized-light)
;;(color-theme-tango)
;;(color-theme-charcoal-black)
;;(color-theme-zenburn)

;; Font (on Windows)
;;(set-face-attribute `default nil :font "Consolas-10")

;; Underline/highlight the current line
;; See the keyboard shortcut in vim.el for toggling this
(hl-line-mode)

;; Make scrolling less annoying
;; from http://stackoverflow.com/questions/3631220/fix-to-get-smooth-scrolling-in-emacs
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)
(require 'smooth-scrolling) 	;; Not sure if this does anything

(provide 'personal/ui)
