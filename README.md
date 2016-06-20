# nash-mode

This package provides an Emacs major mode for
[Nash Shell](https://github.com/NeowayLabs/nash).

It provides simple fontification and integration with nashfmt.

There's several ways to use a major mode and the code below is only an example:

```elisp
;;; Add nash-mode cloned source code to load-path
(add-to-list 'load-path "<path-to-nash-mode.el>")

(require 'nash-mode)

;; to use nash-mode for sh scripts (instead of sh-mode)
(add-to-list 'auto-mode-alist (cons "\\.sh" 'nash-mode))

(defun my-nash-mode-hook ()
  ;; If you want to format your scripts accordinly to nashfmt
  (setq nashfmt-command "nashfmt")

  ;;; Call Nashfmt before saving
  (add-hook 'before-save-hook 'nashfmt-before-save))
  
(add-hook 'nash-mode-hook 'my-nash-mode-hook)
```


