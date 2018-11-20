(require 'helm-git-grep) ;; Not necessary if installed by package.el

(global-set-key (kbd "C-x gg") 'helm-git-grep-at-point)

;; (global-set-key (kbd "C-x gg") 'helm-git-grep)
;; ;; Invoke `helm-git-grep' from isearch.
;; (define-key isearch-mode-map (kbd "C-x gg") 'helm-git-grep-from-isearch)
;; ;; Invoke `helm-git-grep' from other helm.
;; (eval-after-load 'helm
;;     '(define-key helm-map (kbd "C-x gg") 'helm-git-grep-from-helm))
