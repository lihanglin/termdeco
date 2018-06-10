(require 'xgtags)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (xgtags-mode 1)))

(add-hook 'c++-mode-common-hook
	  (lambda ()
	    (xgtags-mode 1)))

(add-hook 'asm-mode-common-hook
	  (lambda ()
	    (xgtags-mode 1)))
