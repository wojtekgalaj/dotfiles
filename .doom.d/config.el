(after! org
)

(setq user-full-name "Wojtek Galaj"
      user-mail-address "wojtek.galaj@gmail.com"
      evil-move-cursor-back nil
      doom-font (font-spec :family "Fira Code" :size 14)
      doom-theme 'doom-dark+
      display-line-numbers-type nil
      flycheck-check-syntax-automatically '(mode-enabled-save)
      global-auto-composition-mode nil
      org-directory "~/Library/Mobile Documents/iCloud-com-appsonthemove~beorg/Documents/org/"
      projectile-require-project-root 'nil
      projectile-indexing-method 'hybrid
      standard-indent 2
      js-indent 2
      )
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

(unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer)
    (evil-terminal-cursor-changer-activate)
  )

(global-auto-revert-mode t)

(global-set-key (kbd "C-h") 'evil-window-left)
(global-set-key (kbd "C-j") 'evil-window-down)
(global-set-key (kbd "C-k") 'evil-window-up)
(global-set-key (kbd "C-l") 'evil-window-right)

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
