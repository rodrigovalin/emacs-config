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
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd \"M-.\") 'godef-jump)))

(use-package flycheck-rust
  :ensure t)

(use-package racer
  :ensure t
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  )

(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

;; Use a nice font
(set-face-attribute 'default nil :family "Source Code Pro" :height 120 :weight 'normal)
;; Remove vertical bars from right side
(fringe-mode '(10 . 0))

;; Make command act as meta
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta))


(setq whitespace-line-column 120)
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

;; Activate autocomplete
;; TODO: Set GOPATH
(setenv "GOPATH" (substitute-in-file-name "$HOME/workspace/go"))
;; (ac-config-default)

;; Enable own Elisp modules
(add-to-list 'load-path (substitute-in-file-name "$HOME/workspace/licorna/elisp"))
(require 'kube)
(require 'mci)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   (quote
    ("e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "c5d320f0b5b354b2be511882fc90def1d32ac5d38cccc8c68eab60a62d1621f2" "723e48296d0fc6e030c7306c740c42685d672fd22337bc84392a1cf92064788a" "891debfe489c769383717cc7d0020244a8d62ce6f076b2c42dd1465b7c94204d" "e4a6fc5d9f4bc63b6ce9743396b68098ae7011d29e9876082ef3969c18b0ea93" "0b1ded82ebea8b76e3c17c628fe0d3c7aa46746c3efcf657f633d71989110585" "bbb4a4d39ed6551f887b7a3b4b84d41a3377535ccccf901a3c08c7317fad7008" "8ff5073d6c694a442c85505d6f885a752061b3738e2de7c2b9042ffd2c1579e5" "4f5fb2b25a9c71d584472abc5b6f850d616ac280a69e43df6e78ddf2b4aa68fa" "77c3f5f5acaa5a276ca709ff82cce9b303f49d383415f740ba8bcc76570718b9" "0598de4cc260b7201120b02d580b8e03bd46e5d5350ed4523b297596a25f7403" "a866134130e4393c0cad0b4f1a5b0dd580584d9cf921617eee3fd54b6f09ac37" "4e21fb654406f11ab2a628c47c1cbe53bab645d32f2c807ee2295436f09103c6" "18eea36d8ecd6e236d25c4cc22d1a772cd34b32d83356a86d3eaf0865788c426" "a8c927cf1acf19ae27bd971894fa94c8114c31496c3d9cdfcc4d373dab34e4ef" "3d20cf0dbc6465a02c468abf2d9b8c17e88b20fbc05a04205a829285da28799d" "90bd0eb20a1cb155b5a076f698b3c72cfe775aa7ea93b7bfbc171eb250db5e20" "bea5fd3610ed135e6ecc35bf8a9c27277d50336455dbdd2969809f7d7c1f7d79" "599f1561d84229e02807c952919cd9b0fbaa97ace123851df84806b067666332" "aae95fc700f9f7ff70efbc294fc7367376aa9456356ae36ec234751040ed9168" "5e52ce58f51827619d27131be3e3936593c9c7f9f9f9d6b33227be6331bf9881" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" default)))
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (go-playground yasnippet anti-zenburn-theme racer go-autocomplete toml-mode distinguished-theme geiser writeroom-mode vkill exec-path-from-shell diminish zop-to-char zenburn-theme yaml-mode which-key volatile-highlights vala-mode use-package undo-tree smex smartrep smartparens smart-mode-line slime rubocop rspec-mode restclient-helm rainbow-mode rainbow-identifiers rainbow-delimiters projectile-ripgrep prettier-js ov operate-on-number move-text material-theme markdown-mode kubernetes json-mode inf-mongo indium imenu-anywhere ido-completing-read+ helm-projectile helm-descbinds helm-ag handlebars-mode guru-mode grizzl god-mode go-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck-rust flx-ido expand-region elpy elisp-slime-nav editorconfig easy-kill dockerfile-mode discover-my-major diff-hl crux cargo browse-kill-ring beacon anzu ace-window)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
