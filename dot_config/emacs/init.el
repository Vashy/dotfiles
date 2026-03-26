;; Redirect emacs shenanegans to its own file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'package)

;; Add MELPA to the list of repositories
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Initialize the package system
(package-initialize)

;; Load it if it exists (so your UI changes actually apply)
(when (file-exists-p custom-file)
  (load custom-file))

;; use rg instead of grep
; (setq grep-command "rg --vimgrep ")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1) ; matching parenthesis

;; disable bell
(setq visible-bell t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

;; Move lock files (.#*) to ~/tmp folder
(setq lock-file-name-transforms `((".*" "~/tmp/.emacs/" t)))
;; Move autosave files (#*#) to ~/tmp folder
(setq auto-save-file-name-transforms `((".*" "~/tmp/.emacs/" t)))
(setq backup-directory-alist '((".*" . "~/tmp/.emacs/")))

;; org-mode

;; automatically set date time when setting DONE
(setq org-log-done 'time)

;; show Monday as first day in date picker
(setq calendar-week-start-day 1)

(use-package org
  :bind (("C-c a" . org-agenda)))

(set-face-attribute 'default nil
                    :font "JetBrainsMono NFM"
                    :height 160
                    :weight 'normal)

; (add-to-list 'default-frame-alist
             ; '(font . "JetBrainsMono NFM"))
;              '(font . "DejaVu Sans Mono-18"))

(load-theme 'dracula t)
; (load-theme 'gruber-darker t)

;; Refresh contents if you haven't recently
(unless package-archive-contents
  (package-refresh-contents))

;; Enable Vertico.
; (use-package vertico
;  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
 ; :init
;  (vertico-mode))
(use-package savehist
  :init
  (savehist-mode))

;; IDEA's Ctrl+w
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; Type 1-2 chars to jump anywhere
(use-package avy
  :bind ("M-j" . avy-goto-char-timer))

;; Standard Ido setup
(ido-mode 1)
(ido-everywhere 1)

;; Make Ido work everywhere
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings))

;; Setup Smex for M-x
(require 'smex)
(smex-initialize)
;; You must bind Smex to a key to actually use it!
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Matching parenthesis
(require 'paredit)
(paredit-mode 1)
