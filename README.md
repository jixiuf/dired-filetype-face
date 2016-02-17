dired-filetype-face
=================================

[![MELPA](http://melpa.org/packages/dired-filetype-face-badge.svg)](http://melpa.org/#/dired-filetype-face)

Set different faces for different filetypes in dired

Getting started
------------

The easiest way to get started is to install the package via [MELPA][melpa]:

 [melpa]: http://melpa.org/

```elisp
(package-install 'dired-filetype-face)
```

Once installed, activate it by adding the following to your `~/.emacs` startup
file:

```elisp
(require 'dired-filetype-face)
```

 If you want to add a new face for new filetype(s):

```elisp
   (deffiletype-face "mytype" "Chartreuse")
```

 then either:

```elisp
   (deffiletype-face-regexp mytype
     :extensions '("foo" "bar") :type-for-docstring "my type")
```

 to match all files ending either ".foo" or ".bar", or equivalently:

```elisp
   (deffiletype-face-regexp mytype
     :regexp "^  -.*\\.\\(foo\\|bar\\)$" :type-for-docstring "my type")
```

 and finally:

```elisp
   (deffiletype-setup "mytype" "mytype")
```
   

 The :regexp form allows you to specify other things to match on each line of
 the dired buffer than (only) file extensions, such as the permission bits,
 the size and the modification times.

Pull Request for adding default extensions or changing current setting are welcome
------------------------

Copyright & License
------------------------

Copyright (C) 2011~2015, 纪秀峰. Released under the terms of the GNU GPL v3+.