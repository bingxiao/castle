;; - TODO: check if the thesaurus is present and offer to download it
;; - TODO: Make synonyms.el show the default word under cursor in parens
;; - TODO: Make synonyms.el use ido like icicles
;; - TODO: Fix diction.el
;; - TODO: Compare dictionary.el with dict.el, dictem, and lookup (http://lookup.sourceforge.net/)
;; - TODO: Offline dictionaries - perhaps with the server http://www.ndl.kiev.ua/content/dictdpp
;; - See also: http://xahlee.org/emacs/dictionary_lookup.html
;; - See also: http://www.emacswiki.org/emacs/DictMode

(require 'synonyms)

;; mthesaur.txt is the Moby Thesaurus II
;; download it from http://www.gutenberg.org/dirs/etext02/mthes10.zip
(setq synonyms-file "~/.dicts/mthesaur.txt")
(setq synonyms-cache-file "/Users/natan/.dicts/mthesaur.txt.cachek")
;;(setq mthesaur-file "~/.dicts/mthesaur.txt")

;; from http://xahlee.org/emacs/emacs_lookup_ref.html
(defun lookup-wikipedia ()
  "Look up the word under cursor in Wikipedia.
If there is a text selection (a phrase), use that.

This command switches you to your browser."
 (interactive)
 (let (myword myurl)
   (setq myword
         (if (region-active-p)
             (buffer-substring-no-properties (region-beginning) (region-end))
           (thing-at-point 'symbol)))

  (setq myword (replace-regexp-in-string " " "_" myword))
  (setq myurl (concat "http://en.wikipedia.org/wiki/" myword))
  (browse-url myurl)
   ))

(provide 'personal/erudite)
