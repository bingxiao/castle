;; Setup a proxy when working out of Check Point's TLV office
;;
;; Actual computer names and proxies were removed from this file

(defun ny-checkpoint ()
  "Are we running on my Check Point desktop?"
  (string= (getenv "COMPUTERNAME") "COMPUTER NAME GOES HERE"))

(when (ny-checkpoint)
    (setq url-proxy-services '(("http" . "http://proxy/goes/here"))))

(provide 'personal/checkpoint)
