 ;tabbar
(load "tabbar")
(tabbar-mode)

;tabbar default attri
(set-face-attribute
 'tabbar-default nil
 :background "white"
 :foreground "color-52")

(set-face-attribute
 'tabbar-unselected nil
 :background "color-248"
 :foreground "color-52")

(set-face-attribute
 'tabbar-selected nil
 :background "red"
 :foreground "white")

;; (set-face-attribute
;;  'tabbar-highlight nil
;;  :background "white"
;;  :foreground "black"
;;  :underline nil
;;  :box '(:line-width 5 :color "white" :style nil))

(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "green" :style nil))

(set-face-attribute
 'tabbar-separator nil
 :background "white"
 :height 0.6)

;; Change padding of the tabs
;; we also need to set separator to avoid overlapping tabs by highlighted tabs
(custom-set-variables
 '(tabbar-separator (quote (1.0))))
;; adding spaces
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label (if tabbar--buffer-show-groups
                    (format "[%s] " (tabbar-tab-tabset tab))
                  (format "%s " (tabbar-tab-value tab)))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))

;make all buffer into one group
(setq tabbar-buffer-groups-function
      (lambda () (list "All Buffers")
	)
)

;hide some special buffer
(setq tabbar-buffer-list-function
      (lambda ()
	(remove-if
	 (lambda(buffer)
	   (find (aref (buffer-name buffer) 0) " *"))
	 (buffer-list))))

;; (setq *tabbar-ignore-buffers* '("*scratch*" "*Messages*" "*IBuffer*"))
;; (setq tabbar-buffer-list-function
;;       (lambda ()
;; 	(remove-if
;; 	 (lambda (buffer)
;; 	   (and (not (eq (current-buffer) buffer)) ; Always include the current buffer.
;; 		(loop for name in *tabbar-ignore-buffers* ;remove buffer name in this list.
;; 		      thereis (string-equal (buffer-name buffer) name))))
;; 	 (buffer-list))))

;============
 ;; add a buffer modification state indicator in the tab label,
 ;; and place a space around the label to make it looks less crowd
(defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
  (setq ad-return-value
	(if (and (buffer-modified-p (tabbar-tab-value tab))
		 (buffer-file-name (tabbar-tab-value tab)))
	    (concat "+" (concat ad-return-value ""))
	  (concat "" (concat ad-return-value "")))))

 ;; called each time the modification state of the buffer changed
(defun ztl-modification-state-change ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))
 ;; first-change-hook is called BEFORE the change is made
(defun ztl-on-buffer-modification ()
  (set-buffer-modified-p t)
  (ztl-modification-state-change))
(add-hook 'after-save-hook 'ztl-modification-state-change)
 ;; this doesn't work for revert, I don't know
 ;;(add-hook 'after-revert-hook 'ztl-modification-state-change)
;(add-hook 'first-change-hook 'ztl-on-buffer-modification)

;;tabbar keybinding
;(global-set-key (kbd "C-<up>") 'tabbar-backward-tab)
;(global-set-key (kbd "C-<prior>") 'tabbar-backward-tab)
(global-set-key (kbd "M-p") 'tabbar-backward-tab)
(global-set-key (kbd "M-n") 'tabbar-forward-tab)
;(global-set-key (kbd "C-<next>") 'tabbar-forward-tab)
;(global-set-key (kbd "C-c bb") 'tabbar-backward-tab)
;(global-set-key (kbd "C-c ff") 'tabbar-forward-tab)

;(global-set-key (kbd "C-c <left>") 'tabbar-backward-tab)
;(global-set-key (kbd "C-c <right>") 'tabbar-forward-tab)

