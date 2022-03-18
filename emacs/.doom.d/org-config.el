;; Remove TODO keywords from org-mode (it will still work in agenda)
(set-ligatures! 'org-mode
    :alist '(("TODO " . "")
             ("NEXT " . "")
             ("PROG " . "")
             ("WAIT " . "")
             ("DONE " . "")
             ("FAIL " . "")))

;; Ellipsis configuration
(setq org-ellipsis " ▼")

;; Hide signs like "~" or "_" or "*"
(setq org-hide-emphasis-markers t)

;; Make frame a bit larger than default sat startup
(setq initial-frame-alist '((top . 1) (left . 1) (width . 143) (height . 55)))

;; Initial setup for org-mode
(defun arterro/org-mode-setup ()
    (setq org-startup-indented t
          org-pretty-entities t
          org-hide-emphasis-markers t
          org-indent-indentation-per-level 0
          org-adapt-indentation nil
          org-hide-leading-stars nil
          org-indent-mode-turns-on-hiding-stars nil
          org-cycle-separator-lines 1)
        (customize-set-variable 'org-blank-before-new-entry 
                        '((heading . nil)
                          (plain-list-item . nil)))
        (electric-indent-mode -1)
        (arterro/visual-fill))

;; Centers document and sets page to a fixed width
(defun arterro/visual-fill ()
    (setq visual-fill-column-width 110
        visual-fill-column-center-text t
        visual-fill-column-center-text t)
        (visual-fill-column-mode 1))

(add-hook 'org-mode-hook 'arterro/org-mode-setup)

(after! org-faces
   (set-face-attribute 'org-document-title nil :font "Iosevka SS08" :weight 'bold :height 1.3)

   (dolist (face '((org-level-1 . 1.5)
                       (org-level-2 . 1.4)
                       (org-level-3 . 1.3)
                       (org-level-4 . 1.2)
                       (org-level-5 . 1.1)
                       (org-level-6 . 1.1)
                       (org-level-7 . 1.1)
                       (org-level-8 . 1.1)))
         (set-face-attribute (car face) nil :font "Iosevka SS08" :weight 'medium :height (cdr face))))

(after! org-superstar
    ;; Remove stars from headings and customize header bullets
    (set-face-attribute 'org-superstar-header-bullet nil :inherit 'fixed-pitched :height 180)
    (setq org-superstar-leading-bullet "")
    (setq org-superstar-remove-leading-stars t)
    ;(setq org-superstar-headline-bullets-list '("\u2001"))
    ;;(setq org-superstar-headline-bullets-list '("\u200b"))
    (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))
    
    ;; Enable custom bullets for TODO items
    (setq org-superstar-special-todo-items t)
    (setq org-superstar-todo-bullet-alist
        '(("TODO" "☐　")
          ("NEXT" "✒　")
          ("PROG" "✰　")
          ("WAIT" "☕　")
          ("FAIL" "✘　")
          ("DONE" "✔　")))
(org-superstar-restart)
(org-mode-restart))
