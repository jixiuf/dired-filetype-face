;;; dired-filetype-face.el  --- set different faces for different filetype in dired buffer.

;; Copyright (C) 2011~2012, 纪秀峰(Joseph) all rights reserved.
;; Created: 2011-04-04
;; Last Update: 纪秀峰 2015-02-04 13:25:17
;; Description: set faces for different file type in dired buffer.
;; Author: 纪秀峰(Joseph) <jixiuf@gmail.com>
;; Version: 0.2.3
;; URL: http://www.emacswiki.org/emacs/download/dired-filetype-face.el
;; X-URL:https://github.com/jixiuf/dired-filetype-face
;; Keywords: dired filetype face custom
;; Compatibility: (Test on GNU Emacs 23.2.1 ,24.0.50)
;;
;; Features that might be required by this library:
;;
;;   `custom', `dired', `widget'.
;;
;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;;  Set faces for different file type in dired buffer. I use a dark
;;  background, so maybe the default face doesn't meet your request.
;;  you can : M-x: customize-group dired-filetype-face  RET
;;  And maybe M-x: customize-group dired-faces  RET
;;  may do some help for you.
;;
;;
;;; Installation:
;;
;; Just put `dired-filetype-face.el' to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; Add the following to your ~/.emacs startup file.
;;
;; (eval-after-load 'dired '(progn (require 'dired-filetype-face)))
;;
;; No need more.
;;

;;; Code:

(require 'dired)
(require 'custom)

(defgroup dired-filetype-face nil
  "set faces for different filetype in dired buffer."
  :prefix "dired-filetype-face-"
  :group 'dired-faces)

(defmacro deffiletype-face (type color &optional type-for-symbol)
  "Declare a dired filetype face for displaying TYPE files in the given COLOR.

If TYPE-FOR-SYMBOL is nil, define a face named
  dired-filetype-TYPE

Otherwise, define a face named
  dired-filetype-TYPE-FOR-SYMBOL

COLOR may be a string or a list of face properties. If a string,
it is either a color name such as \"Chartreuse\" or a color
hexadecimal RGB number such as \"#xaaaaaa\"."
  `(defface ,(intern (concat "dired-filetype-" (downcase (or type-for-symbol type))))
     ,(if (stringp color)
       `(quote ((t (:foreground ,color))))
       color)
     ,(format "Face for displaying %s files in dired." type)
     :group 'dired-filetype-face))

(defmacro deffiletype-face-regexp (regexp type-for-symbol &optional type-for-docstring)
  "Declare a filetype REGEXP option for dired to colorize matching files.

Use TYPE-FOR-SYMBOL to derive the option symbol.

If TYPE-FOR-DOCSTRING is not nil, use that in the option
docstring instead of TYPE-FOR-SYMBOL."
  `(defcustom ,(intern (format "dired-filetype-%s-regexp" type-for-symbol))
     ,regexp
     ,(format "Regexp to match %s file-types in dired." (or type-for-docstring type-for-symbol))
     :type 'string
     :group 'dired-filetype-face))

(defconst dired-filetype-face-font-lock-keywords
  '(("(\\(deffiletype-face\\(?:-\\(?:regexp\\|set-fun\\)\\)?\\)\\_>"
     (1 font-lock-keyword-face))))

(font-lock-add-keywords 'emacs-lisp-mode dired-filetype-face-font-lock-keywords)

(deffiletype-face "omit" "Chartreuse")

(deffiletype-face-regexp
  "^  .*\\.\\(elc\\|class\\|so\\|ko\\|la\\|o\\|al\\|ix\\|db\\|td\\|\\|dat\\|dll\\|Dll\\|DLL\\|sav\\|rdp\\|sys\\|SYS\\|prf\\|tlb\\|cat\\|bak\\)$"
  "omit1"
  "unimportant")

(deffiletype-face-regexp
  "^  .*\\(\\.git\\|\\.svn\\|~\\|#\\|%\\|\\.tmp\\|\\$DATA\\|:encryptable\\|\\.db_encryptable\\)$"
  "omit2"
  "backup or cache")

(deffiletype-face-regexp " \\.\\(.*$\\)" "omit3" "hidden")

(deffiletype-face "rich document" "DarkCyan" "document")

(deffiletype-face-regexp
  "^  .*\\.\\(pdf\\|chm\\|CHM\\|tex\\|doc\\|docx\\|xls\\|xlsx\\|ppt\\|pptx\\|odt\\|ott\\|rtf\\|sdw\\|ods\\|sxc\\|odp\\|otp\\|sdx\\|kdh\\|shx\\)$"
  "document"
  "rich document")

(deffiletype-face "plain text" "MediumPurple" "plain")

(deffiletype-face-regexp
  "^  .*\\.\\(TXT\\|txt\\|Txt\\|ini\\|INI\\|lrc\\|org\\|log\\|conf\\|CFG\\|cfg\\|properties\\|config\\|diff\\|patch\\|ebuild\\|inf\\|cnf\\|example\\|sample\\|default\\|m4\\)$"
  "plain"
  "plain text")

(deffiletype-face "common" "Peru")

(deffiletype-face-regexp
  "^  .*\\(configure\\|INSTALL\\|README\\|readme\\|COPYING\\|CHANGES\\|LICENSE\\|ChangeLog\\|Makefile.in\\|MANIFEST.MF\\|NOTICE.txt\\|build.xml\\|Manifest\\|metadata.xml\\|install-sh\\|NEWS\\|HACKING\\|AUTHORS\\|todo\\|Todo\\|TODO\\|makefile\\|TAGS\\|tag\\)$"
  "common")

(deffiletype-face "XML" "Chocolate")

(deffiletype-face-regexp
  "^  .*\\.\\(html?\\|HTML?\\|xml\\|XML\\|xsl\\|xsd\\|rng\\|dtd\\|mht\\|jsp\\|asp\\|js\\|xaml\\)$"
  "xml"
  "XML")

(deffiletype-face "compressed" "Orchid" "compress")

(deffiletype-face-regexp
  "^  .*\\.\\(tar\\|zip\\|ZIP\\|rar\\|RAR\\|tgz\\|gz\\|bzip2\\|bz2\\|7z\\|7Z\\|Z\\|z\\|xz\\|XZ\\|rpm\\|deb\\|lzma\\|cab\\|gzip\\|taz\\|wim\\|iso\\|tbz2\\|xar\\|XAR\\|jar\\|war\\|img\\)$"
  "compress"
  "compressed")

(deffiletype-face "source code" "SpringGreen" "source")

(deffiletype-face-regexp
  "^  .*\\.\\(c\\|cpp\\|java\\|JAVA\\|C\\|php\\|h\\|rb\\|pl\\|css\\|el\\|lua\\|sql\\|ahk\\|cs\\|erl\\|hrl\\|go\\)$"
  "source"
  "source code")

(deffiletype-face "executable" "green" "execute")

(deffiletype-face-regexp
  "^  .*\\.\\(exe\\|EXE\\|bat\\|BAT\\|msi\\|MSI\\|\\|sh\\|run\\|reg\\|REG\\|com\\|COM\\|\\|vbx\\|VBX\\|bin\\|xpi\\|bundle\\)$"
  "execute"
  "executable")

(deffiletype-face "music" "SteelBlue")

(deffiletype-face-regexp
  "^  .*\\.\\(mp3\\|MP3\\|wma\\|WMA\\|wav\\|WAV\\|mid\\|MID\\|ogg\\|OGG\\|aac\\|AAC\\|flac\\|FLAC\\|m4a\\|M4A\\)$"
  "music")

(deffiletype-face "video" "SandyBrown")

(deffiletype-face-regexp
  "^  .*\\.\\(flv\\|FLV\\|avi\\|AVI\\|mkv\\|rmvb\\|RMVB\\|mpeg\\|mpg\\|MPG\\|rm\\|RM\\|mp4\\|wmv\\|WMV\\|m4v\\|mov\\|ogm\\|ogv\\|3gp\\|f4v\\|swf\\|webm\\|divx\\|xvid\\|rm\\)$"
  "video")

(deffiletype-face "image" "MediumPurple")

(deffiletype-face-regexp
  "^  .*\\.\\(gif\\|GIF\\|jpg\\|JPG\\|bmp\\|BMP\\|jpeg?\\|JPEG?\\|png\\|PNG\\|xpm\\|svg\\|icns\\|odg\\|tiff?\\|epsf?\\|icon?\\|pict?\\|tga\\|pcx\\|xbm\\)$"
  "image")

(deffiletype-face
  "link"
  '((((class color) (background dark)) :foreground "yellow" :background "forest green") (t ()))
  "lnk")

(deffiletype-face-regexp
  "^  .*\\.\\(lnk\\|LNK\\|desktop\\|torrent\\|url\\|URL\\)$"
  "lnk" "link")

;;; Custom ends here.

(defmacro deffiletype-face-set-fun (type &optional type-for-docstring type-for-symbol type-for-face)
  "Declare a function to tell dired how to display TYPE files.
If not nil, use TYPE-FOR-DOCSTRING instead of TYPE for documentation.
If not nil, use TYPE-FOR-SYMBOL instead of TYPE to derive the function symbol.
If not nil, use TYPE-FOR-FACE instead of TYPE to derive the symbol for the associated face."
  `(defun ,(intern (format "dired-filetype-set-%s-face" (or type-for-symbol type))) ()
     ,(format "Set dired-filetype-face for %s files." (or type-for-docstring type))
     (font-lock-add-keywords
       nil
       (list
         (cons
           ,(intern
              (format "dired-filetype-%s-regexp" (downcase type)))
           '((".+"
              (dired-move-to-filename)
              nil
              (0
                (quote
                  ,(intern
                     (concat
                     "dired-filetype-"
                     (or type-for-face type))))))))))))

(deffiletype-face-set-fun "document" "rich document")

(deffiletype-face-set-fun "plain" "plain text")

(deffiletype-face-set-fun "common")

(deffiletype-face-set-fun "XML")

(deffiletype-face-set-fun "compress" "compressed")

(deffiletype-face-set-fun "source" "source code")

(deffiletype-face-set-fun "omit1" "unimportant" "omit" "omit")

(deffiletype-face-set-fun "omit2" "backup and cache" nil "omit")

(deffiletype-face-set-fun "omit3" "hidden" nil "omit")

(deffiletype-face-set-fun "execute" "executable" "exe")

(deffiletype-face-set-fun "music" "audio")

(deffiletype-face-set-fun "video")

(deffiletype-face-set-fun "image")

(deffiletype-face-set-fun "lnk" "link")

;;;###autoload
(defun dired-filetype-face-mode-func()
  "this function will be added to `dired-mode-hook'"
  (dired-filetype-set-document-face)
  (dired-filetype-set-plain-face)
  (dired-filetype-set-common-face)
  (dired-filetype-set-exe-face)
  (dired-filetype-set-omit-face)
  (dired-filetype-set-omit2-face)
  (dired-filetype-set-omit3-face)
  (dired-filetype-set-source-face)
  (dired-filetype-set-compress-face)
  (dired-filetype-set-music-face)
  (dired-filetype-set-video-face)
  (dired-filetype-set-image-face)
  (dired-filetype-set-xml-face)
  (dired-filetype-set-lnk-face)
  )

;;;###autoload(add-hook 'dired-mode-hook 'dired-filetype-face-mode-func)
(add-hook 'dired-mode-hook 'dired-filetype-face-mode-func)
;;;###autoload(add-hook 'wdired-mode-hook 'dired-filetype-face-mode-func)
(add-hook 'wdired-mode-hook 'dired-filetype-face-mode-func)

(defadvice dired-toggle-read-only (after  dired-filetype-face activate)
  "set different faces for different file type."
  (dired-filetype-face-mode-func))

(defadvice wdired-exit (after dired-filetype-face activate)
  "set different faces for different file type."
  (dired-filetype-face-mode-func))

(defadvice wdired-finish-edit (after dired-filetype-face activate)
  "set different faces for different file type."
  (dired-filetype-face-mode-func))

(defadvice wdired-abort-changes (after dired-filetype-face activate)
  "set different faces for different file type."
  (dired-filetype-face-mode-func))

(provide 'dired-filetype-face)

;;; `dired-filetype-face.el'ends here.
