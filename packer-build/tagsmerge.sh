#!/bin/bash -ex
merge() {
    local packertpl=$1
    local overridefile=$2
    local section=${3:-"builders"}

    if [ -f $overridefile ]; then
        merge_str="$$"
        jq \
        --argfile f1 $packertpl \
        --argfile f2 $overridefile \
        -n "\$f1 * (\$f1.$section[] * \$f2.$section[] | { $section: [.] })"
    else
        echo "no file: $overridefile to merge" >&2
        cat $packertpl
    fi
}

merge $@