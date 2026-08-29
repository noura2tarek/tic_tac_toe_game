<p align="center">
  <img src="screenshots/tic3.jpeg" alt="Tic Tac Toe Banner">
</p>

# Tic Tac Toe

Tic Tac Toe is a simple and interactive Flutter game that allows players to enjoy the classic Tic Tac Toe experience either against a friend or an AI opponent.

The game provides a simple flow where players can choose their preferred game mode, select their playing side (X or O), and then start the game.

When a player wins, the winning pattern is highlighted using a custom-painted line, accompanied by a simple celebration effect using the Confetti package.

# Features

- **Game Modes**: Players can choose between playing against a friend or playing against the AI.
- **Player Side Selection**: Players can choose whether to play as X or O.
- **Interactive Gameplay**: Provides a simple and responsive Tic Tac Toe game experience.
- **Winning Pattern Detection**: Detects the winning combination and highlights it automatically.
- **Custom Winning Line**: Uses Flutter's `CustomPainter` to draw a line over the winning pattern.
- **Win Celebration**: Displays a simple celebration effect using the `Confetti` package when a player wins.
- **Reusable Widgets**: UI components are organized into reusable widgets for better code organization.
- **Responsive UI**: Designed to provide a clean gaming experience across different screen sizes.

--------------------------------------------------

# Game Flow

The application follows a simple three-step flow:

### 1. Select Play Mode

The player first chooses how they want to play:

- **Play with a Friend**
- **Play with AI**

### 2. Select Your Side

The player then chooses which side they want to play:

- **X**
- **O**

### 3. Start the Game

The game board is displayed and players can start playing.

When a winning pattern is detected:

- The winning combination is identified.
- A line is drawn over the winning pattern using `CustomPainter`.
- A celebration animation is displayed using `Confetti`.

--------------------------------------------------

# System Components (Tech Stack)

- **Frontend:** Flutter (Dart)
- **UI:** Flutter Widgets
- **Game Logic:** Dart
- **Custom Graphics:** Flutter `CustomPainter`
- **State & Game Handling:** Local game logic
- **Animation:** Confetti package

--------------------------------------------------

# App Structure

The project is organized into separate folders for core resources, game logic, and UI views.

```text
lib/
│
├── core/
│   ├── app_colors.dart
│   ├── app_images.dart
│   └── text_styles.dart
│
├── logic/
│   └── game_logic.dart
│
├── views/
│   ├── widgets/
│   │
│   ├── game_home.dart
│   ├── select_play_mode.dart
│   ├── select_your_side.dart
│ 
│
└── main.dart

Core:
The core folder contains shared resources used throughout the application:

app_colors.dart — Contains the application's color definitions.
app_images.dart — Contains image-related constants and resources.
text_styles.dart — Contains reusable text styles.

Logic:

The logic folder contains the application's game logic:

game_logic.dart — Handles the main Tic Tac Toe game logic and winning patterns.
Views

The views folder contains the application's screens and UI:

game_home.dart — Main game/home screen.
select_play_mode.dart — Allows the player to choose between playing with a friend or AI.
select_your_side.dart — Allows the player to select X or O.
widgets/ — Contains reusable UI components used throughout the game.

main.dart — The entry point of the Flutter application.
--------------------------------------------------------

# Screenshots

| Select Play mode Page                   | Choose your side page                | Home Page & winner case             |
|-----------------------------------------|--------------------------------------|-------------------------------------|
| ![mode](screenshots/tic1.jpeg)          | ![side](screenshots/tic2.jpeg)       | ![winning](screenshots/tic3.jpeg)   |

| Draw result case                        | 
| ----------------------------------      |
| ![draw](screenshots/draw_result.jpeg)   | 

--------------------------------------------

# Demo Video

🎥 **Application Demo**

[Watch the Tic Tac Toe Demo](https://drive.google.com/file/d/16Rwg74piT8Pbw_F5LC2kq_Ubw0aGmqZK/view?usp=drive_link)

--------------------------------------------------

# Packages Used

This project uses the following Flutter package:

🎉 UI & Animation
confetti - Used to display a simple celebration animation when a player wins.
🎨 Flutter Features
CustomPainter - Used to draw the winning line over the detected winning pattern.
Flutter Widgets - Used to build the game's user interface and interactions
------------------------------------------------------

# Getting Started

Prerequisites:
Before running the project, make sure you have:

Flutter SDK installed.
Dart SDK installed.
Android Studio or Visual Studio Code.
An Android emulator, iOS simulator, or a physical device.

## How to Run the App

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start the app.
------------------------------------------------
# How to Play

Open the application.
Select the preferred game mode:
Play with a Friend
Play with AI
Select your side:
X
O
Start playing Tic Tac Toe.
Complete a winning pattern to win the game.
The winning pattern will be highlighted with a custom-drawn line.
A celebration animation will appear when a player wins.
