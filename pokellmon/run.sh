#!/bin/bash

sbcl --load "pokellmon.asd" \
    --eval "(ql:quickload :pokellmon)" \
    --eval "(in-package :pokellmon)" \
    --eval "(main)"
