(require 'multi-term)
;; Close yasnippet in term-mode aim to use tab complete
(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))
(setq multi-term-program "/bin/bash")

(setq multi-term-switch-after-close nil)

(setq multi-term-dedicated-select-after-open-p t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-symbol-face ((t (:background "lime green"))))
 '(term-color-blue ((t (:background "black" :foreground "yellow"))))
 '(term-color-green ((t (:background "black" :foreground "#A6E22E")))))

(provide 'init-multi-term)
