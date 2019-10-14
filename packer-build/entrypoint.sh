#!/bin/bash -ex

env
cd $INPUT_WORKING_DIR

packer build -machine-readable $INPUT_TEMPLATE 