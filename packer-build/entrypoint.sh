#!/bin/bash -e

env
pushd $INPUT_WORKING_DIR


ADDITIONAL_INFO_FILE=${INPUT_ADDITIONAL_INFO_FILE:-/build-info.tpl.json}
TEMPLATE_FILE=${INPUT_TEMPLATE_FILE:-$INPUT_TEMPLATE.json}
dockerize -template $ADDITIONAL_INFO_FILE:/build-info.json
cat /build-info.json

# Yeah it's chintzy.  
# But we need to a json merge of two sections.  I honestly
# can't explain why this merges in both the builders and post-processors
# section, but it seems to work so ¯\_(ツ)_/¯ 


jq --argfile f1 /build-info.json \
   --argfile f2 $TEMPLATE_FILE \
   -n '$f1 * ($f1."builders"[]? * $f2."builders"[]? | { "builders": [.] } )' \
   > packer-build.json

echo "using merged file:"
cat packer-build.json

if [ "$INPUT_VALIDATE_ONLY" == "true" ]; then
    packer validate packer-build.json
else
    packer build packer-build.json
    echo "manifest:"
    cat $INPUT_TEMPLATE-manifest.json
    # Extract the ami from the manifest.  manifest looks like
    # {
    #   "builds": [
    #     {
    #       "name": "amazon-ebs",
    #       "builder_type": "amazon-ebs",
    #       "build_time": 1571194480,
    #       "files": null,
    #       "artifact_id": "us-east-1:ami-0f4b5f0233ea8ed95",
    #       "packer_run_uuid": "63ed2471-48f4-0e06-38c1-c5efdabfc55c",
    #       "custom_data": null
    #     }
    #   ],
    #   "last_run_uuid": "63ed2471-48f4-0e06-38c1-c5efdabfc55c"
    # }

    image_id=$(cat $INPUT_TEMPLATE-manifest.json \
     | jq -r '.builds[0].artifact_id' \
     | cut -d ":" -f 2)
    
    echo ::set-output name=image_id::$image_id

fi

      "artifact_id": "us-east-1:ami-0f4b5f0233ea8ed95",
