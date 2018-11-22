#!/bin/bash

tag=`whoami`@`date +%Y%m%d`

test $1 = lua && {
    echo -e "--\n-- $tag\n--\nlocal _M = {}\n\nreturn _M"
    exit
}
test $1 = php && {
    echo -e "<?php\n//\n// $tag\n//"
    exit
}
test $1 = sh && {
    echo -e "#!/bin/bash\n#\n# $tag\n#"
    exit
}
