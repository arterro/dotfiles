;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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

;; Don't align tags
;; (setq org-tags-column 0)

;; (setq org-src-fontify-natively t)

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

;; Initial setup for org-mode
(defun arterro/org-mode-setup ()
  (org-indent-mode)
  (org-adapt-indentation nil)
  (variable-pitch-mode nil)
  (visual-line-mode)
  (arterro/org-mode-visual-fill))

;; Centers document and sets page to a fixed width
(defun arterro/org-mode-visual-fill()
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
    (setq org-superstar-remove-leading-stars t)
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

;; (org-babel-do-load-languages 
;;     'org-babel-load-languages
;;     (append org-babel-load-languages
;;     '(
;;       (python . t)
;;       (ruby . t)
;;       (php . t)
;;       (yaml . t)
;;       )))

;; Whenever you reconfigure a package, 
;; Disable exit confirmationmake sure to wrap your config in an
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
