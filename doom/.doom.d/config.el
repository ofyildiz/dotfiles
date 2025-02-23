;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Oemer Yildiz"
      user-mail-address "oemer.yildiz@tuhh.de")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :name "Liberation Mono-12")
      doom-variable-pitch-font (font-spec :name "Liberation Mono-12"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/")
(after! mu4e
  (setq! mu4e-maildir (expand-file-name "~/.mail/tuhh")
         mu4e-attachment-dir "~"
         mu4e-get-mail-command "mbsync -a"
         mu4e-index-update-in-background t
         mu4e-compose-signature-auto-include t
         mu4e-use-fancy-chars t
         mu4e-view-show-addresses t
         mu4e-view-show-images t
         mu4e-compose-format-flowed t
         mu4e-compose-in-new-frame t
         mu4e-change-filenames-when-moving t
         mu4e-maildir-shortcuts
         '( ("/Inbox" . ?i)
            ("/Drafts" . ?d)
            ("/Sent" . ?s)
            ("/Archives" . ?a)
            ("/Trash" . ?t))

         message-send-mail-function 'smtpmail-send-it
         message-signature-file "~/.signature"
         message-citation-line-format "On %a %d %b %Y at %R, %f wrote:\n"
         message-citation-line-function 'message-insert-formatted-citation-line
         message-kill-buffer-on-exit t))

(set-email-account! "coy1655"
                    '((user-mail-address      . "oemer.yildiz@tuhh.de")
                      (user-full-name         . "Oemer Faruk Yildiz")
                      (smtpmail-smtp-server   . "mail.tu-harburg.de")
                      (smtpmail-smtp-service  . 587)
                      (smtpmail-stream-type   . starttls)
                      (smtpmail-debug-info    . t)
                      (mu4e-drafts-folder     . "/Drafts")
                      (mu4e-sent-folder       . "/Sent")
                      (mu4e-refile-folder     . "/Archives")
                      (mu4e-trash-folder      . "/Trash")
                      (mu4e-update-interval   . 1800)
                      (mu4e-sent-messages-behavior . sent)
                      )
                    nil)

(setq! org-element-cache-persistent nil)

(setq! org-link-file-path-type 'relative)
(setq! org-publish-use-timestamps-flag nil)
(setq! org-publish-project-alist
       '(
         ("org-oemer"
          ;; path to my org index
          :base-directory "~/blog/org/"
          :base-extension "org"
          :publishing-directory "~/blog/html/"
          ;; :recursive t
          :with-toc nil
          :publishing-function org-html-publish-to-html
          :headline-levels 3
          :section-numbers nil
          :html-extension "html"
          :html-head "<link rel=\"stylesheet\"
                  href=\"css/default.css\" type=\"text/css\"/>"
          :html-preamble t
          )
         ("org-oemer-posts"
          ;; path to my org posts
          :base-directory "~/blog/org/posts/"
          :base-extension "org"
          :publishing-directory "~/blog/html/posts/"
          ;; :recursive t
          :with-toc nil
          :publishing-function org-html-publish-to-html
          :headline-levels 3
          :section-numbers nil
          :html-extension "html"
          :html-head "<link rel=\"stylesheet\"
                  href=\"../css/default.css\" type=\"text/css\"/>"
          :html-preamble t
          )
         ("org-oemer-recipes"
          ;; path to my org recipes
          :base-directory "~/blog/org/recipes/"
          :base-extension "org"
          :publishing-directory "~/blog/html/recipes/"
          ;; :recursive t
          :with-toc nil
          :publishing-function org-html-publish-to-html
          :headline-levels 3
          :section-numbers nil
          :html-extension "html"
          :html-head "<link rel=\"stylesheet\"
                  href=\"../css/default.css\" type=\"text/css\"/>"
          :html-preamble t
          )
         ("org-oemer-css"
          ;; path to my stylesheets
          :base-directory "~/blog/org/"
          :base-extension "css\\|scss"
          :publishing-directory "~/blog/html/"
          :recursive t
          :publishing-function org-publish-attachment
          )
         ("oemer" :components ("org-oemer" "org-oemer-posts" "org-oemer-recipes" "org-oemer-css"))
         ))
