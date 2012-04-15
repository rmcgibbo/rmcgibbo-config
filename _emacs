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