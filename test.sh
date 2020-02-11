#!/bin/bash
if [[ $(git rev-parse --verify --quiet masteAr) ]]; then
echo it exists
else
echo it does not
fi