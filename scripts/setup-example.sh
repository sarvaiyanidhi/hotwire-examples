#!/bin/bash
# scripts/setup-example.sh

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

echo "Setting up $EXAMPLE_DIR..."

cd "$EXAMPLE_DIR"

# Install gems
echo "Installing gems..."
bundle install

# Setup database
echo "Setting up database..."
rails db:create
rails db:migrate

# Seed database if seeds exist
if [ -f "db/seeds.rb" ]; then
    echo "Seeding database..."
    rails db:seed
fi

# Install JavaScript dependencies if needed
if [ -f "package.json" ]; then
    echo "Installing JavaScript dependencies..."
    npm install
fi

echo "✅ Setup complete for $EXAMPLE_DIR"
echo "To run the example:"
echo "  cd $EXAMPLE_DIR"
echo "  rails server"