(setq frame-title-format "emacs")

;;;************************************************************
;;; Begin install plugin **************************************
;;;************************************************************
;;  ___ _   _   _  ___ ___ _  _
;; | _ \ | | | | |/ __|_ _| \| |
;; |  _/ |_| |_| | (_ || || .` |
;; |_| |____\___/ \___|___|_|\_|

;;; add repositories to be able to install packages

(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-enable-at-startup nil)
  (setq package-archives '())
  (package-initialize)
  ;; (add-to-list 'package-archives
  ;; 	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
  	       '("gnu" . "http://elpa.gnu.org/packages/"))  
  (add-to-list 'package-archives
	       '("marmalade" . "https://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
	       '("org" . "http://orgmode.org/elpa/") t)
  (add-to-list 'package-archives
	       '("tromey" . "http://tromey.com/elpa/") t)
  (add-to-list 'package-archives
  	       '("melpa-stable" . "http://melpa.org/packages/") t)
  )


;; On-demand installation of packages
(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

;;;************************************************************
;;; Simple setting
;;;************************************************************
(global-set-key (kbd "C-x C-b") 'ibuffer) 

(menu-bar-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(desktop-save-mode t)
(setq auto-save-default t)

;;; display a horizontal bar cursor 
(set-default 'cursor-type 'hollow)
;;; C-x C-f hint
(ido-mode)
;;; show column number
(column-number-mode)
(line-number-mode)
(global-linum-mode)
;;; highlight matching parenthesis
(show-paren-mode)
;;; highlight current line
(global-hl-line-mode 1)
;;; winner-undo/redo
(winner-mode t)
;;; Keybindings are of the form MODIFIER-{left,right,up,down}.
;;; Default MODIFIER is 'shift.
(windmove-default-keybindings)
;;;************************************************************
;;; Simple setting(end)
;;;************************************************************

;;;************************************************************
;; self defined funcs
;;;************************************************************

;;;************************************************************
;;; Hightlight *.cu file 
(setq auto-mode-alist (append
                  '(("\\.cu$" . c++-mode))
                    auto-mode-alist))
;;;************************************************************

;;;************************************************************
;; Use C-tab to autocomplete the files and directories
;; based on the two commands `comint-dynamic-complete-filename`
;; and `comint-dynamic-list-filename-completions`
;(add-hook 'prog-mode-hook 'comint-mode)
(autoload 'comint-dynamic-complete-filename "comint" nil t)
(defun atfd ()
(interactive)
(comint-dynamic-list-filename-completions)
(comint-dynamic-complete-as-filename))
(global-set-key (kbd "M-]") 'atfd)
(global-set-key (kbd "C-c k") 'atfd)
;(global-set-key (kbd "M-[") 'comint-dynamic-complete-filename)
;;;************************************************************
;;; Open yas-minor-mode when open an .py file
;; (add-hook 'python-mode (lambda ()
;; 			 (yas-minor-mode t)))
;;;************************************************************

;;;************************************************************
;;; Copy current line without selection
(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When called repeatedly, append copy subsequent lines.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').
URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2016-06-18"
  (interactive)
  (let (-p1 -p2)
    (if current-prefix-arg
        (setq -p1 (point-min) -p2 (point-max))
      (if (use-region-p)
          (setq -p1 (region-beginning) -p2 (region-end))
        (setq -p1 (line-beginning-position) -p2 (line-end-position))))
    (if (eq last-command this-command)
        (progn
          (progn ; hack. exit if there's no more next line
            (end-of-line)
            (forward-char)
            (backward-char))
          ;; (push-mark (point) "NOMSG" "ACTIVATE")
          (kill-append "\n" nil)
          (kill-append (buffer-substring-no-properties (line-beginning-position) (line-end-position)) nil)
          (message "Line copy appended"))
      (progn
        (kill-ring-save -p1 -p2)
        (if current-prefix-arg
            (message "Buffer text copied")
          (message "Text copied"))))
    (end-of-line)
    (forward-char)
    ))
(global-set-key (kbd "M-w") 'xah-copy-line-or-region)
;;;------------------------------------------------------------

;;;------------------------------------------------------------
(require 'dired)
;; (define-key dired-mode-map
;;   (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map
  (kbd "^") ( lambda ()
  (interactive) (find-alternate-file "..")))
;;;------------------------------------------------------------



;;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;  __  __  ___  _  _  ___  _  __   _   ___
;; |  \/  |/ _ \| \| |/ _ \| |/ /  /_\ |_ _|
;; | |\/| | (_) | .` | (_) | ' <  / _ \ | |
;; |_|  |_|\___/|_|\_|\___/|_|\_\/_/ \_\___|

(require-package 'monokai-theme)
(load-theme 'monokai t)
;;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;  ___ __  __ _____  __
;; / __|  \/  | __\ \/ /
;; \__ \ |\/| | _| >  <
;; |___/_|  |_|___/_/\_\

;;; M-x complete
(require-package 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;  ___ ___   ___   __   _____ ___ _____ ___ ___   _   _
;; |_ _|   \ / _ \  \ \ / / __| _ \_   _|_ _/ __| /_\ | |
;;  | || |) | (_) |  \ V /| _||   / | |  | | (__ / _ \| |__
;; |___|___/ \___/    \_/ |___|_|_\ |_| |___\___/_/ \_\____|

;;; vertical show the ido candidate
(require-package 'ido-vertical-mode)
(ido-vertical-mode)
;;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;    _  _   _ _____ ___  ___  _   ___ ___
;;   /_\| | | |_   _/ _ \| _ \/_\ |_ _| _ \
;;  / _ \ |_| | | || (_) |  _/ _ \ | ||   /
;; /_/ \_\___/  |_| \___/|_|/_/ \_\___|_|_\

;; (require-package 'autopair)
;; (autopair-global-mode)

;;;------------------------------------------------------------
;;  __  __ _   _ _  _____ ___   _____ ___ ___ __  __
;; |  \/  | | | | ||_   _|_ _| |_   _| __| _ \  \/  |
;; | |\/| | |_| | |__| |  | |    | | | _||   / |\/| |
;; |_|  |_|\___/|____|_| |___|   |_| |___|_|_\_|  |_|

(require-package 'multi-term)
;; Close yasnippet in term-mode aim to use tab complete
(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))
(setq multi-term-program "/bin/bash")
(global-set-key (kbd "<f3>") 'multi-term)
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
;;;------------------------------------------------------------
;;;------------------------------------------------------------
;;  _   _ _  _ ___   ___    _____ ___ ___ ___
;; | | | | \| |   \ / _ \  |_   _| _ \ __| __|
;; | |_| | .` | |) | (_) |   | | |   / _|| _|
;;  \___/|_|\_|___/ \___/    |_| |_|_\___|___|

(require-package 'undo-tree)
(global-undo-tree-mode)
(global-set-key (kbd "M-/") 'undo-tree-visualize)
;;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;    _   _    ___ _  _   _
;;   /_\ | |  | _ \ || | /_\
;;  / _ \| |__|  _/ __ |/ _ \
;; /_/ \_\____|_| |_||_/_/ \_\

(require-package 'alpha)
(require 'alpha)
(global-set-key (kbd "C-M-)") 'transparency-increase)
(global-set-key (kbd "C-M-(") 'transparency-decrease)
;;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;  __  __ _   _ _  _____ ___    ___ _   _ ___  ___  ___  ___
;; |  \/  | | | | ||_   _|_ _|  / __| | | | _ \/ __|/ _ \| _ \
;; | |\/| | |_| | |__| |  | |  | (__| |_| |   /\__ \ (_) |   /
;; |_|  |_|\___/|____|_| |___|  \___|\___/|_|_\|___/\___/|_|_\

(require-package 'multiple-cursors)
(global-set-key (kbd "C-M-}") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-{") 'mc/mark-previous-like-this)
;;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; __   ___   ___ _  _ ___ ___ ___ ___ _____
;; \ \ / /_\ / __| \| |_ _| _ \ _ \ __|_   _|
;;  \ V / _ \\__ \ .` || ||  _/  _/ _|  | |
;;   |_/_/ \_\___/_|\_|___|_| |_| |___| |_|

(require-package 'yasnippet)
(yas-global-mode t)
(add-hook 'prog-mode-hook 'yas-minor-mode)
;;;------------------------------------------------------------
;;  ___ ___ _  _ ___    ___ ___ _    ___
;; | __|_ _| \| |   \  | __|_ _| |  | __|
;; | _| | || .` | |) | | _| | || |__| _|
;; |_| |___|_|\_|___/  |_| |___|____|___|

;; (require-package 'helm)
(require-package 'find-file-in-project)
(global-set-key (kbd "<f4>") 'find-file-in-project)
;; Usage,
;; - `M-x find-file-in-project-by-selected' use the selected region
;; as the keyword to search file.  Or you need provide the keyword
;; if no region selected.
;; - `M-x find-directory-in-project-by-selected' use the select region
;; to find directory.  Or you need provide the keyword if no region
;; selected.
;; - `M-x find-file-in-project' will start search file immediately
;; - `M-x ffip-create-project-file' create .dir-locals.el
;;;------------------------------------------------------------
;;  _  ___   _____  ___    _
;; | || \ \ / /   \| _ \  /_\
;; | __ |\ V /| |) |   / / _ \
;; |_||_| |_| |___/|_|_\/_/ \_\

(require-package 'hydra)
(defhydra hydra-zoom (global-map "<f2>")
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))
;;;------------------------------------------------------------
;;    ___   ____   __
;;   /_\ \ / /\ \ / /
;;  / _ \ V /  \ V /
;; /_/ \_\_/    |_|

(require-package 'avy)
(global-set-key (kbd "C->") 'avy-goto-word-or-subword-1)
;;;------------------------------------------------------------
;;  ___ ___ _   _ ___ ___ ___ ___  __   _____
;; |_ _| _ ) | | | __| __| __| _ \ \ \ / / __|
;;  | || _ \ |_| | _|| _|| _||   /  \ V / (__
;; |___|___/\___/|_| |_| |___|_|_\   \_/ \___|
; group buffers in ibuffer list by VC project
(require-package 'ibuffer-vc)
(add-hook 'ibuffer-hook
	  (lambda ()
	    (ibuffer-vc-set-filter-groups-by-vc-root)
	    (unless (eq ibuffer-sorting-mode 'alphabetic)
	      (ibuffer-do-sort-by-alphabetic))))
;;;------------------------------------------------------------
(require-package 'flx-ido)
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
;;;------------------------------------------------------------
;;  _  _ _      _____   ____  __ ___  ___  _
;; | || | |    / __\ \ / /  \/  | _ )/ _ \| |
;; | __ | |__  \__ \\ V /| |\/| | _ \ (_) | |__
;; |_||_|____| |___/ |_| |_|  |_|___/\___/|____|
(require-package 'highlight-symbol)
(require 'highlight-symbol)
;; (highlight-symbol-mode t)
;; (highlight-symbol-nav-mode t)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)
(global-set-key (kbd "M-n") 'highlight-symbol-next) 
(global-set-key (kbd "M-p") 'highlight-symbol-prev) 
;(add-hook 'prog-mode-hook 'highlight-symbol-nav-mode)
;;;------------------------------------------------------------
;;;------------------------------------------------------------
;;  _  _ _      ___ _  _ ___  ___ _  _ _____
;; | || | |    |_ _| \| |   \| __| \| |_   _|
;; | __ | |__   | || .` | |) | _|| .` | | |
;; |_||_|____| |___|_|\_|___/|___|_|\_| |_|
;; (require-package 'highlight-indent-guides)
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (setq highlight-indent-guides-method 'character)
;;;------------------------------------------------------------
;; autopair mode
;;; auto pair 
;(electric-pair-mode t)
(require-package 'autopair)
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers
;;;************************************************************
(require-package 'auto-complete)
(global-auto-complete-mode t)
;;;************************************************************
;;; End install plugin **************************************
;;;************************************************************


(provide 'init)
