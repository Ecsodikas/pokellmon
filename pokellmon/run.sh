#!/bin/bash

sbcl --dynamic-space-size 32000 \
    --load "pokellmon.asd" \
    --eval "(ql:quickload :pokellmon)" \
    --eval "(in-package :pokellmon)" \
    --eval "(main)"
