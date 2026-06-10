# AI Chat & Suggestions App

## Screenshots

[Suggestions](https://via.placeholder.com/200x400?text=Suggestions) | ![Chat](https://via.placeholder.com/200x400?text=Chat) | ![History](https://via.placeholder.com/200x400?text=History) |


A  Flutter application that provides AI-powered chat capabilities, a paginated suggestion system, and local chat history using 
Bloc State, Hive local database, dependency injection and Clean Architecture.

# Features

- AI Chat: Interactive chat interface.
- Chat History: Locally persisted conversations using Hive for offline access.
- Smooth Navigation: Tab-based navigation with persistent state using GoRouter.
- Responsive UI: Clean and intuitive design following Material 3 guidelines.

---

#  Architecture

The project follows Clean Architecture principles to ensure scalability, maintainability, and testability. It is divided into three main layers:

#1. Presentation Layer
- BLoC Pattern: Used for state management to separate business logic from the UI.
- Widgets: Reusable UI components.
- Screens: Main view files.
- Styles: Consistent theming using ThemeData.

#2. Domain Layer
- Entities: Simple data objects.
- Use Cases: Encapsulates specific business logic (e.g., `SendMessageUseCase`, `GetSuggestions`).
- Repositories (Interfaces): Defines contracts for data operations.

# 3. Data Layer
- Models: Data transfer objects with JSON/Hive serialization.
- Repositories (Implementations): Orchestrates data flow between Data Sources.
- Data Sources: 
    - Remote: API calls to Gemini AI and Suggestions endpoint via `Dio`.
    - Local: Persistence using `Hive`.

---

#  Tech Stack

- State Management: flutter_bloc
- Navigation: go_router (Stateful Shell Route)
- Dependency Injection: get_it
- Networking: dio
- Database: hive
- AI Integration: google_generative_ai

---

#  Folder Structure


lib/
├── core/               # Routing, DI, network config, constants
├── data/               # Models, Repositories impl, Data sources (Local/Remote)
├── domain/             # Entities, Repositories interfaces, Use cases
├── presentation/       # Blocs, Screens, Widgets
└── main.dart           # App entry point & initialization


---

#  Setup & Installation

1. Clone the repository:
   git clone <repository-url>
   cd chat_app
   

2. Install dependencies:
   flutter pub get
   

3. API Key Setup:
   The app uses Gemini AI. Ensure you have an API key.
   - Add .env file at root directory 
   - Add your Gemini API key.

4. Run Code Generation (Hive/JSON):
   dart pub run build_runner build
   

5. Run the app:
  flutter run
 

---

## 📋 Development Standards

### Flutter Basics & UI/UX
- Utilizes Stateless/Stateful widgets appropriately based on the lifecycle needs.
- Implements Material 3 for a modern, responsive design.
- Layouts are built using `Flex`, `ListView`, and `Stack` for maximum responsiveness across screen sizes.

### Code Quality
- Separation of Concerns: Logic is kept out of UI files and managed by BLoCs and Use Cases.
- Naming Conventions: Follows official Dart style guide (camelCase for variables, PascalCase for classes).
- Readability: Modular code structure with meaningful comments.

### API Handling & Pagination
- Async/Await: Used for all asynchronous operations to prevent UI blocking.
- Error Handling: Custom error states in BLoC to show user-friendly messages.
- Pagination: The Suggestion screen implements "scroll-to-bottom" detection to fetch the next page of data seamlessly.

### Navigation & Routing
- Uses `GoRouter` for declarative routing.
- Implements StatefulShellRoute for persistent bottom navigation bars.
- Supports data passing via `extra` parameters.

### State Management
- BLoC/Cubit: Cleanly manages loading, success, and error states.
- Service Locator: `GetIt` is used to manage singleton instances of repositories and use cases, avoiding "prop drilling".
