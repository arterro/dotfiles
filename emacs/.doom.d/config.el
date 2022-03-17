;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Arturo Delgado"
      user-mail-address "adelgado@arter.ro")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Iosevka SS08" :size 18 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 18))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-palenight)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Disable exit confirmation
(setq confirm-kill-emacs nil)

;; Enable auto-save and backup files
(setq auto-save-default t
      make-backup-files t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/notes/")

;; Only display the first two menu items on the dashboard menu
(setq +doom-dashboard-menu-sections (cl-subseq +doom-dashboard-menu-sections 0 2))

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
(org-superstar-restart))

;(map! :g "C-c n i"
;      :desc "Org Roam Insert"
;      "n i" #'org-roam-node-insert)

;(after! org-roam
;    (setq org-roam-completion-everywhere t)
;    (map!  ("C-c n l" . org-roam-buffer-toggle)
;           ("C-c n f" . org-roam-node-find)
;           ("C-c n i" . org-roam-node-insert)
;           :map org-mode-map
;           ("C-M-i" . completion_at_point)))

(setq org-roam-directory "~/notes/roam")

;; (org-babel-do-load-languages 
;;     'org-babel-load-languages
;;     (append org-babel-load-languages
;;     '(
;;       (python . t)
;;       (ruby . t)
;;       (php . t)
;;       (yaml . t)
;;       )))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
