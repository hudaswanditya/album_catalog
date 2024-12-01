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
This is what I could achieve in 4 hours time. It is not completed yet. The add new track and adding the cover album still using standard rails input. It should use nested form to edit the album to make it more easier for the user instead editing track one by one, and also the add track mechanism should directly create an input field instead only append the new track.

To make it clear how the system works, i already implement rspec and cover already important parts of the code, so it can be easier to develop this app in the future. I should implement feature test in the future as well, since there are a lot dom changes in this app using turbo.