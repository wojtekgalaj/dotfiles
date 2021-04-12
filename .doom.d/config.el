(setq doom-font (font-spec :family "Iosevka" :weight 'regular :size 16)
      doom-theme 'doom-sourcerer)

(setq  standard-indent 2)

(setq evil-move-cursor-back nil)

(setq display-line-numbers-type nil
      scroll-margin 8
      )

(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(setq-default evil-cross-lines t)

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(add-hook 'web-mode-hook 'prettier-js-mode (lsp))



(map! :leader
      :desc "Just save everything" "j" #'evil-write-all)

;; (unless (display-graphic-p)
;;     (require 'evil-terminal-cursor-changer)
;;     (evil-terminal-cursor-changer-activate)
;;   )

(after! org
  (setq org-startup-folded t
   org-modules '(ol-bibtex org-habit)
   org-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org"
   org-default-notes-file (concat org-directory "/notes.org")
   org-agenda-files (file-expand-wildcards org-directory)
   )
)

(global-set-key (kbd "C-h") 'evil-window-left)
(global-set-key (kbd "C-j") 'evil-window-down)
(global-set-key (kbd "C-k") 'evil-window-up)
(global-set-key (kbd "C-l") 'evil-window-right)
