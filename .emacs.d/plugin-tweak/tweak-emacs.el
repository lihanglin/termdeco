;;
;; load library without tweak files and
;; my favor setting locates here
;;

;;
;; basic config for emacs
;;
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode t)
(global-font-lock-mode 1)
(menu-bar-mode -1)                              ; disable menu-bar
(setq fill-column 80)                            ; 80 chars auto line wrap
(setq enable-local-variables :safe)
(setq inhibit-startup-message t)                 ; disbale welcome message
(setq inhibit-startup-echo-area-message t)       ; disbale welcome message
(setq-default show-trailing-whitespace t)
(setq-default default-indicate-empty-lines t)
; (hl-line-mode t)                              ; cursor with highlight
; (setq initial-scratch-message nil)
(require 'linum-off)
(require 'show-whitespace-mode)


;;
;; my global hotkey
;;
(global-set-key (kbd "C-c mc") 'comment-or-uncomment-region)    ; mc means Multi-line Comment
(global-set-key (kbd "C-c ff") 'find-file-at-point)             ; open file where cursor pointed at
;(global-set-key (kbd "C-c find") 'find-name-dired)              ; find <dir> <file name inwildcard>

;;
;; keybind workaround
;;
;; map <select> key
;; I dont know why it does not work in xterm but in screen
;; if without the following line
;; please refer the http://forums.vandyke.com/showthread.php?t=5645&page=2 for discussion
;;
(define-key global-map [select] 'end-of-line)


;;
;; quick-copy-line
;;
(defun quick-copy-line ()
  "Copy the whole line that point is on and move to the beginning of the next line.
   Consecutive calls to this command append each line to the
   kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
	(end (line-beginning-position 2)))
    (if (eq last-command 'quick-copy-line)
	(kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end))))
  (beginning-of-line 2))

(global-set-key (kbd "C-c C-y") 'quick-copy-line)

;;
;; exit emacs
;; Prevent Emacs from asking “modified buffers exist; exit anyway"
;;
(defun my-kill-emacs ()
  "save some buffers, then exit unconditionally"
  (interactive)
  (save-some-buffers nil t)
  (kill-emacs))

(global-set-key (kbd "C-x C-c") 'my-kill-emacs)

;;
;; goto-match-paren
;; move cursor between paraenthesis to easy function browsing
;;

;; (defun goto-match-paren (arg)
;;   "Go to the matching  if on (){}[], similar to vi style of % "
;;   (interactive "p")
;;   ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
;;   (cond ((looking-at "[\[\(\{]") (forward-sexp))
;;         ((looking-back "[\]\)\}]" 1) (backward-sexp))
;;         ;; now, try to succeed from inside of a bracket
;;         ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
;;         ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
;;         (t nil)))

;; (global-set-key (kbd "M-{") (quote goto-match-paren))

;;
;; dired-mode
;;
(put 'dired-find-alternate-file 'disabled nil)

;; prevent ^(go previous dir) create another buffer
;; refer from http://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer
(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map (kbd "^")
	      (lambda () (interactive) (find-alternate-file "..")))
					; was dired-up-directory
	    ))

;;
;; ediff-mode
;;
(setq ediff-split-window-function 'split-window-horizontally) ; window style in ediff-mode

;;
;; isearch
;;
(defvar isearch-initial-string nil)   ; isearch with initial contents

(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
	   (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
	  (isearch-forward regexp-p no-recursive-edit)
	(setq isearch-initial-string (buffer-substring begin end))
	(add-hook 'isearch-mode-hook 'isearch-set-initial-string)
	(isearch-forward regexp-p no-recursive-edit)))))

(global-set-key (kbd "M-/") 'isearch-forward-at-point)

;;
;; c-mode
;;

;; add a new c-style for QEMU which uses 4 spaces as indent
;; most config are inherited from K&R style
(c-add-style "qemu"
	     '("k&r"  ; this must be defined elsewhere - it is in cc-modes.el
	       (c-indent-level 4)
	       (tab-width . 4)
	       (indent-tabs-mode . nil)
	       (c-basic-offset . 4)
	       (c-echo-syntactic-information-p . t)
	       (c-comment-only-line-offset . (0 . 0))
	       (c-offsets-alist . (
				   (c                     . c-lineup-C-comments)
				   (statement-case-open   . 0)
				   (case-label            . 0)
				   (substatement-open     . 0)
				   ))
	       ))

(setq c-default-style "linux")

;; use 80 char as column boundary in c-mode
(require 'column-marker)
(add-hook 'c-mode-common-hook (lambda () (interactive) (column-marker-1 80)))


;;
;; c++-mode
;;
;; LLVM coding style guidelines in emacs
;; Maintainer: LLVM Team, http://llvm.org/

;; Add a cc-mode style for editing LLVM C and C++ code
(c-add-style "llvm-style"
	     '("gnu"
	       (fill-column . 80)
	       (c++-indent-level . 2)
	       (c-basic-offset . 2)
	       (indent-tabs-mode . nil)
	       (c-offsets-alist . ((arglist-intro . ++)
				   (innamespace . 0)
				   (member-init-intro . ++)))))
(defun cpp-mode-hook-style ()
  (c-set-style "llvm-style"))        ; use my-style defined above

(add-hook 'c++-mode-hook 'cpp-mode-hook-style)


;  (auto-fill-mode)
;  (c-toggle-auto-hungry-state 1))
;; Files with "llvm" in their names will automatically be set to the
;; llvm.org coding style.
;; (add-hook 'c-mode-common-hook
;; 	  (function
;; 	   (lambda nil
;; 	     (if (string-match "llvm" buffer-file-name)
;; 		 (progn
;; 		      (c-set-style "llvm.org"))))))
