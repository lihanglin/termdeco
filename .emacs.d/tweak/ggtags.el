;; hotkey tips
;; M-.  - find tag and jump to
;; M-,  - jump back
;; M-*  - jump back
;; M-]  - ggtags-find-reference (definition)

(require 'ggtags)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'asm-mode)
	      (ggtags-mode 1))))

;;
;; when ggtags-global-mode was invoked, my tabbar keybind of forward/backward
;; would be hijacked by it and my keymap 'M-n/p' were used to navigate the matched
;; tags forward/backward.
;; It was annoying and had to disable its navigation mode
;;
(setq ggtags-enable-navigation-keys nil)
