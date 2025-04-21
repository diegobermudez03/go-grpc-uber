# Go gRPC Uber - Ride-Hailing Simulation

[![Demo Video](https://img.shields.io/badge/Demo-Video-red?style=for-the-badge&logo=youtube)](https://youtu.be/2NP7__F781E)
[![GitHub Repository](https://img.shields.io/badge/GitHub-Repo-blue?style=for-the-badge&logo=github)](https://github.com/diegobermudez03/go-grpc-uber)

This project simulates a dynamic ride-hailing service, similar to Uber, using gRPC for real-time communication between its components.

## Overview

The system is composed of three main parts:

1.  **gRPC Server (Go):** The central hub managing drivers, ride requests, and communication flow. Located in the `server` directory.
2.  **Passenger Client (Go):** A command-line interface for users to request rides. Located in the `client` directory.
3.  **Driver Client (Flutter):** An Android mobile application allowing drivers to connect, manage their status, location, and respond to ride requests. Located in the `taxi_app` directory.

This project intentionally includes the mobile Driver Client to add more dynamic features beyond a basic simulation.

## Key Features

*   **Hybrid Driver Pool:** The server manages both simulated 'bot' drivers (as a baseline) and 'real' drivers connecting via the Flutter app.
*   **Intelligent Dispatch:** Prioritizes assigning rides to connected, real drivers over bots. If no real drivers are available or all reject the ride, it falls back to the closest available bot.
*   **Real-time Passenger Updates:** The passenger client receives live feedback via gRPC streaming, such as "Searching for driver X...", "Driver Y rejected...", "Driver Z accepted!".
*   **Interactive Ride Offers:** Real drivers receive ride requests on their mobile app and can accept or reject them. The system handles rejections gracefully and continues the search.
*   **Real-time Driver Location:** Connected drivers can update their location at any time through the Flutter app.

## How it Works

The system relies heavily on **gRPC** for communication:

*   The **Server** defines and exposes gRPC services for handling ride requests, driver connections, location updates, and ride offer responses.
*   The **Passenger Client** uses gRPC to send ride requests and subscribes to a server stream for real-time status updates.
*   The **Driver Client (Flutter App)** uses gRPC to connect to the server, send location updates, receive ride offers via a server stream, and send back acceptance or rejection messages.

This architecture enables efficient, real-time interactions between all parts of the simulation.

**Note:** The current simulation scope concludes once a driver accepts the ride request. The subsequent trip progression is not implemented. Drivers who accept a ride remain 'busy' for the remainder of the server session.

---
