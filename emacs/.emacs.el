(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/org/agenda.org"))
 '(package-selected-packages
   '(lsp-mode eglot ripgrep gnuplot minions doom-modeline ivy command-log-mode use-package magit projectile company-math auctex ranger company vertico avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun my-latex-mode-setup ()
  (setq-local company-backends
	      (append '((company-math-symbols-latex
			 company-math-symbols-unicode
			 company-latex-commands))
		      company-backends)))
(add-hook 'LaTeX-mode-hook 'my-latex-mode-setup)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'before-save-hook 'whitespace-cleanup)
(company-mode 1)
(vertico-mode 0)
(ranger-override-dired-mode t)
(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(require 'package)
(dolist (elem '(("melpa" . "https://melpa.org/packages/")
		("org" . "https://orgmode.org/elpa/")))
  (add-to-list 'package-archives elem t))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k". ivy-previous-line)
	 ("C-d". ivy-previous-i-search-kill))
  :init (ivy-mode 1))
(setq ivy-use-selectable-prompt t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode 1)
;;   (setq doom-modeline-height 1))
(use-package gnuplot)

(electric-pair-mode 1)
(menu-bar-mode 0)
(setq inhibit-startup-message t)
(setq visible-bell t)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode -1)
(set-fringe-mode 10)
;;(global-linum-mode 0)
(line-number-mode 1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)

(defun custom-after-frame (frame)
  (if (display-graphic-p frame)
      (progn
	(set-face-attribute 'default nil :font "Courier New" :height 150)
	)))
(mapc 'custom-after-frame (frame-list))
(if (daemonp)
    (add-hook 'server-after-make-frame-hook (custom-after-frame (selected-frame))))
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(add-to-list 'load-path "~/.emacs.d/evil")
(setq evil-want-C-u-scroll t)
(setq evil-undo-system 'undo-redo)
(require 'evil)
(evil-mode 1)
(global-set-key (kbd "C-c s") 'evil-avy-goto-char-2)

;; add evil snipe
(org-babel-do-load-languages 'org-babel-load-languages '((latex . t)
							 (python . t)))

(setq python-shell-interpreter-args "-m IPython")

(if (eq system-type 'windows-nt)
    (add-to-list 'exec-path "d:/hunspell/bin"))

(setq ispell-program-name (locate-file "hunspell"
				       exec-path exec-suffixes 'file-executable-p))
(setq ispell-local-dictionary-alist '(
				      (nil
				       "[[:alpha:]]"
				       "[^[:alpha:]]"
				       "[']"
				       t
				       ("-d" "en_US" "-p" "D:\\hunspell\\share\\hunspell\\personal.en")
				       nil
				       iso-8859-1)

				      ("american"
				       "[[:alpha:]]"
				       "[^[:alpha:]]"
				       "[']"
				       t
				       ("-d" "en_US" "-p" "D:\\hunspell\\share\\hunspell\\personal.en")
				       nil
				       iso-8859-1)
				      ("deutsch"
				       "[[:alpha:]ÄÖÜéäöüß]"
				       "[^[:alpha:]ÄÖÜéäöüß]"
				       "[']"
				       t
				       ("-d" "de_DE_frami" "-p"
					"D:\\hunspell\\share\\hunspell\\personal.de")
				       nil
				       iso-8859-1)
				      ))

(require 'ispell)

(add-to-list 'load-path "d:\\EmacsPackages")
(require 'winum)
(winum-mode 1)
(winum-set-keymap-prefix (kbd "C-w"))

;; does not work, delete c-eldoc in the future, keep here only for reference
;; (require 'c-eldoc)
;; (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
;; (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)

(global-visual-line-mode 1)
(setq gdb-many-windows t)
(setq gdb-show-main t)

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;; (use-package all-the-icons
;;   :if (display-graphic-p))
;; (use-package nerd-icons)

;; (use-package ripgrep)

;; org mode
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-capture-templates
      '(("o" "Onetime" entry (file+headline "~/org/agenda.org" "Onetime")
	 "* TODO %?\n %i\n %a")
	("r" "Recurrent" entry (file+headline "~/org/agenda.org" "Recurrent")
	 "* TODO %?\n %i\n %a")))
(setq org-agenda-exporter-settings
	'((ps-print-color-p 'black-white)))

(setq make-backup-files nil)

;; tags
(setq path-to-ctags "c:/cygwin64/bin/ctags.exe")

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name))))
;; copy TAGS file to root directory after creation and execute visit-tags-table
