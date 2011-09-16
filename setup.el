(setq org-confirm-babel-evaluate nil)
(defvar *dss-slides-current-file* nil)

(setq *dss-slides-current-file* "~/r_users_group_3/README.org")

(setq *dss-slides-current-file* "~/r_users_group_3/exercises.org")

(defun dss/slides-hide-screen-caption ()
  (interactive)
  (dss/screen-command "_2" (list "caption" "splitonly"))
  (dss/screen-command "_2" "fit"))

(defun dss/slides-restore-screen-caption ()
  (interactive)
  (dss/screen-command
   "_2" (list
         "caption" "always"
         "%{= kw}%-w%{= KW}%n %t%{-}%+w %= %?%P%{.rw}P%:%?"))
  (dss/screen-command "_2" "fit"))

(defun dss/slides-prev ()
  (interactive)
  (find-file *dss-slides-current-file*)
  (widen)
  (delete-other-windows)
  (call-interactively 'outline-previous-visible-heading)
  (org-show-entry)
  (org-narrow-to-subtree)
  (org-hide-block-all))

(defun dss/slides-next ()
  (interactive)
  (find-file *dss-slides-current-file*)
  (widen)
  (delete-other-windows)
  (call-interactively 'outline-next-visible-heading)
  (org-show-entry)
  (org-narrow-to-subtree)
  (org-hide-block-all))

(defun dss/slides-show-next-src-block ()
  (interactive)
  (forward-char 2)
  (search-forward "#+begin_src")
  (call-interactively 'org-hide-block-toggle)
  (beginning-of-line))

(defun dss/slides-exec-next-src-block ()
  (interactive)

  ;; (search-forward "#+begin_src")
  (call-interactively 'org-babel-execute-src-block))

(defun dss/slides-open-next-link ()
  (interactive)
  (find-file *dss-slides-current-file*)
  (org-next-link)
  (sit-for 0.5)
  (org-open-at-point))

(defun dss/slides-setup-keymap ()
  (interactive)
  (define-key f4-map [(f3)] 'dss/slides-prev)
  (define-key f4-map [(f4)] 'dss/slides-next)

  ;; (define-key f4-map [(f2)] 'dss/slides-open-next-link)
  ;; (define-key f4-map [(f2)] 'org-hide-block-toggle)
  (define-key f4-map [(f2)] 'dss/slides-show-next-src-block)
  (define-key f4-map [(f5)] 'dss/slides-exec-next-src-block)
  )
;; .help.ESS <- help
;; options(STERM='iESS', editor='emacsclient')
