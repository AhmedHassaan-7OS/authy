# Motion AI

Motion AI is a Flutter app that combines authentication and AI-powered image analysis in one clean flow.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Supabase Configuration](#supabase-configuration)
- [Screenshots and Demo Video](#screenshots-and-demo-video)
- [Future Improvements](#future-improvements)

## Overview
The app currently includes:
- Authentication with Supabase (`Sign In`, `Sign Up`, `Sign Out`)
- Restore current user session on startup
- Profile editing and avatar upload
- Text extraction from images using Google ML Kit
- Face classification from selected images

## Features
- Auth flow with proper loading/error handling
- Profile management
- AI Text Scan (OCR)
- Face Classifier
- State management with Cubit

## Tech Stack
- `Flutter`
- `flutter_bloc`
- `get_it`
- `supabase_flutter`
- `google_ml_kit`
- `image_picker`

## Architecture
The project follows **Clean Architecture** inside `features/auth` with clear layer separation:

1. `Presentation`
Contains UI and state handling: `views`, `widgets`, `cubit`.

2. `Domain`
Contains business rules and contracts: `entities`, repository contracts, and `usecases`.

3. `Data`
Contains implementations and external integrations: `datasources`, `models`, repository implementations.

4. `Core`
Contains shared modules used across the app: `constants`, `theme`, `utils`, `widgets`.

Flow:
`UI -> Cubit -> UseCase -> Repository (Domain Contract) -> DataSource -> External Service`

## Project Structure
```text
lib/
  core/
    constants/
    theme/
    utils/
    widgets/
  features/
    auth/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        cubit/
        views/
        widgets/
  main.dart
```

## Getting Started
### 1) Prerequisites
- Flutter SDK (compatible with Dart `^3.10.8`)
- Android Studio or VS Code
- Emulator or physical device

### 2) Install dependencies
```bash
flutter pub get
```

### 3) Run the app
```bash
flutter run
```

## Supabase Configuration
Current keys are in:
- `lib/core/constants/supabase_keys.dart`

For production, move secrets out of source code (for example via `--dart-define` or a secure secret manager).

## Screenshots and Demo Video
Use this section to showcase real app usage.

### Screenshots
Put images in:
- `docs/media/screenshots/`

Template:

| Screen | Preview |
|---|---|
| Splash | ![Splash](docs/media/screenshots/splash.png) |
| Sign In | ![Sign In](docs/media/screenshots/sign-in.png) |
| Sign Up | ![Sign Up](docs/media/screenshots/sign-up.png) |
| Home | ![Home](docs/media/screenshots/home.png) |
| Text Scan | ![Text Scan](docs/media/screenshots/text-scan.png) |
| Face Classifier | ![Face Classifier](docs/media/screenshots/face-classifier.png) |
| Profile | ![Profile](docs/media/screenshots/profile.png) |

### Demo Video


https://github.com/user-attachments
![WhatsApp Image 2026-02-11 at 9 16 09 PM](https://github.com/user-attachments/assets/777ef7b0-d6ff-401b-8e6a-01463578dffe)
/assets/55989018-531b-4520-bd09-a81804de6f2a
![2](https://github.com/user-attachments/assets/3c170aec-5a10-4018-8761-c22cef8e1cc4)
![3](https://github.com/user-attachments/assets/2ff9f461-f733-42ae-b160-2cad74da72fa)


If you upload to YouTube or Google Drive, replace the link with your hosted URL.

## Future Improvements
- Add unit and widget tests for Cubits and UseCases
- Move all secrets to runtime config
- Add CI checks (`format`, `analyze`, `test`) before merge
