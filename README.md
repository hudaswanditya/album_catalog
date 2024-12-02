# Album Catalog App

This is a Ruby on Rails application for managing albums and tracks. It allows users to create, edit, publish, and delete albums and tracks, while also providing album cover image uploads and duration calculations.

## Prerequisites

Before you begin, ensure you have the following installed:

- Ruby (version 3.0.0 or higher)
- Rails (version 7 or higher)
- PostgreSQL (or another database supported by Rails)
- Node.js (for JavaScript compilation)
- Yarn (for managing frontend dependencies)

## Getting Started

Follow these steps to set up the application on your local machine.

### 1. Clone the repository

Clone this repository to your local machine:

```bash
git clone https://github.com/hudaswanditya/album-catalog.git
cd album-catalog
```

### 2. Install dependencies
Install Ruby gems:

```
bundle install
```
Install JavaScript dependencies:
```
yarn install
```

### 3. Set up the database
Setup the database:
```
rails db:setup
```

### 4. Set up Active Storage (for file uploads)
Run the following command to set up Active Storage for handling file uploads (e.g., album cover images):

```
rails active_storage:install
rails db:migrate
```
### 5. Start the Rails server
Start the Rails development server:
```
bin/dev
```
The app will be available on localhost:3000

### 6. Running Tests
To run the test suite, use the following command:
```
rspec
```
### Notes
In just four hours, this is the progress I have been able to achieve on the project, although it remains incomplete. Currently, the process for adding a new track and uploading the album cover still relies on standard Rails form inputs. However, the goal is to enhance the user experience by implementing a nested form for editing the album. This will allow users to easily manage tracks without needing to edit them individually. Additionally, the track addition mechanism should be improved to create input fields dynamically, rather than simply appending a new track.

To provide clarity on the system’s functionality, I have already implemented RSpec tests that cover the most crucial parts of the code. This will make it easier to continue development in the future. Moving forward, I plan to integrate feature tests, especially given the significant DOM changes facilitated by Turbo in this application. These tests will ensure that the app remains robust and maintainable as it evolves.