#!/bin/bash -e

export PATH=/home/custodian/.local/bin:$PATH
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq -r .Account)
j2 ami-cleanup.tpl.yml > ami-cleanup.yml

if [ "$INPUT_DRY_RUN" == "true" ]; then
    custodian run --dryrun -s out ami-cleanup.yml
else
    custodian run -s out ami-cleanup.yml
fi

