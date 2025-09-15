# PawfectCare

Cross‑platform Flutter app for pet owners, veterinarians, and shelter admins. Includes authentication, role‑based dashboards, pet management, medical records, appointments, and a simple store UI.

## Features
- Splash screen → Auth (Signup/Login) → Role selection
- Role‑based dashboards: Pet Owner, Veterinarian, Shelter Admin
- Pet profiles, health records, appointments
- Public profile with editable info and avatar (gallery)
- Store grid (overflow‑safe), product detail view (dummy)
- Local SQLite persistence via `sqflite`

## Tech Stack
- Flutter/Dart (Flutter 3.32, Dart 3.8)
- `sqflite`, `image_picker`, `shimmer`

## Project Structure (key)
- `lib/Authentication/…` — login, signup, splash, role selection
- `lib/Pet_Owner_Screens/…` — owner dashboard, pets, appointments, store
- `lib/Vet_screens/…` — vet dashboard and pages
- `lib/Shelter_screens/…` — shelter dashboard and pages
- `lib/shared/…` — profile, edit profile
- `lib/db_helper.dart` — SQLite schema + queries
- `lib/session.dart` — in‑memory session state

## Setup
1) Prereqs: Flutter SDK, Android Studio/Xcode, device/emulator
2) Install dependencies
   - `cd pawfect_care`
   - `flutter pub get`

## Running
- Debug: `flutter run`
- Choose device: `flutter devices` then `flutter run -d <deviceId>`

## Release Builds
Android APK:
1) Optional: configure release signing
   - Copy `android/key.properties.example` → `android/key.properties`
   - Set `storeFile`, `storePassword`, `keyAlias`, `keyPassword`
2) Build release APK
   - `flutter build apk --release`
   - Output: `build/app/outputs/flutter-apk/app-release.apk`

Android Play Store AAB:
- `flutter build appbundle --release`
- Output: `build/app/outputs/bundle/release/app-release.aab`

iOS (requires macOS):
- Ensure Info.plist contains `NSPhotoLibraryUsageDescription` (already added)
- `flutter build ipa --release` (or via Xcode)

## Android Notes
- Internet permission is enabled in `android/app/src/main/AndroidManifest.xml` for loading network images.
- NDK version is pinned in `android/app/build.gradle.kts` to `27.0.12077973` to satisfy plugins (`image_picker`, `sqflite`).

## App Icon
- Configured via `flutter_launcher_icons` using `assets/icon.png`.
- To regenerate:
  - `dart run flutter_launcher_icons`

## Data + Session
- DB file: `pawfectcare.db` (created via `sqflite`)
- Tables: `users`, `pets`, `health_records`, `appointments`
- Session: `Session.currentUserId`, `Session.currentRole`

## Role Switching
- Change role in Profile → Edit Profile; app reroutes to corresponding dashboard and updates DB/session.

## Screenshots (optional)
- Add to `pages-visual-refrence/` or embed here as needed.

## Submission Checklist
- [ ] Update app name, package id (`applicationId`) in `android/app/build.gradle.kts`
- [ ] Configure release signing (`android/key.properties`) and rebuild
- [ ] Build `app-release.apk` or `app-release.aab`
- [ ] Test on physical device (login, avatar change, store, role change)
- [ ] Prepare store listing text and screenshots

---

## Flowchart (copy into your diagram tool)

Mermaid:

```mermaid
flowchart TD
  A[Splash Screen] --> B{First time?}
  B -- Yes --> C[Sign Up]
  B -- No --> D[Login]
  C --> E[Role Selection]
  D --> E[Role Selection]

  E -->|Pet Owner| F[Owner Dashboard]
  E -->|Veterinarian| G[Vet Dashboard]
  E -->|Shelter Admin| H[Shelter Dashboard]

  subgraph Owner
    F --> F1[Home]
    F --> F2[Pets]
    F --> F3[Appointments]
    F --> F4[Store]
    F --> F5[Profile]
  end

  subgraph Vet
    G --> G1[Dashboard]
    G --> G2[Pets]
    G --> G3[Messages]
    G --> G4[Profile]
  end

  subgraph Shelter
    H --> H1[Home]
    H --> H2[Search]
    H --> H3[Appointments]
    H --> H4[Requests]
    H --> H5[Profile]
  end

  F5 & G4 & H5 --> I[Public Profile]
  I --> J[Edit Profile]
  I --> K[Change Avatar (Gallery)]
  J --> L{Change Role?}
  L -- Yes --> E
  L -- No --> I

  F2 --> M[Add/Edit Pet]
  F3 --> N[Book Appointment]
  F4 --> O[Browse Products]
```

Plain steps:
- Splash → Signup/Login → Role Selection
- Role routes to Owner/Vet/Shelter dashboards
- Profile allows edit info, change avatar, and role switching (reroutes)
- Owner includes Home, Pets, Appointments, Store
- Vet includes Dashboard, Pets, Messages
- Shelter includes Home, Search, Appointments, Requests
