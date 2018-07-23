(global-set-key (kbd "<f2>") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "<f3>") 'multi-term)
(global-set-key (kbd "<f4>") 'counsel-git)
(global-set-key (kbd "M-n") 'highlight-symbol-next) 
(global-set-key (kbd "M-p") 'highlight-symbol-prev) 
(global-set-key (kbd "M-/") 'undo-tree-visualize)
(global-set-key (kbd "M-w") 'xah-copy-line-or-region)
(global-set-key (kbd "C-x o") 'window-number-switch)

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)



(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)



(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(global-set-key (kbd "s-/") 'hippie-expand)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(provide 'init-keybindings)
