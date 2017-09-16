#!/bin/bash

# A shell script to generate ocd files from txt.
OPENCC_ROOT="${SRCROOT}/OpenCC"
OPENCC_BUILD_OCD_DIR="${OPENCC_ROOT}/build/rel/data"
PROJECT_DIC_DIR="${SRCROOT}/Resource/Dictionary"

cd "${OPENCC_ROOT}"
make

cd "${OPENCC_BUILD_OCD_DIR}"
for file in *.ocd
do
	cp -f "${file}" "${PROJECT_DIC_DIR}"
done