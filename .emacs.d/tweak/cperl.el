(require 'cperl-mode)

(fset 'perl-mode 'cperl-mode)
(setq cperl-indent-level 8
      cperl-indent-parens-as-block t
      cperl-tab-always-indent t)

; cperl-mode hijack my love keybind
; I decide to get it back
(define-key cperl-mode-map (kbd "C-c C-y") 'quick-copy-line)
