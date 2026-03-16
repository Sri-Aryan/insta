# 📱 Insta Feed 


## ✨ Key Features

* **Visual Fidelity:** Pixel-perfect replication of the feed, including the Story Tray, standard paddings, and the custom "Billabong" typography.
* **Advanced Gestures (Pinch-to-Zoom Breakout):** Implemented a custom `OverlayEntry` and `Matrix4` math to allow users to pinch-and-zoom images out of their scrolling bounds, snapping back into place seamlessly upon release.
* **Infinite Scrolling & Pagination:** Lazy loading architecture that fetches the next page of posts seamlessly when the user is near the bottom of the feed.
* **Latency Simulation & Shimmer:** Handles mock network latency gracefully using custom structural Shimmer loading skeletons rather than standard spinners.
* **Optimistic UI Updates:** Local, instantaneous state mutations for complex interactions like "Liking" (via double-tap or button) and "Saving".

---

## 🧠 Architecture & State Management

### **State Management Choice: Riverpod**
This application utilizes **Riverpod** (`flutter_riverpod`) for state management. 

**Why Riverpod?**
1. **Compile-Time Safety & Predictability:** Unlike standard `Provider`, Riverpod catches `ProviderNotFound` exceptions at compile-time, ensuring a crash-free dependency tree.
2. **Separation of Concerns:** It completely isolates the data layer (the `PostRepository` with mock latency) from the UI layer. The `FeedNotifier` acts as a pristine bridge, handling pagination logic (`isLoading`, `isFetchingMore`, `currentPage`) entirely outside the widget tree.
3. **Optimistic Mutations:** Riverpod makes it incredibly clean to copy and emit new immutable states. When a user double-taps a post, the `FeedNotifier` instantly updates the specific post's `isLiked` status and like count, triggering localized UI rebuilds without re-fetching data.

### **Folder Structure**
The project follows a clean, feature-separated architecture:
```text
lib/
 ├── models/       # Immutable data classes (User, Post)
 ├── providers/    # Riverpod state notifiers and state classes
 ├── services/     # Mock repositories and API layers
 ├── widgets/      # Reusable UI components (PostCard, PinchZoom, Shimmer)
 ├── screens/      # Top-level screen layouts
 └── main.dart     # App entry point and global theming

```
🚀 How to Run the Build
Follow these instructions to run the project locally.

Prerequisites
Flutter SDK (Version 3.10+ recommended)

Dart SDK

Installation Steps
Clone the repository

```bash
git clone [https://github.com/yourusername/instagram-clone-challenge.git](https://github.com/yourusername/instagram-clone-challenge.git)
cd instagram-clone-challenge
Fetch Dependencies
```

Bash
```
flutter pub get
```

Verify Font Assets
Ensure that the fonts/ directory exists at the root of the project and contains Billabong.ttf. (This is already configured in the pubspec.yaml to ensure the Instagram logo renders correctly).

Run the Application
You can run the app on an emulator, simulator, or physical device.

Bash
```
flutter run
```

