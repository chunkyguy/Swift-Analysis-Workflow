#!/bin/sh
#  Auto profile the codebase based on the latest Xcode log

# Get the directory where Xcode saves the build logs
LOG_DIR=${SYMROOT}/../../Logs/Build

# Get the latest log
LATEST_LOG=$(ls -t $LOG_DIR | grep xcactivitylog | head -1)
LOG_FILE=${LOG_DIR}/${LATEST_LOG}

# Save log
OUT_PATH=${SRCROOT}/Logs
mkdir -p ${OUT_PATH}
OUT_FILE=${OUT_PATH}/compile-times
ruby ${SRCROOT}/scripts/Swift-Analysis-Workflow/swift-analysis.rb ${LOG_FILE} ${OUT_FILE}
