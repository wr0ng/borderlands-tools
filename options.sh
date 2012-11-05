#!/bin/bash
# options.sh: Demonstrate all available options for main.sh

while getopts "r:x:" opt; do
  case $opt in
    r)
      echo "got -r $OPTARG - will record with $OPTARG" >&2
      ;;
    x)
      echo "got -x $OPTARG - will launch extra $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: $OPTARG" >&2
      ;;
  esac
done
