;; hotkey tips
;; M-.  - find definition
;; M-,  - pop the current operation
;; M-]  - find caller

(require 'ggtags)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'asm-mode)
	      (ggtags-mode 1))))

;;(global-set-key (kbd "M-,") 'pop-tag-mark)

;; the original bindkey of M-n and M-p in ggtags
;; were used for moving to next/prev match
;; They were conflicted with my tabbar.
;; I remap both keys to M-{ and M-}
(global-set-key (kbd "M-{") 'ggtags-prev-mark)
(global-set-key (kbd "M-}") 'ggtags-next-mark)
