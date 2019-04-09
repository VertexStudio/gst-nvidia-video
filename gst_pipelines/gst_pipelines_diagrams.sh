#!/usr/bin/env bash

set -o errexit

if [ -z "$GST_DEBUG_DUMP_DOT_DIR" ]
then
    echo "Environmental variable GST_DEBUG_DUMP_DOT_DIR is not defined."
    exit 1
fi

# Moving to workdir where dot files exist
cd "$GST_DEBUG_DUMP_DOT_DIR"

if ! [ -x "$(command -v dot)" ]
then
  echo "Error: 'graphviz' is not installed." >&2
  exit 1
fi

mkdir -p diagrams

# Clean previous diagrams
rm -rf diagrams/*

if [ "$(ls | grep -c .dot$)" -gt 5 ]
then
    echo "There are more than 5 .dot files. Probably from a previous pipeline execution."
    echo "Diagrams could not be consistent with the stages you're trying to debug."
fi

COUNTER=0
for state in *.dot
do
    [ -e "$state" ] || continue
    dot -Tpng "$state" > "./diagrams/diagram_$COUNTER".png
    rm "$state"
    COUNTER=$(( COUNTER + 1 ))
done

echo "===================="
echo "Diagrams generated!"
echo "===================="