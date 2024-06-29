(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))

(setq
 verilog-align-ifelse t
 verilog-auto-delete-trailing-whitespace t
 verilog-auto-inst-param-value t
 verilog-auto-inst-vector nil
 verilog-auto-lineup 'declarations
 verilog-auto-newline nil
 verilog-auto-save-policy nil
 verilog-auto-template-warn-unused t
 verilog-case-indent 4
 verilog-cexp-indent 4
 verilog-highlight-grouping-keywords nil
 verilog-highlight-modules t
 verilog-indent-level 4
 verilog-indent-level-behavioral 4
 verilog-indent-level-declaration 4
 verilog-indent-level-directive   0
 verilog-indent-level-module 4
 verilog-tab-to-comment nil
 verilog-tab-always-indent        t
 verilog-highlight-p1800-keywords t)


(defun my-verilog-hook ()
    (setq indent-tabs-mode nil)
    (setq tab-width 4))
 (add-hook 'verilog-mode-hook 'my-verilog-hook)

;; (setq verilog-indent-level             4
;;       verilog-indent-level-module      0
;;       verilog-indent-level-declaration 0
;;       verilog-indent-level-behavioral  0
;;       verilog-indent-level-directive   0
;;       verilog-case-indent              4
;;       verilog-auto-newline             nil
;;       verilog-auto-indent-on-newline   t
;;       verilog-tab-always-indent        t
;;       verilog-auto-endcomments         nil
;;       verilog-minimum-comment-distance 40
;;       verilog-indent-begin-after-if    t
;;       verilog-auto-lineup              'declarations
;;       verilog-highlight-p1800-keywords nil
;;       verilog-linter			 "my_lint_shell_command"
;;       )
