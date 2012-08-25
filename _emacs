(add-to-list 'load-path "~/.emacs.d")

(setq inhibit-startup-message t) ; no welcome screen
(setq tab-width 4)          ; and 4 char wide for TAB
(setq indent-tabs-mode nil) ; And force use of spaces

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

;; emacs will create the backup dir automatically, but not the autosave dir.
(make-directory "~/.emacs.d/autosaves/" t)

;; Remove the menu bar
(menu-bar-mode 0)

;; force syntax highting!
(global-font-lock-mode 1)

;; display column number
(column-number-mode 1)

;; make colors display correctly in M-x shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; make the prompt read only in M-x shell
(add-hook 'shell-mode-hook 
     '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

;; add markdown mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
