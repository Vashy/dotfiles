;; Redirect emacs shenanegans to its own file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Load it if it exists (so your UI changes actually apply)
(when (file-exists-p custom-file)
  (load custom-file))

;; use rg instead of grep
; (setq grep-command "rg --vimgrep ")

(menu-bar-mode -1)
(tool-bar-mode -1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

(set-face-attribute 'default nil
                    :font "JetBrainsMono NFM"
                    :height 170
                    :weight 'normal)

; (add-to-list 'default-frame-alist
             ; '(font . "JetBrainsMono NFM"))
;              '(font . "DejaVu Sans Mono-18"))

(load-theme 'dracula t)

(require 'package)

;; Add MELPA to the list of repositories
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Initialize the package system
(package-initialize)

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
