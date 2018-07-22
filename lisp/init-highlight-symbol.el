
(define-globalized-minor-mode peng-global-highlight-symbol-mode highlight-symbol-mode
  (lambda () (highlight-symbol-mode 1)))

(peng-global-highlight-symbol-mode 1)

(provide 'init-highlight-symbol)
