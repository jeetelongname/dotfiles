;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; personal settings
(setq user-full-name "Jeetaditya Chatterjee"
      user-mail-address "jeetelongname@gmail.com"
      doom-theme 'doom-horizon); pretty self explanitory
      auth-sources '("~/.authinfo.gpg")

(global-auto-revert-mode t)
;;
;; move to the split after making it (tbh should be a default)
(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq fancy-splash-image
      (concat doom-private-dir "icons/emacs-icon.png"))

(setq display-line-numbers-type 'relative
      company-idle-delay 0.3 ; i like my autocomplete like my tea fast and always
      prettify-symbols-mode t
)
(setq browse-url-browser-function 'browse-url-firefox)
;; fonts
(setq doom-font (font-spec
       :family "Inconsolata Nerd Font"
       :size 15)
      doom-big-font (font-spec
       :family "Inconsolata Nerd Font"
       :size 20)
      doom-variable-pitch-font (font-spec
       :family "Inconsolata Nerd Font"
       :size 15)
      ;; doom-unicode-font
      ;; (font-spec
      ;;  :family "Ligconsolata Regular"
      ;;  :size 15)
)

;;org
(setq org-directory "~/org-notes/")
(require 'org-re-reveal)
(setq org-re-reveal-root "file:///home/jeet/org-notes/presentations/reveal.js/")

(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-code nil
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :background nil
                      :height 1.75
                      :weight 'bold)
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")
        org-superstar-headline-bullets-list '("⁕" "܅" "⁖" "⁘" "⁙" "⁜"))

  (require 'org-re-reveal) ;; FIXME its does not work. i may need to use `use-package'
  (setq org-re-reveal-root "file:///home/jeet/org-notes/presentations/reveal.js/"))

;; golang
(after! go-mode
  (set-ligatures! 'go-mode
    :def "func"
    :true "true" :false "false"
    :int "int" :str "string"
    :float "float" :bool "bool"
    :for "for"
    :return "return" :yeild "yeild"))
;; easy hugo

;; (setq easy-hugo-basedir "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/")
(setq easy-hugo-root "~/code/git-repos/mine/jeetelongname.github.io/blog-hugo/")
;;
;; elfeed
(after! elfeed
  (setq elfeed-search-filter "@1-week-ago"))
(setq rmh-elfeed-org-files (list (concat org-directory "elfeed.org")))
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)
(require 'elfeed-goodies)
(elfeed-goodies/setup)
;;
;; doom modeline
(setq doom-modeline-buffer-file-name-style 'truncate-upto-root
      doom-modeline-height 3
      doom-modeline-icon 't
      doom-modeline-modal-icon 'nil
      doom-modeline-env-version t
      doom-modeline-major-mode-color-icon t
      doom-modeline-buffer-modification-icon t
      doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)
      doom-modeline-icon(display-graphic-p))

(setq centaur-tabs-style "box"
      centaur-tabs-height 32
      centaur-tabs-show-navigation-buttons t
      centaur-tabs-set-bar 'under
      x-underline-at-descent-line t
      centaur-tabs-close-button "×"
      centaur-tabs-modified-marker "Ø")

(setq +treemacs-git-mode 'extended
      treemacs-width 30)

(map! (:after dired (:map dired-mode-map
     :localleader "p" #'peep-dired)))

(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(map!
 :n
  "zw" 'save-buffer ; = :w ZZ = :wq

 :leader
  :desc "Enable Coloured Values""t c" #'rainbow-mode
  :desc "Toggle Tabs""t B" #'centaur-tabs-local-mode
  :desc "Open Elfeed""o l" #'elfeed
  )

(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))
;;
;; mu4e and org-msg (if it does not look like its is loaded open mu4e and all si good)
(setq +mu4e-backend 'offlineimap
      mail-user-agent 'mu4e-user-agent)

(set-email-account! "gmail.com"
  '((mu4e-sent-folder       . "/gmail.com/Sent Mail")
    (mu4e-drafts-folder     . "/gmail.com/Drafts")
    (mu4e-trash-folder      . "/gmail.com/Trash")
    (mu4e-refile-folder     . "/gmail.com/All Mail")
    (smtpmail-smtp-user     . "jeetelongname@gmail.com")
    (user-mail-address      . "jeetelongname@gmail.com")
    )t)

(setq mu4e-use-fancy-chars t
      mu4e-headers-draft-mark '("D" . " ")
      mu4e-headers-flagged-mark '("F" . " ")
      mu4e-headers-new-mark '("N" . " ")
      mu4e-headers-passed-mark '("P" . " ")
      mu4e-headers-replied-mark '("R" . " ")
      mu4e-headers-seen-mark '("S" . " ")
      mu4e-headers-trashed-mark '("T" . " ")
      mu4e-headers-attach-mark '("a" . " ")
      mu4e-headers-encrypted-mark '("x" . "")
      mu4e-headers-signed-mark '("s" . " ")
      mu4e-headers-unread-mark '("u" . " "))

(setq mu4e-headers-fields
        '((:human-date . 12)
          (:flags . 4)
          (:from . 25)
          (:subject))
        )

(map! :localleader ; HACK ; works but is now in all org buffers
        :map org-mode-map
        :prefix "m"
        :desc "send and exit" "s" #'message-send-and-exit
        :desc "kill buffer"   "d" #'message-kill-buffer
        :desc "save draft"    "S" #'message-dont-send
        :desc "attach"        "a" #'mail-add-attachment)

(require 'org-msg)
(setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t"
      org-msg-startup "hidestars indent inlineimages"
      org-msg-greeting-fmt "\nHi *%s*,\n\n"
      org-msg-greeting-name-limit 3
      org-msg-text-plain-alternative t
      org-msg-signature "

 Regards,

 #+begin_signature
 -- *Jeetaditya Chatterjee* \\\\
 /Sent using my text editor/
 #+end_signature")
 (org-msg-mode)
