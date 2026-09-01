# 🗣️ Mein Begleiter

> Ein Sprach-Begleiter-Prototyp für ältere Menschen – einfach, klar und mit menschlicher Wärme gestaltet.

![Version](https://img.shields.io/badge/Version-0.2.0-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Status](https://img.shields.io/badge/Status-Prototyp-yellow)

## 📖 Über das Projekt

**Mein Begleiter** ist eine App-Idee für ältere Menschen, die sich einen digitalen Gesprächspartner wünschen. Die Bedienung ist bewusst sehr einfach gehalten: große Schaltflächen, klare Sprache und eine deutliche Kennzeichnung, dass der Begleiter eine KI ist – kein Ersatz für echte menschliche Nähe.

## ✨ Enthalten in V0.2

- 🖥️ Sehr große, einfache Oberfläche
- 🏠 Startseite mit Begrüßung
- 🎙️ Button „Gespräch beginnen“
- 💬 Gesprächsseite mit **echtem Speech-to-Text** (Mikrofon hört wirklich zu und erkennt gesprochene deutsche Sprache)
- ℹ️ Klare Kennzeichnung, dass der Begleiter eine KI ist

## 🚧 Noch nicht enthalten

- [ ] Echte KI-Antwort (Anbindung an Claude API)
- [ ] Text-to-Speech (Antwort wird vorgelesen)
- [ ] Persönliche Memory-Datenbank
- [ ] Benutzerkonto
- [ ] Familien-Dashboard

## 🚀 Erste Schritte

### Voraussetzungen
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installiert

### ⚠️ Wichtig — vor dem ersten Start
Dieses Repository enthält den App-Code (`lib/`, `pubspec.yaml`, `test/`), **aber nicht** die plattformspezifischen Ordner `android/`, `ios/` und `web/`. Diese Ordner müssen von der Flutter-Toolchain selbst erzeugt werden.

```bash
git clone https://github.com/USERNAME/mein-begleiter.git
cd mein-begleiter
flutter create --platforms=android --project-name=mein_begleiter .
flutter pub get
flutter run
```

### APK bauen
```bash
flutter build apk --release
```

### Automatischer Build via GitHub Actions
Bei jedem Push auf `main` baut GitHub Actions automatisch eine APK (siehe `.github/workflows/main.yml`). Die fertige Datei findest du unter dem Tab **Actions** im jeweiligen Run unter **Artifacts**.

## 🗺️ Nächster technischer Schritt

```
Mikrofon → Speech-to-Text ✅ → KI-Antwort (Claude API) → deutsche Sprachausgabe (TTS)
```

## 📁 Projektstruktur

```
mein_begleiter/
├── lib/
│   └── main.dart              # Haupt-App-Logik & UI + Speech-to-Text
├── test/
│   └── widget_test.dart       # Basis-Tests
├── .github/
│   └── workflows/
│       └── main.yml           # Automatischer APK-Build
├── pubspec.yaml
├── analysis_options.yaml
├── .gitignore
├── android/                    # wird per `flutter create .` erzeugt
├── ios/                        # wird per `flutter create .` erzeugt
├── web/                        # wird per `flutter create .` erzeugt
└── README.md
```

## 📝 Lizenz

Noch nicht festgelegt.
