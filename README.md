# Description

This infrastructure is designed for deploying a microservices-based project. It provides a ready-to-use environment for building, configuring, and deploying services efficiently.

# Repositories

Below are the repositories related to this project

- [Composer Service](https://github.com/SmknSe/RKSP8.git)
- [Service Discovery](https://github.com/SmknSe/service-discovery.git)
- Simple CRUD Services
  - [User Service](https://github.com/SmknSe/UserService.git)
  - [Item Service](https://github.com/SmknSe/ItemService.git)
  - [Order Service](https://github.com/SmknSe/OrderService.git)

# Deployment Guide

## Steps

1. **Create Services**

   - Set up the services as outlined in the provided structure.
   - Build Docker images for each service.
   - Push the images to Docker Hub.

2. **Configure Environment Files**

   - Prepare and configure your environment files for each service.

3. **Run Deployment Script**

   - Execute the `deploy.sh` script located in the root directory.

4. **Verify Deployment**

   - Ensure that all services are running correctly and as expected.

5. **Done**
   - Your deployment is complete!

## Notes on overriding Spring Boot Properties

When overriding Spring Boot properties using environment variables, use the following notation:

- **Spring Boot Notation**: `some.variable.without.dash`  
  **Environment Variable Notation**: `SOME_VARIABLE_WITHOUT_DASH`

- **Spring Boot Notation**: `some.variable.with-dash`  
  **Environment Variable Notation**: `SOME_VARIABLE_WITHDASH`

## P.S.

**Exposing to localhost**

> If you're using docker-driven minikube, do not forget about `minikube tunnel`

**Something does not work?**

> idk...
