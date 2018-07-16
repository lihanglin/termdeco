(require 'lazy-search)

(defun my-mark-symbol-backward ()
  (interactive)
  (lazy-search-mark-symbol)
  (lazy-search-move-backward))

(defun my-mark-symbol-forward ()
  (interactive)
  (lazy-search-mark-symbol)
  (lazy-search-move-forward))

(global-set-key (kbd "C-p") 'my-mark-symbol-backward)
(global-set-key (kbd "C-o") 'my-mark-symbol-forward)
