# Super Cars International — iOS App

Flutter app for [supercars-international.com](https://supercars-international.com):
direct import of 0KM and used vehicles from China to Venezuela and worldwide.

## Features

- **Catálogo** — vehicle grid with brand and 0KM/Usado filters.
- **Del Mes** — featured vehicle of the month (Corolla Levin 1.5L).
- **Cotizar** — quote form that opens WhatsApp with a prefilled message.
- **Nosotros** — company story, guarantees, and coverage.

All content is in Spanish, matching the site. Vehicle data currently lives in
`lib/models.dart` (mirroring the site's catalog).

## Develop

```sh
flutter pub get
flutter analyze
flutter test
flutter run -d <ios-simulator-id>
```

Requires the Flutter SDK (stable) and CocoaPods for iOS builds.
