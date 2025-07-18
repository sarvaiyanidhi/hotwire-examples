#!/bin/bash
# scripts/create-example.sh

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <example-number-and-name>"
    echo "Example: $0 01-turbo-drive-navigation"
    exit 1
fi

EXAMPLE_DIR=$1

if [ -d "$EXAMPLE_DIR" ]; then
    echo "Error: Directory $EXAMPLE_DIR already exists"
    exit 1
fi

# Create a Rails-compatible app name by removing numbers and dashes from the start
# and replacing dashes with underscores
RAILS_APP_NAME=$(echo "$EXAMPLE_DIR" | sed 's/^[0-9]*-*//' | sed 's/-/_/g')

# Ensure the name starts with a letter
if [[ ! "$RAILS_APP_NAME" =~ ^[a-zA-Z] ]]; then
    RAILS_APP_NAME="example_$RAILS_APP_NAME"
fi

echo "Creating new example: $EXAMPLE_DIR"
echo "Rails app name: $RAILS_APP_NAME"

# Create Rails app with the transformed name (keeping default test framework)
rails new "$EXAMPLE_DIR" --database=postgresql --css=tailwind --app-name="$RAILS_APP_NAME" --skip-git

cd "$EXAMPLE_DIR"

# No additional gems needed - Rails 7+ includes Hotwire by default
# and solid_cache is already included for caching needs

# Configure database credentials
echo "Configuring database credentials..."
cat > config/database.yml << 'EOF'
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV.fetch("DATABASE_USERNAME", "postgres") %>
  password: <%= ENV.fetch("DATABASE_PASSWORD", "password") %>
  host: <%= ENV.fetch("DATABASE_HOST", "localhost") %>

development:
  <<: *default
  database: <%= Rails.application.class.module_parent_name.underscore %>_development

test:
  <<: *default
  database: <%= Rails.application.class.module_parent_name.underscore %>_test

production:
  <<: *default
  database: <%= Rails.application.class.module_parent_name.underscore %>_production
  username: <%= ENV.fetch("DATABASE_USERNAME") %>
  password: <%= ENV.fetch("DATABASE_PASSWORD") %>
EOF

# Install gems
bundle install

# Create basic structure
mkdir -p docs/screenshots

# Create README template
cat > README.md << EOF
# Example $EXAMPLE_DIR

## Overview
Brief description of what this example demonstrates.

## Concepts Covered
- Concept 1
- Concept 2
- Concept 3

## Setup
\`\`\`bash
bundle install
rails db:create db:migrate db:seed
rails server
\`\`\`

## What You'll Learn
- Learning objective 1
- Learning objective 2
- Learning objective 3

## Key Files
- \`app/controllers/\` - Controllers
- \`app/views/\` - Views
- \`app/javascript/controllers/\` - Stimulus controllers
- \`app/models/\` - Models

## Testing
\`\`\`bash
rails test
\`\`\`

## Next Steps
After completing this example, move on to [Example X](../example-x/).
EOF

# Create SETUP.md template
cat > SETUP.md << 'EOF'
# Step-by-Step Setup Guide

## Step 1: Understanding the Problem
Explain what we're trying to solve...

## Step 2: Create the Model
```bash
rails generate model YourModel
```

## Step 3: Create the Controller
```bash
rails generate controller YourController
```

## Step 4: Add Routes
```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Add your routes here
end
```

## Step 5: Create Views
Create the necessary view files...

## Step 6: Add Stimulus Controller
```javascript
// app/javascript/controllers/your_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Your controller code
}
```

## Testing
Test your implementation using Rails' built-in minitest...

## Common Issues
- Issue 1 and solution
- Issue 2 and solution
EOF

# Create CONCEPTS.md template
cat > CONCEPTS.md << 'EOF'
# Technical Concepts

## Core Hotwire Concepts

### Turbo Drive
Explain how Turbo Drive works in this example...

### Turbo Frames
Explain how Turbo Frames are used...

### Turbo Streams
Explain how Turbo Streams are implemented...

### Stimulus
Explain the Stimulus patterns used...

## Implementation Details

### Database Schema
Show the database schema...

### Request/Response Flow
Explain the request/response cycle...

### JavaScript Interaction
Explain how JavaScript enhances the experience...

## Best Practices
- Best practice 1
- Best practice 2
- Best practice 3
EOF

echo "✅ Example structure created: $EXAMPLE_DIR"
echo "Rails app name used: $RAILS_APP_NAME"
echo "Next steps:"
echo "1. Edit the README.md with your example details"
echo "2. Implement the example following SETUP.md"
echo "3. Document the concepts in CONCEPTS.md"
echo "4. Add tests in test/"