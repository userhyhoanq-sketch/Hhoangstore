# FF Menu Demo

Standalone SwiftUI UI mockup for iOS 16. It does not connect to or modify Free Fire, and it does not provide cheats or anti-ban protection.

## Build
GitHub Actions workflow builds an unsigned app and packages it as a `.tipa` artifact. Installability may vary with TrollStore/device/toolchain; this is not a signed App Store app.

In GitHub, upload `ContentView.swift`, the `FFMenuDemo.xcodeproj` folder, and `.github/workflows/build.yml` preserving paths. Then open Actions and run “Build TrollStore demo package”. Download the artifact from the completed run.
