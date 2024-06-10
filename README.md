# Rock Paper Scissors Game

This project is a Rock Paper Scissors game consisting of a Rails API backend and a Next.js frontend. The application is containerized using Docker and Docker Compose.

## Prerequisites

Before you begin, make sure you have the following installed on your machine:

- [Docker](https://www.docker.com/products/docker-desktop)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup

1. **Clone the repository:**

   ```sh
   git clone https://github.com/sikor144/rps.git
   cd rps
   ```

2. **Copy the example environment variables file:**

   ```sh
   cp .env.example .env
   ```

3. **Edit the `.env` file** to configure the environment variables:

   ```env
   POSTGRES_USER=your_postgres_user
   POSTGRES_PASSWORD=your_postgres_password
   POSTGRES_DB=your_postgres_db
   SECRET_KEY_BASE=your_secret_key_base
   ```

## Running the Application

1. **Build and start the Docker containers:**

   ```sh
   docker-compose up --build
   ```

   This command will build and start the following services:

   - `postgres`: PostgreSQL database
   - `api`: Rails API backend
   - `web`: Next.js frontend

2. **Access the application:**

   - The Next.js frontend will be available at [http://localhost:3000](http://localhost:3000)
   - The Rails API will be available at [http://localhost:3001](http://localhost:3001)

## Services

- **PostgreSQL**: The database service
- **API**: The Rails backend service
- **Web**: The Next.js frontend service

## Stopping the Application

To stop the application, run:

```sh
docker-compose down
```

This command will stop and remove the containers defined in your `docker-compose.yml`.

## Additional Commands

- **Running commands inside the containers:**

  You can run commands inside the API or Web container using `docker-compose exec`. For example, to open a bash shell inside the API container, use:

  ```sh
  docker-compose exec api bash
  ```
