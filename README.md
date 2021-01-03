# task_manager_app

Task Manager is a simple application that allows users to keep track of their obligations by setting tasks in the
future. Tasks can be daily tasks, or be set for a specific time in a day.

## Screenshots

<img alt="Home Screen With No Tasks" src="/resources/home_screen_no_daily_tasks.png" width="320"/> <img alt="New Task Screen" src="/resources/new_task_screen.png" width="320"/> 
<img alt="Home Screen" src="/resources/home_screen.png" width="320"/> <img alt="Notification Screen" src="/resources/notification_screen.png" width="320"/> 

## Packages

- `flutter_riverpod` for state management
- `intl` for DateTime formatting

Moor - local database.

- `moor` core package which defines most apis
- `sqlite3_flutter_libs` ships the latest `sqlite3` version with app
- `path_provider` and `path` used to find right location for database
- `moor_generator` generates query code based on tables
- `build_runner` code-generation tool

Notifications

- `flutter_local_notifications` a cross platform plugin for displaying local notifications
- `rxdart` adds additional capabilities to Dart Streams and StreamControllers

## Prerequisites

Make sure you have met the following requirements:

* You have Flutter installed on your machine, if not, you can find it [here](https://flutter.dev).
* You have your IDE of choice with Flutter/Dart plugins (Android Studio / IntelliJ, Visual Studio Code).

## Cloning and running task_manager_app

Based on your IDE, follow these steps:

IntelliJ:

1. On project's github page press the **Code** button and copy the URL
1. In IntelliJ home screen choose `Get from Version Control` option
1. Paste in URL and choose a directory where project should be saved, then press **Clone**
1. When IntelliJ is fully opened, you should run `flutter pub get` command in terminal which points to project's
   directory
1. To run project on an emulator or connected device press **Play** button or run `flutter run` command in terminal

Visual Studio Code ([steps took from here](https://dev.to/adityasingh20/how-to-clone-a-flutter-project-in-vscode-5f7b)):

1. Open VS Code and new window
1. Press `ctrl + shift + p` to make command pallet show
1. Type in Git in the pallet
1. Select the suggested Git:clone option
1. Paste the Git URL in the pallet of the project you have cloned
1. Get dependencies (`flutter pub get`) and run the project (`flutter run`)

## Author

* [Uros Todosijevic](https://github.com/UrosTodosijevic)