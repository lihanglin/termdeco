;; hotkey tips
;; M-.  - find definition
;; M-,  - pop the current operation
;; M-]  - find caller

(require 'ggtags)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'asm-mode)
	      (ggtags-mode 1))))

(global-set-key (kbd "M-,") 'pop-tag-mark)
