;;; OS level copy / paste
(setq x-select-enable-clipboard t)

(setq make-backup-files nil)

;;; Start the emacs server so that emacsclient can be used.
(server-start)

;;; Add the site directory to load path.
(defvar *roderic-site-dir* (expand-file-name "~/.emacs.d/site/"))
(add-to-list 'load-path *roderic-site-dir*)

(defun add-load-path (path)
  (add-to-list 'load-path (concat *roderic-site-dir* path)))

;;; Show column numbers in the mode line.
(column-number-mode t)

;;; Highlight open and close parenthesis when the point is on them.
(show-paren-mode t)

;;; Convenient way to open files and switch buffers.
(ido-mode t)

;;; Allow narrowing without showing a warning.
(put 'narrow-to-region 'disabled nil)

;;; Same for upcase-region
(put 'upcase-region 'disabled nil)

;;; And downcase-region
(put 'downcase-region 'disabled nil)

;;; Indent with spaces, not tabs.
(setq-default indent-tabs-mode nil)

(setq-default eshell-path-env "/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:~/bin:~/.local/bin")

;;; Execute a command without having to use meta.
(global-set-key "\C-x\C-m" 'execute-extended-command)

;;; Insert a λ.
(global-set-key "\C-x/" '(lambda () (interactive) (insert #x3bb)))

;;; Handle SGR control sequences in output. Allows colored text from e.g. a unix
;;; command.
(ansi-color-for-comint-mode-on)

;;; Intelligent buffer renaming
(require 'uniquify)
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*") ; ignore special buffers
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


;;; Clojure
(add-load-path "clojure-mode")
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;;; TextMate
(add-load-path "textmate-mode")
(require 'textmate)
(textmate-mode)
(global-set-key "\C-c\C-g" 'textmate-goto-file)

;;; Paredit
(require 'paredit)
(dolist (hook '(scheme-mode-hook
                emacs-lisp-mode-hook
                lisp-mode-hook))
  (add-hook hook 'enable-paredit-mode))

;;; Chibi
(add-to-list 'auto-mode-alist '("\\.sld" . scheme-mode))

;;; Scheme48
(autoload 'scheme48-mode "scheme48"
  "Major mode for editing scheme with scheme48." t)

;;; Zencoding
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)

;;; Tuareg
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(dolist (ext '(".cmo" ".cmx" ".cma" ".cmxa" ".cmi"))
  (add-to-list 'completion-ignored-extensions ext))

;;; Load markdown-mode on markdown files.
(require 'markdown-mode)
(add-to-list 'auto-mode-alist
             (cons "\\.md\\(wn\\)?$" 'markdown-mode))

;;; Coffee script.
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

;;; Load textile-mode on textile files.
(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))

;;; Global color theme stuff.
(require 'color-theme)

;;; Tango color theme.
(autoload 'color-theme-tango "color-theme-tango"
  "Tango color theme for emacs"
  t)
(color-theme-tango)

;;; Auto-Fill for these modes.
(dolist (hook '(text-mode-hook
                tuareg-mode-hook
                python-mode-hook
                scheme-mode-hook))
  (add-hook hook 'turn-on-auto-fill))

;;; MELPA package archive
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;; Disable unused UI elements.
;;; Be careful to do it in a way that doesn't load them just for them to be
;;; disabled.
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

;;; Make command meta.
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)

(set-frame-font "Menlo Regular 14")

;;; Set the indentation when editing Python to 2.
(add-hook 'python-mode-hook
          (lambda ()
            (setq-default python-indent 2)))

;;; Set indentation in html to 2
(add-hook 'html-mode-hook
          (lambda ()
            (setq-default sgml-basic-offset 2)))

;;; Set the column to indent on to 80
(setq-default fill-column 100)

;;; Use the gnu style when editing c-ish languages.
(add-hook 'c-initialization-hook
          (lambda ()
            (setq-default c-default-style "gnu")))

(add-hook 'js-mode-hook
          (lambda ()
            (setq-default js-indent-level 2)))

;;; Set tab width to 2.
(setq-default tab-width 2)
