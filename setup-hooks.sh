#!/bin/bash
find hooks -maxdepth 1 -type f -exec cp {} .git/hooks/ \;
chmod +x .git/hooks/*
npm i