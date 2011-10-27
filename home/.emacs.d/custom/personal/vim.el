;; Vim emulation with Evil
;; Evil is the excellent merge of vim-mode and vimpulse
;; 
;; For more, see:
;; * Evil Experiences: http://permalink.gmane.org/gmane.emacs.vim-emulation/1170
;; * Shinobu's secrets: http://zuttobenkyou.wordpress.com/2011/02/15/some-thoughts-on-emacs-and-vim/ 
;; * Cofi's dotfiles: https://github.com/cofi/dotfiles/blob/master/emacs.d/cofi-evil.el
;;
;; TODO:
;; * evil-surround (see http://emacswiki.org/emacs/Evil)
;; * evil-numbers (see http://emacswiki.org/emacs/Evil)
;; * evil-leader (see https://github.com/cofi/evil-leader)

;; Evil settings
(require 'evil)
(evil-mode 1)
(setq evil-default-cursor t) ;; see http://blog.gmane.org/gmane.emacs.vim-emulation/month=20110801
(setq evil-cross-lines t)

;; require commands we want to bind
(require 'personal/ny-functions)

;; Make "jk" behave as ESC key
;; I used to use a snippet from http://zuttobenkyou.wordpress.com/2011/02/15/some-thoughts-on-emacs-and-vim/
;; This works better (from https://github.com/cofi/dotfiles/blob/masfill-paracs.d/cofi-evil.el)
(evil-define-command cofi/evil-maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p))
	 (entry-key ?j)
	 (exit-key ?k))
    (insert entry-key)
    (let ((evt (read-event (format "Insert %c to exit insert state" exit-key) nil 0.5)))
      (cond
	((null evt) (message ""))
	((and (integerp evt) (char-equal evt exit-key))
          (delete-char -1)
          (set-buffer-modified-p modified)
          (push 'escape unread-command-events))
	(t (push evt unread-command-events))))))

(define-key evil-insert-state-map "j" 'cofi/evil-maybe-exit)

;; evil remaps C-e to evil-scroll-line-down - undo that
(define-key evil-insert-state-map "\C-e" 'end-of-line)

;; simulate vim's "nnoremap <space> 10<c-e>10j"
(define-key evil-normal-state-map " " (lambda ()
					(interactive)
					(next-line 10)
					(evil-scroll-line-down 10)
					))

;; simulate vim's "nnoremap <backspace> 10<c-y>10k"
(define-key evil-normal-state-map (kbd "DEL") (lambda ()
						(interactive)
						(previous-line 10)
						(evil-scroll-line-up 10)
						))

;; TODO: Allow easily listing and searching leader shortcuts
(defun ny-evil-nvmap (key def)
  "Define a key in normal and visual mode"
  (define-key evil-normal-state-map key def)
  (define-key evil-visual-state-map key def))

;; TODO: Use http://www.emacswiki.org/emacs/IncrementalOccur 
(defun take-me-to-your-leader ()
  "Search for a leader shortcut defined in vim.el"
  (interactive)
  (let
    ((query (read-from-minibuffer "Name your leader:"))
      (buf (current-buffer)))
    (find-file "~/.emacs.d/custom/personal/vim.el")
    (occur query)
    (bury-buffer)
    (switch-to-buffer buf))) 

;; Evil leaders
;; manipulate files and buffers
;; you may prefer to use emac's own keyboard shortcuts
(define-key evil-normal-state-map ",ev" 'ny-edit-dot-emacs)		; edit .emacs
(define-key evil-normal-state-map ",er" 'ny-eval-region-dwim)		; evaluate lisp
(define-key evil-normal-state-map ",eb" 'ny-eval-buffer)		
(define-key evil-normal-state-map ",el" 'take-me-to-your-leader)	; evil leaders		
(define-key evil-normal-state-map ",f" 'ido-find-file)			; open file
(define-key evil-normal-state-map ",F" 'ido-find-file-other-window)	
(define-key evil-normal-state-map ",b" 'ido-switch-buffer) 		; switch buffers
(define-key evil-normal-state-map ",B" 'ido-switch-buffer-other-window) 
(define-key evil-normal-state-map ",k" 'kill-buffer)			; kill buffers
(define-key evil-normal-state-map ",K" 'ny-kill-other-buffer)
(define-key evil-normal-state-map ",w" 'save-buffer)			; save 
(define-key evil-normal-state-map ",W" 'ido-write-file) 		; save-as
(define-key evil-normal-state-map ",r" 'ny-revert-buffer-no-confirm)	; revert buffer
(define-key evil-normal-state-map ",R" 'recentf-open-files) 		; recent files

;; TODO: add mappings for back and forward in Info mode
;; * The bindings should match my chosen back/forward bindings in Pendactyl
;; * Does back/forward make sense in other modes too?

;; TODO: add bindings for org mode
;; see http://zuttobenkyou.wordpress.com/2011/02/15/some-thoughts-on-emacs-and-vim/
(define-key evil-normal-state-map ",P" (lambda () ; paste on a newline
					 (interactive)
					 (evil-open-below 1)
					 (evil-paste-after 1)
					 (evil-normal-state)))

;; splits
(define-key evil-normal-state-map ",v" 'ny-new-vsplit)
(define-key evil-normal-state-map ",s" 'ny-new-hsplit)
(define-key evil-normal-state-map ",0" 'delete-window)
(define-key evil-normal-state-map ",1" 'ny-maximize-spit)
(define-key evil-normal-state-map ",2" 'split-window-vertically)
(define-key evil-normal-state-map ",3" 'split-window-horizontally) 
(define-key evil-normal-state-map ",4" 'ny-4rectangle-split)
(define-key evil-normal-state-map ",-" 'ny-transpose-windows)

;; coding
(define-key evil-visual-state-map ",c" 'comment-dwim)		; comment code
(define-key evil-normal-state-map ",o" 'ff-find-other-file) 	; switch between .h and .c

;; indentation and text cleanup
(define-key evil-visual-state-map ",ir" 'indent-region)		; indentation
(define-key evil-normal-state-map ",ib" 'ny-indent-buffer)	
(define-key evil-normal-state-map ",ia" 'align-regexp)		; alignment
(define-key evil-visual-state-map ",ia" 'align-regexp)		 
(define-key evil-normal-state-map ",ix" 'ny-format-xml)		; indent xml
(define-key evil-normal-state-map ",it" 'delete-trailing-whitespace)

;; Insertions - inserting text into the buffer
;; TODO: use something from http://stackoverflow.com/questions/251908/
(define-key evil-normal-state-map ",It" 'ny-now)		
(define-key evil-normal-state-map ",Id" 'ny-today)		

;; h-elp and apropos
(ny-evil-nvmap ",hk" 'describe-key)
(ny-evil-nvmap ",hb" 'describe-bindings)
(ny-evil-nvmap ",hf" 'describe-function)
(ny-evil-nvmap ",hc" 'describe-command)
(ny-evil-nvmap ",hv" 'describe-variable)
(ny-evil-nvmap ",ha" 'apropos)

;; t-oggle modes 
(define-key evil-normal-state-map ",tF" 'ny-fullscreen)
(define-key evil-normal-state-map ",tf" 'ny-follow-mode-duplicate-buffer)
(define-key evil-normal-state-map ",ts" 'typing-speed-mode)
(define-key evil-normal-state-map ",tS" 'flyspell-mode)
(define-key evil-normal-state-map ",tt" 'display-time-mode)
(define-key evil-normal-state-map ",ta" 'auto-fill-mode)	; hard (linebreak) wrapping 
(define-key evil-normal-state-map ",tv" 'visual-line-mode)	; soft line wrapping
(define-key evil-normal-state-map ",t80" 'highlight-80+-mode)
(define-key evil-normal-state-map ",tc" 'highlight-changes-visible-mode)
(define-key evil-normal-state-map ",tl" 'hl-line-mode)
(define-key evil-normal-state-map ",tn" 'line-number-mode)
(define-key evil-normal-state-map ",tN" 'linum-mode)
(define-key evil-normal-state-map ",tm" 'ny-minimap-toggle)
(define-key evil-normal-state-map ",tp" 'pretty-mode)

;; Color Themes
(define-key evil-normal-state-map ",Tsd" 'color-theme-solarized-dark)
(define-key evil-normal-state-map ",Tsl" 'color-theme-solarized-light)
(define-key evil-normal-state-map ",TSd" 'color-theme-sanityinc-dark)
(define-key evil-normal-state-map ",TSl" 'color-theme-sanityinc-light)
(define-key evil-normal-state-map ",Tz" 'color-theme-zenburn)
(define-key evil-normal-state-map ",Tt" 'color-theme-tango)
(define-key evil-normal-state-map ",T2t" 'color-theme-tango-2)
(define-key evil-normal-state-map ",TT" 'color-theme-tty-dark)
(define-key evil-normal-state-map ",Tm" 'color-theme-matrix)
(define-key evil-normal-state-map ",Tam" 'color-theme-almost-monokai)
(define-key evil-normal-state-map ",Tir" 'color-theme-ir-black)

;; Ack
(define-key evil-normal-state-map ",A" 'ack) ;; this runs ack in the same directory as current file

;; El-get
(define-key evil-normal-state-map ",Eu" 'el-get-update-all)
(define-key evil-normal-state-map ",Ed" 'el-get-describe)
(define-key evil-normal-state-map ",Ei" 'el-get-install)
(define-key evil-normal-state-map ",El" 'el-get-list-packages)

;; Deft
(define-key evil-normal-state-map ",Ds" 'ny-switch-deft) ;; deft switch
(define-key evil-normal-state-map ",Dl" 'deft) ;; deft list

;; Lookup/reference in dictionary or thesaurus
(define-key evil-normal-state-map ",ls" 'synonyms)
(define-key evil-normal-state-map ",lt" 'synonyms) ;; thesarus (same as above)
(define-key evil-normal-state-map ",ld" 'dictionary-search)
(define-key evil-normal-state-map ",lw" 'lookup-wikipedia)

;; undo-tree
(define-key evil-normal-state-map ",uv" 'undo-tree-visualize)
(define-key evil-normal-state-map ",ur" 'undo-tree-redo)

;; m-ark region and symbols
(define-key evil-normal-state-map ",mr" 'ny-markerpen-mark-dwim) ;; TODO: use for marking and clearing
(define-key evil-normal-state-map ",mcr" 'ny-markerpen-clear-dwim)
(define-key evil-normal-state-map ",mca" 'markerpen-clear-all-marks)
(define-key evil-normal-state-map ",ms" 'highlight-symbol-at-point)
(define-key evil-normal-state-map ",mn" 'highlight-symbol-next)
(define-key evil-normal-state-map ",mp" 'highlight-symbol-prev)
(define-key evil-normal-state-map ",mu" 'hi-lock-unface-buffer) 
(define-key evil-normal-state-map ",mx" (lambda ()
					  (interactive)
					  (highlight-regexp ".*custom_search_term")))

(provide 'personal/vim)
