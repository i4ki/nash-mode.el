[![MELPA](http://melpa.org/packages/nash-mode-badge.svg)](http://melpa.org/#/nash-mode)

# nash-mode

This package provides an Emacs major mode for
[Nash Shell](https://github.com/NeowayLabs/nash). You can install using [Melpa](http://melpa.org/#/nash-mode) or
cloning this repository directly.

It provides simple fontification and integration with nashfmt.

There are several ways to use `nash-mode` and the code below are just examples.

```elisp
;;; Add nash-mode cloned source code to load-path
(add-to-list 'load-path "<path-to-nash-mode.el>")

(require 'nash-mode)

;; to use nash-mode for sh scripts (instead of sh-mode)
(add-to-list 'auto-mode-alist '("\\.sh\\'" . nash-mode))
(add-hook 'nash-mode-hook 'nash-fmt-enable-on-save)
```

If you prefer through [use-package](https://github.com/jwiegley/use-package).

```elisp
(use-package nash-mode
  :ensure t
  :config
  ;; to use nash-mode for sh scripts (instead of sh-mode)
  (add-to-list 'auto-mode-alist (cons "\\.sh\\'" 'nash-mode))
  (add-hook 'nash-mode-hook #'nash-fmt-enable-on-save))
```
