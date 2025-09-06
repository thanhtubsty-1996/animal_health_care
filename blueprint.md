# Animal Health App Blueprint

## Overview

This document outlines the architecture, features, and design of the Animal Health App, a Flutter application for managing customer and pet information. The app is built with a focus on clean architecture, modern UI/UX, and robust data management using Firebase.

## Implemented Features

*   **Initial Setup:** Basic Flutter project structure.
*   **Data Modeling:** Initial data models for `Customer` and `Pet`.
*   **Fake Data:** Used a fake API (`AnimalHealthApi`) for initial data display.
*   **UI Scaffolding:** Basic UI screens for customer list and detail views.
*   **State Management:** `flutter_bloc` for managing the state of the UI.
*   **Dependency Injection:** `get_it` for decoupling dependencies.
*   **Firebase Integration:**
    *   Integrated `cloud_firestore` for data persistence.
    *   Replaced fake API with `CustomerRepositoryImpl` and `PetRepositoryImpl` using Firestore.
    *   Configured the Flutter project for Firebase using `flutterfire_cli`.
*   **Data Serialization:** Implemented `freezed` for robust data serialization and deserialization.
*   **Theming & UI Polish:**
    *   Refactored the application's theme to follow Material 3 design principles.
    *   Added `google_fonts` for custom typography and `provider` for theme state management.
    *   Implemented a theme-toggling feature (light/dark mode).
*   **Navigation:**
    *   Created a custom animated side drawer navigation using `MainLayout`.
    *   Updated the routing configuration (`app_router.dart`) to use `ShellRoute` with the new `MainLayout`.
*   **Clinic Section:**
    *   Created a `clinic_screen.dart` as the main page for the clinic section.
    *   Created a `medical_examination_screen.dart` to display a list of appointments.
    *   Defined the `Appointment` entity.
    *   Added `intl` package for date formatting in the appointment list.

## Current Plan: Implement CRUD Operations for Customers

**Goal:** Build the user interface and logic to allow users to create, update, and delete customer records.

**Phase 1: Create New Customer**

1.  **Update `blueprint.md`**: Document the plan for implementing the "Create Customer" feature.
2.  **Add Floating Action Button**: Add a `FloatingActionButton` to the `customer_list_screen.dart` to trigger the creation of a new customer.
3.  **Create `add_edit_customer_screen.dart`**: Build a new screen with a form for entering new customer details (name, phone, email, address).
4.  **Update Router**: Add a new route in `app_router.dart` to navigate to the `add_edit_customer_screen.dart`.
5.  **Implement Save Logic**: Connect the form's save button to the `CustomerBloc` to add the new customer to Firestore via the `CustomerRepository`.
