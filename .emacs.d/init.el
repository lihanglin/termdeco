(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(c-default-style (quote ((c-mode . "linux") (other . "gnu"))))
 '(ecb-options-version "2.40")
 '(global-linum-mode t)
 '(gud-gdb-command-name "gdb --annotate=3")
 '(kill-whole-line t)
 '(large-file-warning-threshold nil)
 '(linum-format "%3d ")
 '(make-backup-files nil)
 '(python-guess-indent t)
 '(python-use-skeletons t)
 '(safe-local-variable-values (quote ((org-hide-emphasis-markers))))
 '(tabbar-separator (quote (1.0))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit (shadow default) :foreground "red")))))

(add-to-list 'load-path "~/.emacs.d/plugin")

;; load all enabled tweak file *.el
;; it would load all tweak files named in
;; tweak-*.el or tweak-*.elc (if any)
;;(mapc 'load (file-expand-wildcards "~/.emacs.d/plugin-tweak/tweak-*.el"))
(mapc 'load
      (mapcar (lambda (x) (replace-regexp-in-string "\.el" "" x))
	      (file-expand-wildcards "~/.emacs.d/plugin-tweak/tweak-*.el")))
