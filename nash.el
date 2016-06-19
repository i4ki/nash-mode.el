;;; nash.el --- Nash major mode                      -*- lexical-binding: t; -*-

;; Copyright (C) 2016

;; Author:  <i4k@johncarter.starwars>

;; Keywords: nash, languages

;;; Code:

;; define several category of keywords
(setq nash-keywords '("if" "else" "for" "import" "bindfn" "dump" "setenv" "fn") )
;;(setq nash-types '("float" "integer" "key" "list" "rotation" "string" "vector"))
(setq nash-constants '("$HOME" "$NASHPATH" "$IFS" "$PATH"))
(setq nash-functions '("len"))

;; generate regex string for each category of keywords
(setq nash-keywords-regexp (regexp-opt nash-keywords 'words))
;(setq nash-type-regexp (regexp-opt nash-types 'words))
(setq nash-constant-regexp (regexp-opt nash-constants 'words))
;(setq nash-event-regexp (regexp-opt nash-events 'words))
(setq nash-functions-regexp (regexp-opt nash-functions 'words))

;; create the list for font-lock.
;; each category of keyword is given a particular face
(setq nash-font-lock-keywords
      `(
;;        (,nash-type-regexp . font-lock-type-face)
        (,nash-constant-regexp . font-lock-constant-face)
;;        (,nash-event-regexp . font-lock-builtin-face)
        (,nash-functions-regexp . font-lock-function-name-face)
        (,nash-keywords-regexp . font-lock-keyword-face)
        ;; note: order above matters, because once colored, that part won't change.
        ;; in general, longer words first
        ))

;;;###autoload
(define-derived-mode nash-mode fundamental-mode
  "lsl mode"
  "Major mode for editing Nash (github.com/NeowayLabs/nash)"
  (setq-local comment-start "# ")
  (setq-local comment-end "")

  ;; code for syntax highlighting
  (setq font-lock-defaults '((nash-font-lock-keywords))))

;; clear memory. no longer needed
(setq nash-keywords nil)
(setq nash-types nil)
(setq nash-constants nil)
(setq nash-events nil)
(setq nash-functions nil)

;; clear memory. no longer needed
(setq nash-keywords-regexp nil)
(setq nash-types-regexp nil)
(setq nash-constants-regexp nil)
(setq nash-events-regexp nil)
(setq nash-functions-regexp nil)

;; add the mode to the `features' list
(provide 'nash-mode)

;; Local Variables:
;; coding: utf-8
;; End:

;;; nash-mode.el ends here
