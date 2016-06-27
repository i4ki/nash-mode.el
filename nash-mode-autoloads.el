;;; nash-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "nash-mode" "nash-mode.el" (22385 14089 563360
;;;;;;  622000))
;;; Generated autoloads from nash-mode.el

(autoload 'nash-fmt-before-save "nash-mode" "\
Add this to .emacs to run nashfmt on the current buffer when saving:
  (add-hook 'nash-mode-hook 'nash-fmt-enable-on-save)

  where nash-fmt-enable-on-save would be a function which calls

 (add-hook 'before-save-hook 'nash-fmt-before-save)

\(fn)" t nil)

(autoload 'nash-mode "nash-mode" "\
Major mode for editing Nash (github.com/NeowayLabs/nash)

\(fn)" t nil)

;;;***

(provide 'nash-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; nash-mode-autoloads.el ends here
