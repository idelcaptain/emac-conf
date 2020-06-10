
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (undo-tree rjsx-mode tide ace-window emmet-mode prettier-js add-node-modules-path flycheck web-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
;;(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) ;; auto-enable for .js/.jsx files
(add-to-list 'auto-mode-alist '("\\.[t|j]sx?$" . rjsx-mode)) ;; auto-enable for .js/.jsx/.ts/.tsx files
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
(defun web-mode-init-hook ()
  "Hooks for Web mode.  Adjust indent."
  (setq web-mode-markup-indent-offset 4))

;;(add-to-list 'auto-mode-alist '("\\.[t|j]sx?$" . prettier-js-mode)) ;; auto-enable for .js/.jsx/.ts/.tsx files
;;(add-hook 'rjsx-mode 'prettier-js-mode)
(add-hook 'rjsx-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook  'web-mode-init-hook)

;;(add-hook 'rjsx-mode-hook #'(lambda ()
;;                            (enable-minor-mode
;;                             '("\\.[t|j]sx?\\'" . prettier-js-mode))))
;;
(require 'flycheck)
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint json-jsonlist)))
;; Enable eslint checker for web-mode
(flycheck-add-mode 'javascript-eslint 'web-mode)
;; Enable flycheck globally
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'flycheck-mode-hook 'add-node-modules-path)
(defun web-mode-init-prettier-hook ()
  (add-node-modules-path)
  (prettier-js-mode))

(add-hook 'web-mode-hook  'web-mode-init-prettier-hook)
(add-hook 'web-mode-hook  'emmet-mode)

;;neo-tree config
(add-to-list 'load-path "/Users/ide/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-window-fixed-size nil)
(setq neo-smart-open t)

;;quick switch windows
'(package-selected-packages '(ace-window))
(global-set-key (kbd "M-o") 'ace-window)

;;global on linenumber
(when (version<="26.0.50" emacs-version)
  (global-display-line-numbers-mode))


;; move line up or down
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;;(global-set-key [(meta shift up)]  'move-line-up)
;;(global-set-key [(meta shift down)]  'move-line-down)
(global-set-key (kbd "M-p")  'move-line-up)
(global-set-key (kbd "M-n")  'move-line-down)


;;(setq neo-autorefresh)
(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("*\\.tsx\\'" . typescript-mode))

(require 'rjsx-mode)
(add-to-list 'auto-mode-alist '("*\\.jsx\\'" . rjsx-mode))

;;enable undo-tree global
(global-undo-tree-mode)

(require 'ido)
(ido-mode t)
