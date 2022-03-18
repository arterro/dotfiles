(setq org-todo-keywords
    (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
            (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

(setq-default org-enforce-todo-dependencies t)

(with-eval-after-load 'org-superstar
    (setq org-superstar-item-bullet-alist
        '((?* . ?•)
          (?+ . ?➤)
          (?- . ?•)))
    ;(setq org-superstar-headline-bullets-list '(?\s))
    (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))
    (setq org-superstar-special-todo-items t)
    (setq org-superstar-remove-leading-stars t)
    (org-superstar-restart))

(setq org-ellipsis " ▼ ")

(setq org-hide-emphasis-markers t)

(org-indent-mode -1)
(setq line-spacing 0.1
      org-pretty-entities t
      org-startup-indented t
      org-adapt-indentation nil)
;(variable-pitch-mode +1)
(mapc
    (lambda (face) ;; Other fonts that require it are set to fixed-pitch.
        (set-face-attribute face nil :inherit 'fixed-pitch))
    (list 'org-block
          'org-table
          'org-verbatim
          'org-block-begin-line
          'org-block-end-line
          'org-meta-line
          'org-date
          'org-drawer
          'org-property-value
          'org-special-keyword
          'org-document-info-keyword))
    (mapc ;; This sets the fonts to a smaller size
    (lambda (face)
        (set-face-attribute face nil :height 0.8))
    (list 'org-document-info-keyword
          'org-block-begin-line
          'org-block-end-line
          'org-meta-line
          'org-drawer
          'org-property-value
        ))

(set-face-attribute 'org-code nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-level-1 nil
                      :height 1.25) 
  (set-face-attribute 'org-level-2 nil
                      :height 1.15)
  (set-face-attribute 'org-level-3 nil
                      :height 1.1)
  (set-face-attribute 'org-level-4 nil
                      :height 1.05)
  (set-face-attribute 'org-level-5 nil)
  (set-face-attribute 'org-date nil
                      :height 0.8)
  (set-face-attribute 'org-document-title nil
                      :height 1.3)
  (set-face-attribute 'org-ellipsis nil
                      :underline nil)
  (set-face-attribute 'variable-pitch nil
                      :family "Roboto Slab" :height 1.2)
