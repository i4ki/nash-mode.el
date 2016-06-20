;;; nash.el --- Nash major mode                      -*- lexical-binding: t; -*-

;; Copyright (C) 2016
;; Author: Tiago Natel de Moura  <tiago4orion@gmail.com>

;; Keywords: nash, languages
;; This package was created based on go-mode.

;;; Code:

(require 'go-mode)

(setq nash-keywords '("if" "else" "for" "import" "bindfn" "dump" "setenv" "fn") )
(setq nash-builtins '("len"))

(defconst nash-comment-regexp "#.*")
(defconst nash-identifier-regexp "[[:word:][:multibyte:]]+")
(defconst nash-variable-regexp (concat "$" nash-identifier-regexp))

(setq nash-keywords-regexp (regexp-opt nash-keywords 'words))
(setq nash-builtins-regexp (regexp-opt nash-builtins 'words))

(defgroup nash nil
  "Major mode for editing Nash code."
  :link '(url-link "https://github.com/tiago4orion/nash-mode.el")
  :group 'languages)

(defcustom nash-mode-hook nil
  "Hook called by `nash-mode'."
  :type 'hook
  :group 'nash)

(defcustom nashfmt-command "nashfmt"
  "The 'nashfmt' command."
  :type 'string
  :group 'nash)


(defcustom nashfmt-args nil
  "Additional arguments to pass to nashfmt."
  :type '(repeat string)
  :group 'nash)

(defcustom nashfmt-show-errors 'buffer
  "Where to display nashfmt error output.
It can either be displayed in its own buffer, in the echo area, or not at all.
Please note that Emacs outputs to the echo area when writing
files and will overwrite nashfmt's echo output if used from inside
a `before-save-hook'."
  :type '(choice
          (const :tag "Own buffer" buffer)
          (const :tag "Echo area" echo)
          (const :tag "None" nil))
  :group 'nash)

(defun nashfmt--kill-error-buffer (errbuf)
  (let ((win (get-buffer-window errbuf)))
    (if win
        (quit-window t win)
      (kill-buffer errbuf))))

(defun nashfmt ()
  "Format the current buffer according to the nashfmt tool."
  (interactive)

  (let ((tmpfile (make-temp-file "nashfmt" nil ".sh"))
        (patchbuf (get-buffer-create "*Nashfmt patch*"))
        (errbuf (if nashfmt-show-errors (get-buffer-create "*Nashfmt Errors*")))
        (coding-system-for-read 'utf-8)
        (coding-system-for-write 'utf-8)
        our-nashfmt-args)

    (unwind-protect
        (save-restriction
          (widen)
          (if errbuf
              (with-current-buffer errbuf
                (setq buffer-read-only nil)
                (erase-buffer)))
          (with-current-buffer patchbuf
            (erase-buffer))

          (write-region nil nil tmpfile)

          (setq our-nashfmt-args (append our-nashfmt-args
                                       nashfmt-args
                                       (list "-w" tmpfile)))
          (message "Calling nashfmt: %s %s" nashfmt-command our-nashfmt-args)
          ;; We're using errbuf for the mixed stdout and stderr output. This
          ;; is not an issue because nashfmt -w does not produce any stdout
          ;; output in case of success.
          (if (zerop (apply #'call-process nashfmt-command nil errbuf nil our-nashfmt-args))
              (progn
                (if (zerop (call-process-region (point-min) (point-max) "diff" nil patchbuf nil "-n" "-" tmpfile))
                    (message "Buffer is already nashfmted")
                  (go--apply-rcs-patch patchbuf)
                  (message "Applied nashfmt"))
                (if errbuf (nashfmt--kill-error-buffer errbuf)))
            (message "Could not apply nashfmt")
            (if errbuf (nashfmt--process-errors (buffer-file-name) tmpfile errbuf))))

      (kill-buffer patchbuf)
      (delete-file tmpfile)
      )))

(setq nash-font-lock-keywords
      `(
        (,nash-variable-regexp . font-lock-constant-face)
        (,nash-builtins-regexp . font-lock-function-name-face)
        (,nash-keywords-regexp . font-lock-keyword-face)
        (,nash-comment-regexp . font-lock-comment-face)
        ;; note: order above matters, because once colored, that part won't change.
        ;; in general, longer words first
        ))

;;;###autoload
(defun nashfmt-before-save ()
  "Add this to .emacs to run nashfmt on the current buffer when saving:
 (add-hook 'before-save-hook 'gofmt-before-save).
Note that this will cause go-mode to get loaded the first time
you save any file, kind of defeating the point of autoloading."

  (interactive)
  (when (eq major-mode 'nash-mode) (nashfmt)))

(define-derived-mode nash-mode fundamental-mode
  "nash mode"
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
