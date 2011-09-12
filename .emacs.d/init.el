; テーマの変更
(add-to-list 'load-path "~/.emacs.d/lisp/theme")
(require 'color-theme)
(require 'zenburn)
(eval-after-load "color-theme"
  '(progn
    (color-theme-initialize)
     (color-theme-zenburn)))
; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)
; 対応する括弧のハイライト
(show-paren-mode t)
; メニューバーを消す
(menu-bar-mode nil)
; 言語を日本語にする
(set-language-environment 'Japanese)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)
; C-z でウィンドウ移動
(define-key global-map "\C-z" 'other-window)
; shiftと矢印キーでウィンドウ移動が出来る
(windmove-default-keybindings)
(global-set-key (kbd "<select>") (quote windmove-up))
; cua-modeをonにする
(cua-mode t)
(setq cua-enable-cua-keys nil) ; C-cやC-vの乗っ取りを阻止
(global-set-key (kbd "M-RET") 'cua-set-rectangle-mark)
; 選択範囲に色をつける。
(setq transient-mark-mode t)
; コメントに色を付けるようにする
(set-face-foreground 'font-lock-comment-face "#7f9f7f")
(set-face-foreground 'font-lock-comment-delimiter-face "#7f9f7f")
; 初期メッセージを表示させない
(setq inhibit-startup-message t)
; スクロール時に現在のカーソルのポイント位置を保つ
(setq scroll-preserve-screen-position t)
; スクロール時に下に何画面分残るか
(setq next-screen-context-lines 5)
; カーソル移動時に一行ずつスクロールする
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
; 一行スクロール機能の割り当て
(defun scroll-up-one-line   () (interactive) (scroll-up   1))
(defun scroll-down-one-line () (interactive) (scroll-down 1))
(global-set-key "\M-j" 'scroll-up-one-line)
(global-set-key "\M-k" 'scroll-down-one-line)
; 何か
(setq comint-scroll-show-maximum-output t)
; タブサイズ
(setq-default tab-width 2 indent-tabs-mode nil)
;(setq-default tab-width 2)
;(setq tab-width 2)
; c-h と del を入れ替え
(keyboard-translate ?\C-h ?\C-?)  ; translate `C-h' to DEL
(keyboard-translate ?\C-? ?\C-h)  ; translate DEL to `C-h'.
; C-kで行全体を削除
(setq kill-whole-line t)
; C-w or M-w 二回でクリップボード
(defvar clipboard-register ?@)
(defadvice kill-region (before clipboard-cut activate)
  (when (eq last-command this-command)
    (set-register clipboard-register (car kill-ring))
    (message "Copy to clipboard")))
(defadvice kill-ring-save (before clipboard-copy activate)
  (when (eq last-command this-command)
    (set-register clipboard-register (car kill-ring))
    (message "Copy to clipboard")))
; C-M-y でクリップボード貼り付け
(defun clipboard-paste ()
  (interactive)
  (insert-register clipboard-register)
  (message "Paste from clipboard"))
(global-set-key (kbd "C-M-y") 'clipboard-paste)
; M-Y で一行コピー
(defun duplicate-line (&optional numlines)
  "One line is duplicated wherever there is a cursor."
  (interactive "p")
  (let* ((col (current-column))
         (bol (progn (beginning-of-line) (point)))
         (eol (progn (end-of-line) (point)))
         (line (buffer-substring bol eol)))
    (while (> numlines 0)
      (insert "\n" line)
      (setq numlines (- numlines 1)))
    (move-to-column col)))
(define-key esc-map "Y" 'duplicate-line)
; M-f で単語の先頭まで移動する
(defun forward-word+1 ()
  "forward-word で単語の先頭へ移動する"
  (interactive)
  (forward-word)
  (forward-char))
(global-set-key (kbd "M-f") 'forward-word+1)
(global-set-key (kbd "C-M-f") 'forward-word+1)
; M-d で単語の先頭まで削除する
(defun kill-word+1 ()
  "kill-word の後のポイントが単語の先頭になるようにする"
  (interactive)
  (kill-word 1)
  (delete-char 1))
(global-set-key (kbd "M-d") 'kill-word+1)
(global-set-key (kbd "C-M-d") 'kill-word+1)
; 汎用のスクリプト格納場所にパスを通す
(add-to-list 'load-path "~/.emacs.d/lisp")
; undo-tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))
; scala-mode
(add-to-list 'load-path "~/.emacs.d/lisp/scala-mode")
(require 'scala-mode-auto)
; scala-mode 時に自動的に括弧を挿入する
;(require 'scala-mode-feature-electric)
;(add-hook 'scala-mode-hook
;          (lambda ()
;            (scala-electric-mode)))
; scala-mode 時のIDE
;add-to-list 'load-path "~/.emacs.d/lisp/ensime/elisp/")
;require 'ensime)
;add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)
; Rinari
(add-to-list 'load-path "~/.emacs.d/lisp/rinari")
(require 'rinari)
; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/lisp/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda () (rinari-launch)))
;; yasnippet(auto-complete と yasnippet が 上手く動かないので一旦 yasnippetを切る)
;(setq load-path (cons (expand-file-name "~/.emacs.d/lisp/yasnippet") load-path))
;(require 'yasnippet)
;(yas/initialize)
;(yas/load-directory "~/.emacs.d/lisp/yasnippet")
;; rails-yasnippet
;(yas/load-directory "~/.emacs.d/lisp/yasnippets-rails/rails-snippets")
; auto-complate
(add-to-list 'load-path "~/.emacs.d/lisp/acp")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/acp/ac-dict")
(ac-config-default)
(ac-set-trigger-key "TAB")
; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                         (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)
(put 'upcase-region 'disabled nil)
