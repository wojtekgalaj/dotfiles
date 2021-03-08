(after! org
  (setq org-startup-folded t)
  (setq org-modules '(ol-bibtex org-habit))
  (setq org-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-agenda-files (file-expand-wildcards org-directory)
))

(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode (lsp))
(add-hook 'svelte-mode-hook 'prettier-js-mode (lsp))

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
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . svelte-mode))

(after! lsp-mode
  (setq lsp-file-watch-treshold nil
      lsp-enable-file-watchers nil
      )
)

(setq user-full-name "Wojtek Galaj"
      user-mail-address "wojtek.galaj@gmail.com"
      evil-move-cursor-back nil
      doom-font (font-spec :family "Iosevka" :weight 'regular :size 16)
      doom-theme 'doom-sourcerer
      display-line-numbers-type nil
      flycheck-check-syntax-automatically '(mode-enabled-save)
      global-auto-composition-mode nil
      projectile-require-project-root 'nil
      projectile-indexing-method 'hybrid
      standard-indent 2
      js-indent 2
      js-indent-level 2
      typescript-indent-level 2
      helm-mode-fuzzy-match t
      )
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(setq-default evil-cross-lines t)
