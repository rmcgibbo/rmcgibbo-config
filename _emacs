;;(add-to-list 'load-path "~/.emacs.d")

(setq inhibit-startup-message t) ; no welcome screen
(setq tab-width 4)          ; and 4 char wide for TAB
(setq indent-tabs-mode nil) ; And force use of spaces
(setq vc-follow-symlinks t) ; follow symlinks and don't ask


;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(custom-safe-themes (quote ("38c4fb6c8b2625f6307f3dde763d5c61d774d854ecee9c5eb9c5433350bc0bef" default))))

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

;; highlight ipython files like python
(add-to-list 'auto-mode-alist '("\\.ipy\\'" . python-mode))

;; highlight cython files like python
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . python-mode))

;; highlight cuda files like c++
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

;; add the theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (load-theme 'ir-black t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; speedbar (like the TextMate file drawer)
(when window-system
  (require 'sr-speedbar)
  (sr-speedbar-open)
  (set-frame-width (selected-frame) 120)
)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	          (next-win-buffer (window-buffer (next-window)))
		       (this-win-edges (window-edges (selected-window)))
		            (next-win-edges (window-edges (next-window)))
			         (this-win-2nd (not (and (<= (car this-win-edges)
							      (car next-win-edges))
							      (<= (cadr this-win-edges)
								   (cadr next-win-edges)))))
				      (splitter
				             (if (= (car this-win-edges)
						         (car (window-edges (next-window))))
						   'split-window-horizontally
					       'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	    (funcall splitter)
	      (if this-win-2nd (other-window 1))
	        (set-window-buffer (selected-window) this-win-buffer)
		  (set-window-buffer (next-window) next-win-buffer)
		    (select-window first-win)
		      (if this-win-2nd (other-window 1))))))

(add-to-list 'auto-mode-alist
               '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
               '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))
