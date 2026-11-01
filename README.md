# Navigation

A Flutter app demonstrating three screens and stack-based navigation with
`Navigator.push`, `MaterialPageRoute`, and `Navigator.pop`.

1. **Home:** View your navigation session name. Select **View session summary** to push the second screen.
2. **Session summary:** Receives the session name through
   constructor arguments. Select **Rename session** to push the third screen.
3. **Rename session:** Edit the name and select **Save name** to pop with a String
   result. Cancel or the back arrow discards the draft.

The summary awaits the rename result and updates its name. Returning to the
home passes that name back too. Each pop reveals the existing previous
screen, preserving its state. Blank names are rejected.

## Navigation troubleshooting

An app-bar/system back action normally pops a route with a null result. This
would lose a saved rename when leaving the summary via those back actions.
The summary uses `PopScope<String>` to return its current name for those paths,
as well as the labeled **Back to home** button. Async callbacks check
`mounted` before changing state. Regression tests cover app-bar and system back,
save, cancel, validation, and returned session names.

## Run and verify

```sh
flutter emulators --launch Pixel_10_Pro
flutter devices
flutter run -d emulator-5554
flutter analyze
flutter test
flutter test integration_test/navigation_test.dart -d emulator-5554
```

Use the device ID reported by `flutter devices` if different. The integration
test installs and runs the app on the device and exercises the three-screen
flow, data passing, save, cancel, and backward navigation.

Verified on November 1, 2026: `flutter analyze` reported no issues, both
widget tests passed, and the integration test passed on the Pixel 10 Pro
Android 17 (API 37) emulator. Disabling the summary's back-result interception
reproduced the lost-name regression; restoring it made the test pass.
