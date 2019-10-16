#!/bin/bash -ex

POLICY_FILE=/tmp/ami-cleanup.yml
export PATH=/home/custodian/.local/bin:$PATH
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq -r .Account)
dockerize --template /ami-cleanup.tpl.yml:$POLICY_FILE

echo "Running policy:"
cat $POLICY_FILE

mkdir output
if [ "$INPUT_DRY_RUN" == "true" ]; then
    custodian run --dryrun -s output $POLICY_FILE
else
    custodian run  -s output $POLICY_FILE
fi

