#!/bin/bash -ex

env
pushd $INPUT_WORKING_DIR



TEMPLATE_FILE=${INPUT_TEMPLATE_FILE:-$INPUT_TEMPLATE.json}
dockerize -template /git-info.tpl.json:/git-info.json

tagsmerge.sh $TEMPLATE_FILE /git-info.json > template.json

echo "using merged file:"
cat template.json

if [ "$INPUT_VALIDATE_ONLY" == "true" ]; then
    packer validate template.json
else
    packer build template.json
fi
