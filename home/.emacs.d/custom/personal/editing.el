;; General settings for text editing

;; Don't truncate lines 
(setq-default truncate-lines t) ; Must be enabled anew when entering c-mode

;; Use UTF-8 by default
(prefer-coding-system 'utf-8)

;; Always track changes to files, but don't highlight them
(global-highlight-changes-mode t)
(setq highlight-changes-visibility-initial-state nil); initially hide

(provide 'personal/editing)
