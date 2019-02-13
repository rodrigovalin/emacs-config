;;
;; custom.el configuration file
;; this is meant to be used with emacs-prelude
;;
;; Rodrigo Valin
;;

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; Generic configuration
;;

;; disable emacs original movement keys
(setq prelude-guru nil)

;; menu bar is hidden
(menu-bar-mode -1)

;; disables visible bell
(setq visible-bell t)

;; initial scratch buffer should be empty
(setq initial-scratch-message nil)

;; makes scroll bar dissappear
(toggle-scroll-bar 0)

(use-package elpy
  :ensure t
  :config (elpy-enable))

(use-package rspec-mode
  :ensure t)

(use-package rubocop
  :ensure t)

(use-package projectile-ripgrep
  :ensure t)

(use-package slime
  :ensure t
  :init
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; Whitespace mode should complain when more than 120 columns!
(add-hook 'go-mode-hook
          (lambda ()
            (setq-local whitespace-line-column 120)))

(use-package flycheck-rust
  :ensure t)

(use-package racer
  :ensure t
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  )

(use-package treemacs
  :ensure t)

(use-package all-the-icons
  :ensure t)

(add-hook 'racer-mode-hook #'company-mode)

(global-set-key (kbd "<XF86AudioRaiseVolume>") 'end-of-defun)
(global-set-key (kbd "<XF86AudioLowerVolume>") 'beginning-of-defun)

;; (require 'lsp-java)
;; (add-hook 'java-mode-hook #'lsp-java-enable)

(setq whitespace-line-column 120)

;; do not use whitespace mode everywhere.
(setq confirm-kill-emacs 'y-or-n-p)

;; Quick lisp stuff (should be installed first.)
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "sbcl")

;; Where are my org files
(setq org-agenda-files '("~/workspace/agenda"))

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

(require 'cc-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(setq company-tooltip-align-annotations t)

;; Do not apply a theme
(setq prelude-theme nil)
;; Use a nice font
(set-face-attribute 'default nil :family "Source Code Pro" :height 180 :weight 'regular)
;; Remove vertical bars from right side
(fringe-mode '(10 . 0))

;; Make command act as meta
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'meta))

(setq org-startup-indented t)
(setq org-startup-folded "showall")
(setq org-directory "~/workspace/")

(setq whitespace-line-column 120)

;; set indent in html mode to 4 spaces.
(setq sgml-basic-offset 4)
;;
;; Emacs Prelude modules
;;
;; Prelude has its own way of configuring modules, badly enough
;; it is not based on use-package, which seems to be the standard.
;; Anyway, the following modules include lots of interesting
;; configurations that are worth having; actually, most of them
;; are 99% the Prelude experience.
;;
;; These are supposed to be in `.emacs.d/prelude-modules.el` but I
;; like having a centralized configuration.
;;
;; Python module:
;; Prelude ships with `anaconda-mode` which I don't like. That's why
;; that module is disabled and `elpy` is enabled instead with
;; `use-package`.
;;
(require 'prelude-ido)
(require 'prelude-helm)
(require 'prelude-helm-everywhere)
(require 'prelude-company)
(require 'prelude-programming)
(require 'prelude-common-lisp)
(require 'prelude-emacs-lisp)
(require 'prelude-go)
(require 'prelude-js)

;; Activate autocomplete
;; TODO: Set GOPATH
(setenv "GOPATH" (substitute-in-file-name "$HOME/workspace/go"))
;; FIX: This does not seems to get $GOPATH/bin into the path. Executables in that directory are not found by emacs.
(setenv "PATH" (concat (getenv "PATH") ":" (concat (getenv "GOPATH") "/bin")))
;; (ac-config-default)

;; Enable own Elisp modules
(add-to-list 'load-path (substitute-in-file-name "$HOME/workspace/licorna/elisp"))
(require 'kube)
(require 'mci)
;; (require 'omclient)

(setq prelude-flyspell nil)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   (quote
    ("1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "b01b91ba9276deb39aa892c105a8644ef281b4d1804ab7c48de96e9c5d2aaa48" "a156fcac344bbfdc979a5adf9cecf1c2de56c4c937549ae0571b7f11ad4fe6a9" "9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "8891c81848a6cf203c7ac816436ea1a859c34038c39e3cf9f48292d8b1c86528" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "a566448baba25f48e1833d86807b77876a899fc0c3d33394094cf267c970749f" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" default)))
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (lsp-ui lsp-java company-lsp ein csv-mode ant google-c-style golint restclient helm-rg circe less-css-mode json-mode paredit doom-themes markdown-mode gotest go-projectile go-eldoc company-go rainbow-mode elisp-slime-nav rainbow-delimiters helm-ag helm-descbinds helm-projectile helm smex ido-completing-read+ flx-ido racer flycheck-rust slime projectile-ripgrep rubocop rspec-mode elpy use-package zop-to-char zenburn-theme yaml-mode which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line projectile operate-on-number move-text magit imenu-anywhere hl-todo guru-mode grizzl god-mode go-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region editorconfig easy-kill dockerfile-mode discover-my-major diminish diff-hl crux browse-kill-ring beacon anzu ace-window)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
