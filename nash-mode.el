;;; nash.el --- Nash major mode                      -*- lexical-binding: t; -*-

;; Copyright (C) 2016

;; Author: Tiago Natel de Moura  <tiago4orion@gmail.com>

;; Keywords: nash, languages

;;; Code:

(defvar nash-mode-hook nil)

(setq nash-keywords '("if" "else" "for" "import" "bindfn" "dump" "setenv" "fn") )
;;(setq nash-types '("float" "integer" "key" "list" "rotation" "string" "vector"))
(setq nash-constants "\\$[a-zA-Z_]+[a-zA-Z_0-9]*")
(setq nash-functions '("len"))

(setq nash-comment-regexp "#.*")
(setq nash-keywords-regexp (regexp-opt nash-keywords 'words))
(setq nash-constant-regexp nash-constants)
(setq nash-functions-regexp (regexp-opt nash-functions 'words))

(setq nash-font-lock-keywords
      `(
        (,nash-constant-regexp . font-lock-constant-face)
        (,nash-functions-regexp . font-lock-function-name-face)
        (,nash-keywords-regexp . font-lock-keyword-face)
        (,nash-comment-regexp . font-lock-comment-face)
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

(provide 'nash-mode)

;; Local Variables:
;; coding: utf-8
;; End:

;;; nash-mode.el ends here
