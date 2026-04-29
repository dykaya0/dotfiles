#!/usr/bin/env bash

emacsclient -c -F '((name . "special-emacs"))' --eval "(org-capture)"
