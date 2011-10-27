;; hack from http://stackoverflow.com/questions/6042070/how-to-use-vimpulse-together-with-autopair-el
;; makes autopair work better with viper
(defun not-escaped (escape-char)

  "Character immediately before cursor is not prefixed by escape-char"
  (let ((count 0))
    (save-excursion
      (if (char-before)
          (backward-char))
      (while (and (char-before)
                  (= (char-before) escape-char))
        (setq count (+ count 1))
        (backward-char))
      (if (= 0
             (% count 2))
          t
        nil))))

(defun in-matched-empty-pair (pair-list)
  "tell if cursor is in an empty pair in pair-list"
  (let ((next-char (char-after))
        (prev-char (char-before))
        (matched nil)
        (pair)
        (pair-left)
        (pair-right))
    (if (and next-char
             prev-char)
          (while (and (setq pair
                       (pop pair-list))
                      (not matched))
            (setq pair-left (pop pair)
                  pair-right (pop pair))
            (if (= next-char pair-right)
                (if (and
                     (= prev-char pair-left)
                     (not-escaped ?\\))
                    (setq matched t)))))
    (if matched
        t
      nil)))

(defvar viper-workaround-pairs
      '(
        (?\" ?\")
        (?\' ?\')
        (?\` ?\`)
        (?\( ?\))
        (?\[ ?\])
        (?\{ ?\})
        ))

;; Workaround for integration problem with autopair
(defadvice viper-del-backward-char-in-insert (before viper-auto-delete-pair-backward())
  (if (in-matched-empty-pair viper-workaround-pairs)
      (delete-char 1)))

;; Activate advice
(ad-activate 'viper-del-backward-char-in-insert)

(provide 'personal/viper-autopair-hack)
