(require 'ibuffer)

;;
;; the default keybind to browse ibuffer (C-x C-b)
;; conflicts with tmux escape keybind (C-b)
;; change it.
(global-set-key (kbd "C-x C-a") 'ibuffer)

