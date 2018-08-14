
(define-globalized-minor-mode peng-global-highlight-symbol-mode highlight-symbol-mode
  (lambda () (highlight-symbol-mode 1)))

(peng-global-highlight-symbol-mode 1)

(defun remove-highlight-symbol-mode ()
  (peng-global-highlight-symbol-mode -1))

(add-hook 'magit-mode-hook 'remove-highlight-symbol-mode)

(provide 'init-highlight-symbol)
