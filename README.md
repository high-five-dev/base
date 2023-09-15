# Craft Base

Easily create a barebones Craft CMS website project.

## Creating a new project

Before creating a new project, you should ensure that your local machine has PHP, DDev and Composer installed.

After you have installed PHP, DDev and Composer, you may create a new project via the Composer `create-project` command:

    composer create-project high-five/craft-base example-website.ext --stability=dev


After the project has been created, start the local development server using the Makefile's `start` command:

    cd example-website.ext

    make start

## `make` commands

Run `make` or `make help` for an overview of the available commands.

| Command | Description |
| --- | --- |
| `make ddev` | Start DDev server |
| `make start` | Start DDev server and install |dependencies
| `make stop` | Stop DDev environment|
| `make serve` | Start DDev server, install dependencies and start NPM dev server |
| `make install` | Install dependencies |
| `make dev` | Start NPM dev server |
| `make build` | Build for production |
| `make db-export` | Export the DDev database to the `./sql/` directory |
