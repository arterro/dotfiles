;; Org Configuration
;; Majority of settings borrowed from https://github.com/hugcis/dotfiles

;; ****************
;; ORG-MODE
;; ****************

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
    (setq org-superstar-todo-bullet-alist
        '(("TODO" . ?☐)
          ("NEXT" . ?✒)
          ("HOLD" . ?✰)
          ("WAITING" . ?☕)
          ("CANCELLED" . ?✘)
          ("DONE" . ?✔)))
    (org-superstar-restart))

(setq org-ellipsis " ▼ ")

(setq org-hide-emphasis-markers t)

(defun arterro/buffer-face-mode-variable ()
  "Set font to a variable width (proportional) fonts in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "Iosevka SS08"
                                :height 150
                                :width normal))
  (buffer-face-mode))

;; Centers document and sets document body to a fixed width
(defun arterro/set-visual-fill ()
    (setq visual-fill-column-width 110
          visual-fill-column-center-text t
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))

(defun arterro/set-general-faces-org ()
    (org-superstar-mode t)
    (org-indent-mode -1)
    (company-mode -1)
    (setq line-spacing 0.1
          org-pretty-entities t
          org-startup-indented t
          org-adapt-indentation nil)
    (variable-pitch-mode t)
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
              'org-property-value)))

(defun arterro/set-specific-faces-org ()
    (set-face-attribute 'org-code nil
                        :inherit '(shadow fixed-pitch)) 
    (set-face-attribute 'org-date nil
                        :height 0.8)
    (set-face-attribute 'org-document-title nil
                        :height 0.9)
    (set-face-attribute 'org-ellipsis nil
                        :underline nil)
    (set-face-attribute 'variable-pitch nil
                        :family "Iosevka SS08" :height 1.03)
   
    ;; Set the font style for the headings
    (dolist (face '((org-level-1 . 1.5)
                    (org-level-2 . 1.4)
                    (org-level-3 . 1.3)
                    (org-level-4 . 1.2)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))

            (set-face-attribute (car face) nil 
                                :font "ETBembo"
                                :weight 'bold
                                :height (cdr face))))

(defun arterro/org-style ()
  (arterro/set-general-faces-org)
  (arterro/set-specific-faces-org)
  (arterro/set-visual-fill))

(add-hook 'org-mode-hook 'arterro/org-style)

(setq 
  time-stamp-active t
  time-stamp-line-limit 10 ; Check first 10 buffer lines for "Time-stamp:"
  time-stamp-format "%Y-%m-%d %H:%M:%S (%u)")

(add-hook 'write-file-hooks 'time-stamp)
(add-hook 'org-capture-mode-hook 'evil-insert-state)

;; ****************
;; ORG-ROAM
;; ****************

(with-eval-after-load 'org-roam
  (setq org-roam-directory (expand-file-name "~/notes/tome"))
  (setq org-id-link-to-org-use-id t)
  (setq org-roam-completion-system 'helm)
  (add-to-list 'display-buffer-alist
               '(("\\*org-roam\\*"
                  (display-buffer-in-direction)
                  (direction . right)
                  (window-width . 0.33)
                  (window-height . fit-window-to-buffer))))
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :immediate-finish t
           :if-new(file+head "${slug}.org"
                             "#+TITLE: ${title}\n#+hugo_lastmod: Time-stamp: <>\n\n")
           :unnarrowed t)
          ("n" "note" plain "%?"
           :if-new(file+head "${slug}.org"
                             "#+title: ${title}\n#+hugo_custom_front_matter: :summary \n#+hugo_date: %u\n#+hugo_auto_set_lastmod: Time-stamp: <>\n#+hugo_code_fence: nil\n#+hugo_section: notes\n#+hugo_draft: false\n#+hugo_tags: \n#+property: header-args :dir run :mkdirp yes :padline no :exports both :results code :eval no-export\n#+export_file_name: ${slug}\n")
           :empty-lines-after 1
           :unnarrowed t
           :immediate-finish t)
          ("t" "temp" plain "%?"
           :if-new(file+head "%<%Y%m%d%H%M%S>_${slug}.org"
                             "#+TITLE: ${title}\n#+hugo_lastmod: Time-stamp: <>\n\n")
           :immediate-finish t
           :unnarrowed t)
          ("p" "private" plain "%?"
           :if-new (file+head "${slug}-private.org"
                              "#+TITLE: ${title}\n")
           :immediate-finish t
           :unnarrowed t)))
  (setq org-roam-mode-sections
        (list #'org-roam-backlinks-insert-section
              #'org-roam-reflinks-insert-section
              #'org-roam-unlinked-references-insert-section))
  (org-roam-setup)
  (org-roam-db-autosync-mode)
  (setq org-roam-v2-ack t))
(setq org-id-extra-files (org-roam--list-files org-roam-directory))
