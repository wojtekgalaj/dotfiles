(setq doom-font (font-spec :family "Iosevka" :weight 'regular :size 16)
      doom-theme 'doom-gruvbox)

(setq  standard-indent 2)
(setq  typescript-indent-level 2)

;;(setq evil-move-cursor-back nil)

(setq display-line-numbers-type nil
      scroll-margin 8
      )

(after! org
  (setq org-startup-folded t
   org-modules '(ol-bibtex org-habit)
   org-agenda-files (file-expand-wildcards org-directory)
   )
)

(map! :leader
      :desc "Org Capture"           "x" #'org-capture
      :desc "Pop up scratch buffer" "X" #'doom/open-scratch-buffer)

(after! org
  (setq org-capture-templates
        '(("t" "Personal todo" entry
           (file+headline +org-capture-todo-file "Inbox")
           "* TODO %?\n%i\n%a" :prepend t)
          ("n" "Personal notes" entry
           (file+headline +org-capture-notes-file "Inbox")
           "* %u %?\n%i\n%a" :prepend t)
          ("j" "Journal" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %U %?\n%i\n%a" :prepend t)
          ("p" "Templates for projects")
          ("pt" "Project-local todo" entry
           (file+headline +org-capture-project-todo-file "Inbox")
           "* TODO %?\n%i\n%a" :prepend t)
          ("pn" "Project-local notes" entry
           (file+headline +org-capture-project-notes-file "Inbox")
           "* %U %?\n%i\n%a" :prepend t)
          ("pc" "Project-local changelog" entry
           (file+headline +org-capture-project-changelog-file "Unreleased")
           "* %U %?\n%i\n%a" :prepend t)
          ("o" "Centralized templates for projects")
          ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
          ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
          ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))))

(global-set-key (kbd "C-h") 'evil-window-left)
(global-set-key (kbd "C-j") 'evil-window-down)
(global-set-key (kbd "C-k") 'evil-window-up)
(global-set-key (kbd "C-l") 'evil-window-right)

(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(setq-default evil-cross-lines t)

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.postcss\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.webc\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'rjsx-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'scss-mode-hook 'prettier-js-mode)

(setq lsp-warn-no-matched-clients nil)

(require 'dap-node )

(map! :leader
      :desc "Now save everything" "j" #'evil-write-all)

(require 'js-doc)

(setq flycheck-check-syntax-automatically '(mode-enabled save))

(use-package! copilot
  :config
  (customize-set-variable 'copilot-enable-predicates '(evil-insert-state-p))
  (global-set-key (kbd "C-c c") 'copilot-accept-completion)
  )

(add-hook 'web-mode-hook 'copilot-mode)

(require 'prettier-js)
(add-hook 'prettier-js-mode-hook
          (lambda ()
            (setq prettier-js-command (concat (projectile-project-root) "node_modules/.bin/prettier"))))
