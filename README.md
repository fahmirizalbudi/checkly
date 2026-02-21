<div align="center">
<img src="assets/logo.svg" width="150" alt="Checkly Logo" />

<br />
<br />

![](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)

</div>

<br/>

## Checkly

Checkly is a modern, minimalist task management application built with Flutter. It helps you stay organized by tracking your daily tasks, categorizing them, and monitoring your progress with a beautiful, user-friendly interface designed for efficiency.

## Preview

<p align="center">
  <img src="checkly-mockup-2.png" width="600" alt="Checly" />
</p>


## Features

- **Task Management:** Easily add, toggle, and delete tasks to keep your day organized.
- **Smart Categorization:** Organize tasks into categories like Work, Personal, Shopping, or create your own.
- **Progress Tracking:** Visual circular progress indicators to keep you motivated as you complete tasks.
- **Local Persistence:** Your data is stored locally using Shared Preferences, ensuring it is always there when you return.
- **Modern Design:** A clean UI featuring a docked bottom navigation bar and smooth interactions.

## Tech Stack

- **Flutter**: Google's UI toolkit for building natively compiled applications.
- **Dart**: The programming language used for development.
- **Shared Preferences**: For persistent local storage of tasks and settings.
- **MVVM Architecture**: Ensures clean separation between UI and business logic.
- **Google Fonts**: Uses DM Sans for modern typography.

## Getting Started

To get a local copy of this project up and running, follow these steps.

### Prerequisites

- **Flutter SDK** (v3.0 or higher).
- **Dart SDK**.
- **Android Studio** or **VS Code** with Flutter extensions.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/checkly.git
   cd checkly
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the application:**

   ```bash
   flutter run
   ```

## Usage

### Running on Device/Emulator

- **Development:** `flutter run`
- **Release Build:** `flutter build apk --release` (Android) or `flutter build ios --release` (iOS)

The app will launch on your connected device or emulator. Navigate between the Home, Tasks, and History tabs using the bottom navigation bar. Add new tasks using the add button.

## License

All rights reserved. This project is for educational purposes only and cannot be used or distributed without permission.
