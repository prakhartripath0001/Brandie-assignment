# Brandie Assignment - Oriflame Smart Post

A beautiful, high-converting Flutter application built for the Oriflame Community. This project demonstrates immersive social media UI patterns and complex background flows natively integrated with the operating system.

## Key Features

### 1. Smart Post Loading Sequence
A dynamic, 4-step initialization screen (`SmartPostLoadingScreen`) that greets the user when the app starts. It simulates the generation of personalized content using staggered UI updates, progress bars, and a celebratory "All set!" message before routing the user into the main app.

### 2. Immersive "Reels-Style" Feed Overlay
The `SmartPostCard` on the Home Screen is a fully immersive, full-screen `Stack` layout inspired by TikTok and Instagram Reels.
- **Swipeable Carousel:** The background layer is a `PageView` allowing users to horizontally swipe through product images.
- **Dynamic Overlays:** The profile avatar, pagination pills ("1 of 3"), vertical dot indicators, and caption boxes "float" securely on top of the image layer.

### 3. Comprehensive Native Share Architecture
A fully decoupled, backend-ready Share Flow triggered by vibrant social media buttons (Instagram, Facebook, Messenger, TikTok, WhatsApp).
- **Mock API Service:** Simulates network latency when generating a personalized sales link.
- **Blocking Loading Dialog:** Displays a custom `GeneratingLinkDialog` with a progress bar so the user knows exactly what is happening while the link generates.
- **Native OS Handoff:** Uses the `share_plus` package to seamlessly pop open the native iOS/Android share sheet pre-populated with the generated link and caption.

## Project Architecture
The project adheres to clean code principles, separating UI from business logic:
- `/lib/controllers/share_controller.dart`: Orchestrates the sharing logic (UI Blocking -> API -> Native Share).
- `/lib/services/api_service.dart`: A simulated backend service for fetching links.
- `/lib/services/share_service.dart`: A wrapper abstracting the `share_plus` package.
- `/lib/widgets/`: Contains all modularized UI components (`SmartPostCard`, `CustomHeader`, `GeneratingLinkDialog`).

## Getting Started

### Prerequisites
- Flutter SDK (v3.12.2+)
- Android Studio or Xcode (for emulation/device testing)

### Installation
1. Clone the repository.
2. Ensure you have the necessary image assets placed inside the `assets/` directory (e.g., `post1.jpg`).
3. Fetch dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

*Note: Since this app uses `share_plus` which applies the Kotlin Gradle Plugin, you may see background Gradle tasks running on your first Android build. The package version has been updated to fully support Flutter's Built-in Kotlin.*
