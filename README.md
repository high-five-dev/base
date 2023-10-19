# Base

Easily create a barebones Craft CMS website project.

## Creating a new project

Before creating a new project, you should ensure that your local machine has PHP, DDev and Composer installed.

After you have installed PHP, DDev and Composer, you may create a new project via the Composer `create-project` command:

    composer create-project high-five/base example-website.ext --stability=dev


After the project has been created, start the local development server using the Makefile's `start` command:

    cd example-website.ext

    make start

The development server should now be running at `https://example-website.ext`. You are ready to install Craft CMS!

    make install

## `make` commands

Run `make` or `make help` for an overview of the available commands.

| Command          | Description                                                      |
|------------------|------------------------------------------------------------------|
| `make ddev`      | Start DDEV server                                                |
| `make deps`      | Install dependencies                                             |
| `make start`     | Start DDEV server and install dependencies                       |
| `make serve`     | Start DDEV server, install dependencies and start NPM dev server |
| `make dev`       | Start NPM dev server                                             |
| `make build`     | Build for production                                             |
| `make install`   | Install Craft CMS                                                |
| `make db-export` | Export the DDEV database to the `./sql/` directory               |
