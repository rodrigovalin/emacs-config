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

(use-package forge
  :after magit)

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

(use-package htmlize
  :ensure t)

(use-package slime
  :ensure t
  :init
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

;; (use-package nord-theme
;;   :ensure t)

;; (setq gofmt-command "goimports")
;; (add-hook 'before-save-hook 'gofmt-before-save)



(setq whitespace-line-column 120)
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

(use-package all-the-icons
  :ensure t)

(add-hook 'racer-mode-hook #'company-mode)

(global-set-key (kbd "<XF86AudioRaiseVolume>") 'end-of-defun)
(global-set-key (kbd "<XF86AudioLowerVolume>") 'beginning-of-defun)

;; (require 'lsp-java)
;; (add-hook 'java-mode-hook #'lsp-java-enable)

(setq confirm-kill-emacs 'y-or-n-p)

;; Quick lisp stuff (should be installed first.)
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")
;; (setq pytest-project-root-test (lambda (dirname) (equal dirname "mongodb-enterprise-tests/tls_tests")))
;; (setq pytest-project-root-test (lambda (dirname) (equal dirname "mongodb-enterprise-tests")))


(use-package pytest
  :ensure t
  :config
  (add-to-list 'pytest-project-root-files ".test_dir")
  (setq pytest-cmd-flags "-x -v"))


;; Where are my org files
(setq org-agenda-files '("~/workspace/agenda"))

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

(use-package swiper-helm
  :ensure t
  :bind (("C-s" . swiper)))

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(setq company-tooltip-align-annotations t)

;; Do not apply a theme
;; (disable-theme 'zenburn)
;; (setq prelude-theme nil)
;; (setq prelude-theme 'nord)

;; Use a nice font
(set-face-attribute 'default nil :family "Source Code Pro" :height 90 :weight 'regular)
;; Remove vertical bars from right side
(fringe-mode '(10 . 0))

;; Make command act as meta
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'meta))

(setq org-startup-indented t)
(setq org-startup-folded "showall")
(setq org-directory "~/workspace/")

(org-babel-do-load-languages 'org-babel-load-languages '((shell . t)))

(use-package ob-rust
  :ensure t)

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
(add-to-list 'load-path (substitute-in-file-name "$HOME/workspace/rodrigovalin/elisp"))
(require 'kube)
(require 'mci)
;; (require 'omclient)

(setq prelude-flyspell nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zop-to-char zenburn-theme yaml-mode writeroom-mode which-key volatile-highlights use-package undo-tree treemacs swiper-helm super-save smex smartrep smartparens slime rubocop rspec-mode rainbow-mode rainbow-delimiters racer pytest projectile-ripgrep operate-on-number ob-rust nord-theme move-text lsp-ui json-mode js2-mode imenu-anywhere ido-completing-read+ htmlize hl-todo helm-rg helm-projectile helm-descbinds helm-ag guru-mode google-c-style go-snippets go-projectile go-playground gitignore-mode gitconfig-mode git-timemachine gist geiser forge flycheck-rust flx-ido expand-region exec-path-from-shell elpy elisp-slime-nav editorconfig easy-kill dockerfile-mode discover-my-major diminish diff-hl crux counsel company-lsp company-go cargo browse-kill-ring beacon anzu all-the-icons))))
