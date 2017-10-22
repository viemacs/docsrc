;;;; User Information

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq user-full-name "viemacs")
(setq user-mail-address "emacguo_gmail.com")

;;;; save and semantic directories
;; create '.saves' and '.semanticdb' at ~

;;;; ---- Basic Configuration ----

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(blink-cursor-mode t)
 '(column-number-mode t)
 '(custom-enabled-themes nil)
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(show-paren-mode t))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'paganini t)

(setq display-time-24hr-format t)

  ; close startup screen
(setq visible-bell t)                               ; close error report bell

(server-start)                                      ; start Emacs Server
;(setq ispell-dictionary "german")

;; close auto-start network-connection programs/functions
;; this is needed when working without network connection
(defvar startup-connect-network nil
  "Whether connect netowrk when startup Emacs.")

;; scroll pages more smoothly, not scroll full page
;(setq scroll-step 1
;      scroll-margin 3
;      scroll-conservatively 10000)
;(mouse-wheel-mode t) ; enable wheel-mouse scrolling

(mouse-avoidance-mode 'animate)     ; move mouse away when cursor is close
(blink-cursor-mode nil)             ; cursor blink off
;(setq-default cursor-type 'bar)    ; verticle bar, not block
;(set-scroll-bar-mode 'right)       ; set scroll bar at the right side
;(set-background-color "black")     ; set colors

;(tool-bar-mode -1)                 ; do not show tool bar
(menu-bar-mode -1)                  ; do not show menu
(column-number-mode t)              ; show column number in mode bar
(line-number-mode t)                ; show line number in mode bar
(display-time-mode t)               ; display time

(setq x-select-enable-clipboard t)  ; supports external clipboard paste
;(setq kill-ring-max 200)           ; set kill-ring-max to 200
;(fset 'yes-or-no-p 'y-or-n-p)      ; use y/n instead of yes/no

;; show line number in buffer at the left side
(dolist (hook (list
               'c-mode-hook
               'c++-mode-hook
               'emacs-lisp-mode-hook
               'lisp-interaction-mode-hook
               'lisp-mode-hook
               'emms-playlist-mode-hook
               'java-mode-hook
               'asm-mode-hook
               'haskell-mode-hook
               'rcirc-mode-hook
               'emms-lyrics-mode-hook
               'erc-mode-hook
               'sh-mode-hook
               'makefile-gmake-mode-hook
               'org-mode-hook))
(add-hook hook (lambda() (linum-mode 1))) )

(show-paren-mode t)                  ; show matched braces
(setq show-paren-style 'parentheses)

;(require 'hl-line)                  ; highlight current line
;(global-hl-line-mode t)

(setq frame-title-format "%b@emacs") ; show name of buffer on title bar

;; maximize (X window)
;(defun my-maximized ()
;       (interactive)
;       (x-send-client-message
;        nil 0 nil "_NET_WM_STATE" 32
;        '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;       (x-send-client-message
;        nil 0 nil "_NET_WM_STATE" 32
;        '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0)) )
;
;(my-maximized)      ; maximize on startup

;; set backup-configuration
;(make-directory "~/.emacs.d/saves/" t)
;(custom-set-variables
;  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t))))
;(make-directory "~/.emacs.d/autosaves/" t)
(setq make-backup-files t)      ; enable backup function
(setq vc-make-backup-files t)   ; enable backup function with Version Control
(setq version-control t)        ; enable version control, multiple backups
(setq kept-old-versions 2)      ; 2 old version backups before 2 editing
(setq kept-new-versions 6)      ; 6 new version backups during editing
(setq delete-old-versions t)    ; delete the other old backup versions
(setq backup-directory-alist '(("." . "~/.emacs.d/saves")))  ; backup at ~/.saves
(setq backup-by-copying t)      ; backup method: copy directly
(setq backup-enable-predicate 'ecm-backup-enable-predicate)  ; backup-condition

;; disable backup function for the following directories and files
(defun ecm-backup-enable-predicate (filename)
  (and (not (string= "/tmp/" (substring filename 0 5)))
       (not (string-match "semanticdb" filename))) )

(setq auto-save-mode nil)           ; close autosave mode
(setq auto-save-default nil)        ; do not generate #filename# temporary file

;; use minibuffer recursively
;(setq enable-recursive-minibuffers t)
(setq max-mini-window-height 1)

(setq-default kill-whole-line t); C-k kills whole line at the beginning of line
(setq require-final-newline t)  ; auto-add a new line at the tail of file
(setq track-eol t)      ; when cursor move vertically at eol, keep it at eol
(setq Man-notify-method 'pushy) ; jump to man buffer when browse man page
;(setq suggest-key-bindings 1)  ; show key-binding of an M-x COMMAND in 1 second


;;;; ---- Global Shorcuts ----

(global-set-key (kbd "<f1>") 'list-bookmarks)   ; F1: list my bookmarks
(global-set-key [C-f1] 'bookmark-set)           ; Ctrl-F1: set my bookmarks
(global-set-key (kbd "<f2>") 'save-buffer)      ; F2: save buffer
(global-set-key [C-f2] 'desktop-save)           ; Ctrl-F2: save current desktop
(global-set-key (kbd "<f3>") 'jump-to-register) ; F3: jump to place in register
(global-set-key [C-f3] 'point-to-register)      ; Ctrl-F3: save current position
                                                ;          of cursor to register

(global-set-key [(f4)] 'speedbar-get-focus)     ; F4: enable speedbar
(global-set-key [(f5)] 'delete-other-windows)   ; F5: maximize current buffer
(global-set-key [(f6)] 'kill-buffer-and-window) ; F6: close buffer

(global-set-key [f7] 'compile)                  ; F7: compile
(global-set-key [C-f7] 'gdb)                    ; Ctrl-F7: debug
(setq-default compile-command "make")
(global-set-key [f8] 'next-error)
(global-set-key [C-f8] 'previous-error)

(global-set-key [f9] 'c-indent-line-or-region)  ; F9: format codes
(global-set-key [f10] 'comment-or-uncomment-region)  ; F10: comment / un-comment
(global-set-key [(f11)] 'insert-register)       ; copy
(global-set-key [C-f11] 'copy-to-register)      ; paste
(global-set-key [f12] 'ecb-activate)            ; F12: activate ecb
(global-set-key [C-f12] 'ecb-deactivate)        ; Ctrl-F12: deactiveate ecb

;; navigation ;; some configurations are troublesome
(global-set-key [(meta g)] 'goto-line)          ; goto line-number
(global-set-key [(tab)] 'my-indent-or-complete) ; Tab indent or complete
;(global-set-key [(control tab)] 'other-window) ; C-x o

(global-set-key [(meta left)] 'tabbar-backward) ; switch to previous tab
(global-set-key [(meta right)] 'tabbar-forward) ; switch to next tab
(global-set-key [(meta up)] 'tabbar-backward-group)
(global-set-key [(meta down)] 'tabbar-forward-group)

(global-set-key (kbd "C-x b") 'ibuffer)         ; open ibuffer
(global-set-key (kbd "C-x v") 'browse-kill-ring); open browse-kill-ring


(global-set-key (kbd "C-x c") 'copy-lines)      ; copy line(s)
(global-set-key (kbd "C-x d") 'zl-delete-line)  ; delete a line
(global-set-key (kbd "C-x a") 'kill-match-paren); delete content between ()
;; delete content between parentheses
(defun kill-match-paren (arg)
    (interactive "p")
    (cond ((looking-at "[([{]") (kill-sexp 1) (backward-char))
          ((looking-at "[])}]") (forward-char) (backward-kill-sexp 1))
          (t (self-insert-command (or arg 1)))) )
;; delete a line
(defun zl-delete-line nil "delete the whole line"
    (interactive)
    (beginning-of-line)             ; cursor to bol(beginning of line)
    (push-mark)                     ; mark
    (beginning-of-line 2)           ; cursor to bol of next line
    (kill-region (point) (mark)))   ; delete content between cursor and mark
;; copy line(s) ; C-c C-w copy?
(defun copy-lines(&optional arg)
    (interactive "p")
    (save-excursion
        (beginning-of-line)
        (set-mark (point))
        (next-line arg)
        (kill-ring-save (mark) (point))) )


;;;; ---- Programming ----
;; --languages supporting--
;(setq indent-tabs-mode t) 
(setq default-tab-width 4) 
(setq tab-width 4) 
(setq tab-stop-list ()) 
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96)) 
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
;(setq-default indent-tabs-mode t)
;(setq indent-tabs-mode t)
;;;(setq tab-width 4)

;;(setq c-basic-offset 8)

;; golang
(add-to-list 'load-path "~/.emacs.d/modes/")
(require 'go-mode-autoloads)
;; jsx
(setq auto-mode-alist (cons '("\.jsx$" . js-jsx-mode) auto-mode-alist))
(autoload 'jx-jsx-mode "jx-jsx-mode" "jsx editing mode." t)
;; lua
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;; php
(autoload 'php-mode "php-mode.el" "Php mode." t)
(setq auto-mode-alist (append '(("/*.\.php[345]?$" . php-mode)) auto-mode-alist))
;; python
(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
;; pkgbuild
(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode)) auto-mode-alist))
;; javascript
;; jade and sws
;(add-to-list 'load-path "~/.emacs.d/modes/jade-mode")
;(add-to-list 'load-path "~/.emacs.d/modes/sws-mode")
;(require 'sws-mode)
;(require 'jade-mode)
(add-to-list 'load-path "~/.emacs.d/modes/")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
;(add-to-list 'auto-mode-alist '("\\.styl\\'" . sws-mode))
;; emms (The Emacs Multimedia System)
;(require 'emms-setup)
;(emms-standard)
;(emms-default-players)
;; haskell-mode
(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-mode.el")
;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;(add-hook 'haskell-mode-hook 'turn-on-font-lock-mode)

;(autoload 'haskell-mode "haskell-mode.el" t)
(setq auto-mode-alist (append '(("/*.\.hs$" . haskell-mode)) auto-mode-alist))

(when (eq t haskell-mode-hook)
  (message "WTF"))


;; code fold and unfold
;(add-hook 'c-mode-hook 'hs-minor-mode)
;(add-hook 'c++-mode-hook 'hs-minor-mode)

;; CC-mode configuration ; http://cc-mode.sourceforge.net/
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)
(setq c-basic-offset 4)

;; define C/C++ style
(add-hook 'c-mode-hook 'my-c-cpp-mode)
(add-hook 'c++-mode-hook 'my-c-cpp-mode)
(defun my-c-cpp-mode()
    ;(linum-mode 1)
    (define-key c-mode-map [return] 'newline-and-indent) ; Enter instead of C-j
    (interactive)
    (define-key c++-mode-map [return] 'newline-and-indent)
    (interactive)
;    (c-set-style "K&R")                 ; set indent style of code
;    (c-set-style "K&R")                 ; set indent style of code
    (which-function-mode)               ; show current function on mode-line
;   (c-toggle-auto-state)               ; auto-mode, indent when { is inputted
                                        ; following the setted style
                                        ; auto-newline after ';'
    (c-toggle-hungry-state)             ; Backspace key deletes ' *' (regexp)
    (c-set-offset 'arglist-intro '+)    ; using normal indent for a long method name with long arguments
    (c-set-offset 'multi-inher '+)    ; using normal indent for a long method name with long arguments
;    (setq c-basic-offset 8)             ; auto indent width: 8
;   (setq c-indent-level 8)
   (setq-default indent-tabs-mode nil) ; use space instead of tab
;   (setq-default indent-tabs-mode t) ; use space instead of tab

    ;; Alt-Return smart complete
    (define-key c-mode-base-map [M-return] 'semantic-ia-complete-symbol-menu) )

(setq c-basic-offset 4)
(c-set-offset 'substatement-open 0)
(c-set-offset 'arglist-intro '+)
(c-set-offset 'arglist-cont-nonempty '+)
(c-set-offset 'statement-case-intro '+)
(c-set-offset 'case-label 0)
(c-set-offset 'statement-case-open 0)

;; (setq-default c-indent-tabs-mode t     ; Pressing TAB should cause indentation
;; 			  c-indent-level 4         ; A TAB is equivilent to four spaces
;; 			  c-argdecl-indent 0       ; Do not indent argument decl's extra
;; 			  c-tab-always-indent t
;; 			  backward-delete-function nil) ; DO NOT expand tabs when deleting
;; (c-add-style "my-c-style" '((c-continued-statement-offset 4))) ; If a statement continues on the next line, indent the continuation by 4

;; (defun my-c-mode-hook ()
;;   (c-set-style "my-c-style")
;;   (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
;;   (c-set-offset 'inline-open '+)
;;   (c-set-offset 'block-open '+)
;;   (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
;;   (c-set-offset 'case-label '+))       ; indent case labels by c-indent-level, too
;; (add-hook 'c-mode-hook 'my-c-mode-hook)
;; (add-hook 'c++-mode-hook 'my-c-mode-hook)

;;======= Code folding =======
;; emacs-python-mode
(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
;;
(add-hook 'python-mode-hook 'my-python-outline-hook)
; this gets called by outline to deteremine the level. Just use the length of the whitespace
(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "    ")
      (current-column))))
; this get called after python mode is enabled
(defun my-python-outline-hook ()
  ; outline uses this regexp to find headers. I match lines with no indent and indented "class"
  ; and "def" lines.
  (setq outline-regexp "[^ \t]\\|[ \t]*\\(def\\|class\\) ")
  ; enable our level computation
  (setq outline-level 'py-outline-level)
  ; do not use their \C-c@ prefix, too hard to type. Note this overides some bindings.
  (setq outline-minor-mode-prefix "\C-t")
  ; turn on outline mode
  (outline-minor-mode t)
  ; initially hide all but the headers
  ;(hide-body)
  ; make paren matches visible
  (show-paren-mode 1)
)

;; CC-mode configuration ; http://cc-mode.sourceforge.net/
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

;;(setq c-basic-offset 8)


;;;; ---- Auto-Complete ----

;; define hippie-expand indent-complete function
(defun my-indent-or-complete()
    (interactive)
    (if (looking-at "\\>")
        (hippie-expand nil)
    (indent-for-tab-command)) )

;; hippie-expand auto-complete strategy
(setq hippie-expand-try-functions-list
      '(
        senator-try-expand-semantic     ; senator's analysis result comes first
        try-expand-dabbrev-visible      ; dabbrev, visible buffer first
        try-expand-dabbrev              ; dabbrev (strategy)
        try-expand-dabbrev-all-buffers  ; dabbrev, {all buffer\current one}
        try-expand-dabbrev-from-kill    ; dabbrev, search from deleted records
        try-complete-file-name          ;
        try-complete-file-name-partially; matching-first
        try-expand-list                 ;
        try-expand-list-all-buffers     ; {all buffers\current one}
        try-expand-line                 ; expand the whole line
        try-expand-line-all-buffers     ; {all buffers\current one}
        try-complete-lisp-symbol        ; low priority for effectiveness
                                        ; because there're too many symbols 
        try-complete-lisp-symbol-partially
        try-expand-whole-kill) )


;;;; ---- set semantic, code analysis, ia-complete ----

;; set semantic.cache path
(setq semanticdb-default-save-directory (expand-file-name "~/.semanticdb"))
;; set index region of Semantic
(setq semanticdb-project-roots (list (expand-file-name "/")))
;; call analysis result of senator first
(autoload 'senator-try-expand-semantic "senator")
;; complete-analysis during idle
;(add-hook 'semantic-init-hooks 'semantic-idle-completions-mode)
;; control cpu load of semantic
;(setq-default semantic-idle-scheduler-idle-time 432000);

;;;;;;;;;;;;;;;;;
;; not working ;;
;;;;;;;;;;;;;;;;;
;;; auto-load semantic index database of /usr/include when starting C/C++
;(setq semanticdb-search-system-databases t)
;(add-hook 'c-mode-common-hook
;    (lambda()
;        (setq semanticdb-project-system-databases
;             (list (semanticdb-create-database
;                    semanticdb-new-database-class
;                    "/usr/include")))) )
;(add-hook 'c++-mode-common-hook
;    (lambda()
;        (setq semanticdb-project-system-databases
;             (list (semanticdb-create-database
;                    semanticdb-new-database-class
;                    "/usr/include")))) )


;;;; ---- External Extention ----
;; packages needed: semantic, speedbar, eieio, cedet, cscope, ecb
;; packages needed: cbrowser

;; configure semantic
;(semantic-load-enable-code-helpers)

;; configure speedbar
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
(setq speedbar-show-unknown-files t); show all directories and files
(setq dframe-update-speed nil)      ; do not auto refresh, manual refresh by 'g'
(setq speedbar-update-flag nil)
(setq speedbar-use-images nil)      ; do not use image mode
(setq speedbar-verbosity-level 1)

;; inhibit tags grouping and sorting
(setq speedbar-tag-hierarchy-method '(speedbar-simple-group-tag-hierarchy) )

;; configure ecb
(setq ecb-tip-of-the-day nil)
(setq ecb-tree-indent 4)
(setq ecb-windows-height 0.5)
(setq ecb-windows-width 0.20)
(setq ecb-auto-compatibility-check nil)
(setq ecb-version-check nil)

;; configure cscope
;(require 'xcscope)
;; do not auto update cscope.out
;(setq cscope-do-not-update-database t)


;; package needed: emacs-goodies-el ;'Miscellaneous add-ons for Emacs'
;; contain: session, tabbar,browse-kill-ring

;; configure session and Desktop
;(require 'session)
;(add-hook 'after-init-hook 'session-initialize)
;; M-x desktop-save: save session
;; M-x desktop-clear: clear up the last saved session
;(load "desktop")
;(desktop-load-default)
;(desktop-read)

;; configure tabbar
;(require 'tabbar)
;(tabbar-mode t)

;; configure browse-kill-ring
;(require 'browse-kill-ring)
;(browse-kill-ring-default-keybindings)

;; doxymacs
;(require 'doxymacs)
;(add-hook 'c-mode-common-hook 'doxymacs-mode)
;(defun my-doxymacs-font-lock-hook ()
;    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;        (doxymacs-font-lock)) )
;(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;;;; END
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
