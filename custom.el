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
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

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


(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)



(setq whitespace-line-column 120)
;; Whitespace mode should complain when more than 120 columns!
(add-hook 'go-mode-hook
          (lambda ()
            (setq-local whitespace-line-column 120)))

;; (load-file "~/.emacs.d/personal/evergreen.el/evergreen.el")
;; (setq evergreen-projects '("ops-manager-kubernetes", "mms")
;;       evergreen-default-project "ops-manager-kubernetes")


;; (use-package treemacs
;;   :ensure t)

(use-package all-the-icons
  :ensure t)

(add-hook 'racer-mode-hook #'company-mode)

(global-set-key (kbd "<XF86AudioRaiseVolume>") 'end-of-defun)
(global-set-key (kbd "<XF86AudioLowerVolume>") 'beginning-of-defun)

;; (require 'lsp-java)
;; (add-hook 'java-mode-hook #'lsp-java-enable)

(setq confirm-kill-emacs 'y-or-n-p)

;; Quick lisp stuff (should be installed first.)
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "sbcl")
;; (setq pytest-project-root-test (lambda (dirname) (equal dirname "mongodb-enterprise-tests/tls_tests")))
;; (setq pytest-project-root-test (lambda (dirname) (equal dirname "mongodb-enterprise-tests")))


(use-package pytest
  :ensure t
  :config
  (add-to-list 'pytest-project-root-files ".test_dir")
  (setq pytest-cmd-flags "-x -v"))


;; Where are my org files
(setq org-agenda-files '("~/workspace/agenda"))

(setq org-default-notes-file "~/.todo/tasks.org")
(setq org-capture-templates
             '(("w" "Work-related Tasks" entry
               (file "~/workspace/rodrigovalin/notes/work.org")
               "* TODO %?" :empty-lines 1)

               ("t" "Personal Tasks" entry
                (file org-default-notes-file)
                "* TODO %?" :empty-lines 1)))

(setq org-startup-indented t)
(setq org-startup-folded "showall")
(global-set-key (kbd "<f9>") 'org-capture)

(org-babel-do-load-languages 'org-babel-load-languages '((shell . t)))


(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

(use-package swiper-helm
  :ensure t
  :bind (("C-s" . swiper)))

;; Do not apply a theme
;;(disable-theme 'zenburn)
;;(setq prelude-theme nil)
;; (setq prelude-theme 'nord)

;; Use a nice font
(set-face-attribute 'default nil :family "Roboto Mono" :height 90 :weight 'regular)
;; Remove vertical bars from right side
(fringe-mode '(10 . 0))

;; Make command act as meta
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'meta))

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
 '(custom-safe-themes
   (quote
    ("bf390ecb203806cbe351b966a88fc3036f3ff68cd2547db6ee3676e87327b311" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default)))
 '(package-selected-packages
   (quote
    (nord-theme geiser lsp-ui company-lsp counsel :ob-rust ob-rust cargo go-playground go-snippets swiper-helm helm-rg yaml-mode markdown-mode doom-themes json-mode js2-mode gotest go-projectile go-eldoc company-go go-mode rainbow-mode elisp-slime-nav rainbow-delimiters helm-ag helm-descbinds helm-projectile helm smex ido-completing-read+ flx-ido zop-to-char zenburn-theme which-key volatile-highlights use-package undo-tree treemacs super-save smartrep smartparens slime rubocop rspec-mode racer projectile-ripgrep operate-on-number move-text magit imenu-anywhere hl-todo guru-mode google-c-style gitignore-mode gitconfig-mode git-timemachine gist flycheck-rust expand-region exec-path-from-shell elpy editorconfig easy-kill discover-my-major diminish diff-hl crux browse-kill-ring beacon anzu all-the-icons))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
