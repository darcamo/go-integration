;;; go-integration-project-mode.el --- Automatically detect when in a Go project  -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Darlan Cavalcante Moreira

;; Author: Darlan Cavalcante Moreira <darcamo@gmail.com>

;; SPDX-License-Identifier: GPL-3.0-or-later

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides a minor mode that has no functionality beyond having a key-map for
;; go-integration related commands and running hooks

;;; Code:
(require 'project)

(defvar gi-project-mode-map (make-sparse-keymap)
  "Keymap for `go-integration-project-mode'.")


;;;###autoload (autoload 'go-integration-is-go-project-p "go-integration" nil t)
(defun gi-is-go-project-p ()
  "Check if the current project is a CMake project."
  (interactive)
  (if-let* ((project (project-current))
            (project-root (project-root project))
            (cmakelist-path (expand-file-name "go.mod" project-root)))
      (file-exists-p cmakelist-path)))



;;;###autoload (autoload 'go-integration-project-mode "go-integration" nil t)
(define-minor-mode gi-project-mode
  "A minor-mode for Go projects.

This minor-mode does not add any functionality, but it can be used to
add keybindings to compile/run Go code and also running anything in its hook."
  :keymap gi-project-mode-map)


(defun gi--turn-on-project-mode-func ()
  "Turn on `go-integration-project-mode' in Go projects."
  (when (gi-is-go-project-p)
    (gi-project-mode 1)))


;;;###autoload (autoload 'global-go-integration-project-mode "go-integration" nil t)
(define-globalized-minor-mode global-go-integration-project-mode
  go-integration-project-mode
  go-integration--turn-on-project-mode-func
  :group 'go-project)


(provide 'go-integration-project-mode)
;;; go-integration-project-mode.el ends here


;; Local Variables:
;; read-symbol-shorthands: (("gi-" . "go-integration-"))
;; End:
