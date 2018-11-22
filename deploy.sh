#!/bin/bash
#
# tjx@20181122
#

realpath=$(realpath $0)
cd $(dirname $(dirname $realpath))
tar czvf /tmp/vim-vide.tgz $(basename $(dirname $realpath))
qshell rput static vim-vide.tgz /tmp/vim-vide.tgz

