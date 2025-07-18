#!/bin/bash
# scripts/run-example.sh

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <example-directory>"
    echo "Example: $0 01-turbo-drive-navigation"
    exit 1
fi

EXAMPLE_DIR=$1

if [ ! -d "$EXAMPLE_DIR" ]; then
    echo "Error: Directory $EXAMPLE_DIR does not exist"
    exit 1
fi

echo "Running $EXAMPLE_DIR..."

cd "$EXAMPLE_DIR"

# Check if setup is needed
if [ ! -f "Gemfile.lock" ]; then
    echo "Running setup first..."
    ../scripts/setup-example.sh $EXAMPLE_DIR
fi

# Start the Rails server
echo "Starting Rails server..."
rails server