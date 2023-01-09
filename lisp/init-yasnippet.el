;;; init-yasnippet.el --- Git SCM support -*- lexical-binding: t -*-
;;; Commentary:

;; See also init-github.el.

;;; Code:

;; TODO: link commits from vc-log to magit-show-commit
;; TODO: smerge-mode
(require-package 'use-package)

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))


(use-package autoinsert
  :init
  ;; Don't want to be prompted before insertion:
  (setq auto-insert-query nil)

  (setq auto-insert-directory (locate-user-emacs-file "templates"))
  (add-hook 'find-file-hook 'auto-insert)
  (auto-insert-mode 1)

  :config
  (define-auto-insert "\\.html?$" "default-html.html")
  (define-auto-insert "\\.org?$" "default-org.org")
  (define-auto-insert "\\.md?$" "default-md.md")
  (define-auto-insert "\\.el?$" "default-lisp.el")
  )

(yas-expand-snippet ";; Bah-da $1 Bing")
                                        ; 辅组函数,这个辅组函数将auto-insert自动插入新文件的内容作为模板来进行扩展.
(defun autoinsert-yas-expand()
  "Replace text in yasnippet template."
  (yas-expand-snippet (buffer-string) (point-min) (point-max)))

(use-package autoinsert
  :config
  (define-auto-insert "\\.el$" ["default-lisp.el" ha/autoinsert-yas-expand])
  (define-auto-insert "\\.sh$" ["default-sh.sh" ha/autoinsert-yas-expand])
  (define-auto-insert "/bin/"  ["default-sh.sh" ha/autoinsert-yas-expand])
  (define-auto-insert "\\.html?$" ["default-html.html" ha/autoinsert-yas-expand]))

(yas-expand-snippet "`user-full-name`")
(yas-expand-snippet "`(buffer-file-name)`")

                                        ; 日志
(setq org-journal-date-format "#+TITLE: Journal Entry- %e %B %Y")
(defun journal-title ()
  "The journal heading based on the file's name."
  (interactive)
  (let* ((year  (string-to-number (substring (buffer-name) 0 4)))
         (month (string-to-number (substring (buffer-name) 4 6)))
         (day   (string-to-number (substring (buffer-name) 6 8)))
         (datim (encode-time 0 0 0 day month year)))
    (format-time-string org-journal-date-format datim)))

(provide 'init-yasnippe)
;;; init-git.el ends here
