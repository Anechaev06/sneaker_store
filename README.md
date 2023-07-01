# E-commerce Sneaker Store

This project is an E-commerce Sneaker Store built using the Flutter framework. It allows users to browse, search, and purchase sneakers online. The app is designed to provide an intuitive user interface and a seamless shopping experience.

## Features

- User Registration and Authentication: Users can create accounts, log in, and securely authenticate themselves.
- Sneaker Catalog: Display a catalog of available sneakers, including product images, descriptions, and prices.
- Product Search and Filtering: Users can search for specific sneakers and apply filters to narrow down their options.
- Product Details: Show detailed information about each sneaker, including size options, color variations, and customer reviews.
- Shopping Cart: Users can add sneakers to their cart, review the contents, and proceed to checkout.
- Checkout Process: Allow users to enter shipping and billing information, select a payment method, and complete the purchase.
- Order History: Store and display a history of past orders for users to review.
- Wishlist: Enable users to save their favorite sneakers to a wishlist for future reference.
- User Reviews and Ratings: Allow users to leave reviews and ratings for sneakers they have purchased.
- Notifications: Send notifications to users regarding order updates, promotions, and other relevant information.

## Installation and Setup

1. Clone the repository to your local machine using the following command: git clone https://github.com/your-username/e-commerce-sneaker-store.git
2. Ensure that you have Flutter installed on your machine. For instructions on how to install Flutter, visit the official Flutter website: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
3. Open the project directory in your preferred IDE (e.g., Android Studio, Visual Studio Code).
4. Run the following command in the terminal to fetch the project dependencies: flutter pub get
5. Connect a physical device or start an emulator.
6. Run the app using the following command:


## Project Structure

The project follows a standard Flutter project structure. Here are the key directories and files:

- `lib`: Contains the Dart code for the application.
- `models`: Defines the data models used in the application.
- `screens`: Contains the different screens of the application, such as home, product details, cart, etc.
- `widgets`: Contains reusable UI components used throughout the app, such as product cards, buttons, etc.
- `services`: Contains service classes responsible for handling data retrieval and communication with backend APIs.
- `utils`: Contains utility functions and helper classes.
- `assets`: Contains static assets used in the application, such as images and fonts.
- `test`: Contains unit and integration tests for the application.
- `pubspec.yaml`: The Flutter package configuration file that lists the project dependencies.

## Dependencies

The project relies on the following dependencies:

- `http`: A package for making HTTP requests.
- `shared_preferences`: A package for persisting data on the device.
- `firebase_core`: The core Firebase SDK.
- `firebase_auth`: Firebase Authentication library for Flutter.
- `cloud_firestore`: Firestore database library for Flutter.

You can find the specific versions of these dependencies in the `pubspec.yaml` file.
