#!/bin/bash -e

POLICY_FILE=/tmp/ami-cleanup.yml
export PATH=/home/custodian/.local/bin:$PATH
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq -r .Account)
j2 ami-cleanup.tpl.yml > $POLICY_FILE

if [ "$INPUT_DRY_RUN" == "true" ]; then
    custodian run --dryrun -s out $POLICY_FILE
else
    custodian run -s out $POLICY_FILE
fi

