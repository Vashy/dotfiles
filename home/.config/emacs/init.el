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
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; relative line no
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

;; Move lock files (.#*) to ~/tmp folder
(setq lock-file-name-transforms `((".*" "~/tmp/.emacs/" t)))
;; Move autosave files (#*#) to ~/tmp folder
(setq auto-save-file-name-transforms `((".*" "~/tmp/.emacs/" t)))
(setq backup-directory-alist '((".*" . "~/tmp/.emacs/")))

;; Change window focus with Shift+arrow
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; --------
;; org-mode
;; --------

(use-package org
  :init
  (setq org-startup-indented t)
  (setq org-log-done 'time)
  ;; show Monday as first day in date picker
  (setq calendar-week-start-day 1)
;  :config
;  (add-hook 'org-mode-hook (lambda ()
;			     (org-bullets-mode 1)))
  :bind (("C-c a" . org-agenda)))

 (use-package org-modern
   :ensure t
   :config
   (global-org-modern-mode))

;(org-bullets-mode 1)

;; -----
;; fonts
;; -----
(set-face-attribute 'default nil
                    :font "JetBrainsMono NFM"
                    :height 160
                    :weight 'normal)

; (add-to-list 'default-frame-alist
             ; '(font . "JetBrainsMono NFM"))
;              '(font . "DejaVu Sans Mono-18"))

(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

(use-package ef-themes
  :ensure t)

(use-package gruber-darker-theme
  :ensure t)
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
  :ensure t
  :init
  (savehist-mode))

;; IDEA's Ctrl+w
(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;; Type 1-2 chars to jump anywhere
(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char-timer))

;; Standard Ido setup
(ido-mode 1)
(ido-everywhere 1)

;; Make Ido work everywhere
(use-package ido-completing-read+
  :ensure t
  :config
  (ido-ubiquitous-mode 1))

(use-package ido-vertical-mode
  :ensure t
  :init
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  :config
  (ido-vertical-mode 1))

(use-package ido-vertical-mode
  :ensure t
  :init
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  :config
  (ido-vertical-mode 1))

;; company: better autocomplete
(use-package company
  :ensure t
  :init
  (global-company-mode)
  :config
  (setq company-backends '((company-etags company-dabbrev-code)))
;  (setq company-backends '(company-etags company-capf))
  )
;(add-hook 'prog-mode-hook (lambda ()
;			    (add-hook 'after-init-hook 'global-company-mode)))

;; ----------
;; projectile
;; ----------

(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/Documents/Obsidian" "~/Work/"))
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings))

(use-package smex
  :ensure t
  :bind (("M-x" . smex)
	 ("M-X" . smex-major-mode-commands))
  :config
  (smex-initialize))

;; Matching parenthesis
(use-package paredit
  :ensure t
  :config (paredit-mode 0))

(setq c-basic-offset 4)
