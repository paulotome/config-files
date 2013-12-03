;; http://homepages.inf.ed.ac.uk/s0243221/emacs/
;; ========== Enable Line and Column Numbering ==========

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

(setq mouse-wheel-progressive-speed nil)

(setq-default show-trailing-whitespace t)

;; Go to emacs reference manual main page
(defun go-to-emacs-ref-manual-definition ()
  (interactive)
  (browse-url (format "file:///y:/emacs/paulo-extras/elisp.html#Index")))


(defun go-to-acl-8.0-toc-definition ()
  (interactive)
  (browse-url (format "%s/AllegroCL8.0/doc/contents.htm" *lisp-doc-home*)))


(define-key  menu-bar-lisp-doc-menu [font6] '("Emacs Reference Manual" . go-to-emacs-ref-manual-definition))


(define-key  menu-bar-lisp-doc-menu [font7] '("Allegro CL 8.0 Toc" . go-to-acl-8.0-toc-definition))


;; Maximize Emacs window
(w32-send-sys-command ?\xf030)
;;(w32-send-sys-command #xf030)

;;; Quick expression selection with control return
(defun select-current-sexp ()
  (interactive)
  (when (and (not (char-equal (char-after) ?\())
	     (char-equal (char-before) ?\)))
    (backward-char)
    (backward-up-list))
  (when mark-active
    (backward-up-list))
  (mark-sexp 1))

(global-set-key [(ctrl return)] 'select-current-sexp)

(global-set-key [f11] 'reposition-defun-at-top)

(global-set-key [f12] 'revert-buffer)

(fset 'yes-or-no-p 'y-or-n-p)           ;replace y-e-s by y
(setq inhibit-startup-message t)        ;no splash screen
;;(defconst use-backup-dir t)             ;use backup directory
(defconst query-replace-highlight t)    ;highlight during query
(defconst search-highlight t)           ;highlight incremental search
(setq ls-lisp-dirs-first t)             ;display dirs first in dired
(global-font-lock-mode t)               ;colorize all buffers
;;(setq ecb-tip-of-the-day nil)           ;turn off ECB tips
(recentf-mode 1)                        ;recently edited files in menu


(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.dic\\'" . lisp-mode))

(defun list-tree (path)
  (labels ((n-spaces (n)
             (if (<= n 0) "" (format " %s" (n-spaces (1- n)))))
           (extend-path (path item)
             (expand-file-name (format "%s/%s" path item)))
           (list-tree-recursively (path rec-level)
             (let* ((items (remove-if '(lambda (item) (or (string= item ".") (string= item ".."))) (directory-files path)))
                    (directory-items (remove-if-not '(lambda (item) (file-directory-p (extend-path path item))) items))
                    (file-items (remove-if '(lambda (item) (file-directory-p (extend-path path item))) items)))
               (dolist (subdir directory-items)
                 (princ (format "%s%s\n" (n-spaces rec-level) subdir))
                 (list-tree-recursively (extend-path path subdir) (+ rec-level 5)))
               (dolist (file file-items)
                 (princ (format "%s%s\n" (n-spaces rec-level) file))))))
    (with-output-to-temp-buffer (format "Tree for '%s'" path)
      (princ (format "%s\n" path))
      (list-tree-recursively path 5))))

					;(list-tree "K://users//paulo//lul//db029icrw//lul010database//dataset-files-NOR-1")


;;;(defun make-backup-file-name (filename)
;;;  (concat filename (format-time-string "_%Y%m%d_%H%M%S.bak" (fifth (file-attributes filename)))))

;;;-----------------------------------------------------------------------------
;;;
;;;-----------------------------------------------------------------------------

(global-set-key [C-down] 'search-mod-date-forward)
(global-set-key [C-up] 'search-mod-date-backward)

;;; Search forward modification date.
(defun search-mod-date-forward ()
  (interactive)
  (if (search-forward *default-mod-date* nil t)
      (forward-line 2)
      (message "Modification date %s not found forward in buffer." *default-mod-date*)))


;;; Search backward modification date.
(defun search-mod-date-backward ()
  (interactive)
  (unless (search-backward *default-mod-date* nil t)
    (message "Modification date %s not found backward in buffer." *default-mod-date*)))


;;;-----------------------------------------------------------------------------
;;;
;;;-----------------------------------------------------------------------------

;; Emacs Server Mode
(server-mode)

;;Desactivar tooltips no emacs 23 é só avaliar a expressão:

(tooltip-mode 0)

;;Quem não quiser a toolbar, que só rouba espaço, também pode utilizar:

;;(tool-bar-mode 0)
(tool-bar-mode -1)




(put 'with.mandatory.translations 'fi:lisp-indent-hook '(like dolist))
(put 'within.data.node 'fi:lisp-indent-hook '(like dolist))
(put 'with.intersecting.freq.train.frequency 'fi:lisp-indent-hook '(like when))
(put 'with.file.locked 'fi:lisp-indent-hook '(like dolist))
(put 'saving.resource 'fi:lisp-indent-hook '(like dolist))
(put 'updating.resource 'fi:lisp-indent-hook '(like dolist))
(put 'with.initial.import.delivery.options 'fi:lisp-indent-hook '(like dolist))
(put 'with.reader.errors 'fi:lisp-indent-hook '(like dolist))
(put 'with.service.events 'fi:lisp-indent-hook '(like dolist))
(put 'with.collecting.messages 'fi:lisp-indent-hook '(like dolist))
(put 'with.fbinds 'fi:lisp-indent-hook '(like when))
(put 'with.partition 'fi:lisp-indent-hook '(like when))
(put 'with.progress.actions 'fi:lisp-indent-hook '(like when))
(put 'with.state.tree 'fi:lisp-indent-hook '(like when))
(put 'with.sand.glass 'fi:lisp-indent-hook '(like let))
(put 'with.limited.comparing.items 'fi:lisp-indent-hook '(like when))
(put 'with.calendar.context 'fi:lisp-indent-hook '(like when))
(put 'do.tuples 'fi:lisp-indent-hook '(like when))
(put 'sg-with-open-cursors 'fi:lisp-indent-hook '(like let))
(put 'collecting 'fi:lisp-indent-hook '(like let))
(put 'do.resources 'fi:lisp-indent-hook '(like when))
(put 'once.only 'fi:lisp-indent-hook '(like when))

;;; (put ' 'fi:lisp-indent-hook '(like when))

;; ******************************************************
;; *                    EMACS - SLIME           	*
;; ******************************************************

;;; auto-complete
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/paulo/")
(require 'auto-complete-config)
(ac-config-default)

;;; auto-complete slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
		 '(add-to-list 'ac-modes 'slime-repl-mode))


;; How to customize Emacs split-window-X with the new window showing the next buffer?
;; Código que funciona para C-x 2 e C-x 3.

(defun split-window-and-next-buffer (new-window)
  (let ((old-window (selected-window)))
    (select-window new-window)
    (next-buffer)
    (select-window old-window)
    new-window))

(defadvice split-window-right (after split-window-right-and-next-buffer
				     activate protect compile)
  (split-window-and-next-buffer ad-return-value))

(defadvice split-window-below (after split-window-bellow-and-next-buffer
				     activate protect compile)
  (split-window-and-next-buffer ad-return-value))

;; To remove he advices, call the functions until they return nil.
;;(ad-unadvise 'split-window-below)
;;(ad-unadvise 'split-window-right)



(require 'org-latex)
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))

;;; PAREDIT ;;;

;;;(autoload 'enable-paredit-mode "paredit.el" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)

(add-hook 'ielm-mode-hook             #'enable-paredit-mode)

;;;(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook (lambda () (paredit-mode 1)))

;;;(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode 1)))


(add-hook 'scheme-mode-hook           #'enable-paredit-mode)





;;;(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\"
  return.")


(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then
  open and indent an empty line between the cursor and the text.  Move the
  cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
	(save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))



(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (paredit-mode t)
	    (turn-on-eldoc-mode)
	    (eldoc-add-command
	     'paredit-backward-delete
	     'paredit-close-round)
	    (local-set-key (kbd "RET") 'electrify-return-if-match)
	    (eldoc-add-command 'electrify-return-if-match)
	    (show-paren-mode t)))

;;;(require 'eldoc) ; if not already loaded
;;;(eldoc-add-command
;;; 'paredit-backward-delete
;;; 'paredit-close-round)


;;; (add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
      (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)


;; Using local-set-key in a mode-hook is a better idea.
;;;(global-set-key (kbd "RET") 'electrify-return-if-match)
