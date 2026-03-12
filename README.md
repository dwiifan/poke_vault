# Poke Vault

Poke Vault adalah aplikasi Flutter yang menampilkan daftar Pokémon menggunakan **PokeAPI**.  
Aplikasi ini dibuat sebagai **technical assessment Flutter Developer** dengan fokus pada arsitektur bersih, state management, offline storage, dan testing.

---

## Developer

**Dwi Ifan Ramadhan**

---

## Requirement

Sebelum menjalankan aplikasi, pastikan environment berikut tersedia:

- Flutter SDK
- Dart SDK
- Android Studio / VS Code
- Emulator Android

⚠️ **Emulator harus menggunakan Android API 33 atau lebih tinggi**

---

## Features

- Pokémon List (Pagination)
- Pokémon Detail
- Search Pokémon
- Pull to Refresh
- Offline Cache (Hive)
- Shimmer Loading
- Error Handling
- Unit Test

---

## App Preview

### Splash Screen

<img src="docs/splash.png" width="300">

### Home Screen

<img src="docs/home.png" width="300">

---

## Architecture

Project ini menggunakan **Layered Architecture**

---

## Installation

Clone repository:

```bash
git clone https://github.com/yourusername/pokemon_app.git

---

Masuk ke folder project:
    cd pokemon_app

---

Install dependencies:
    flutter pub get

---

Jalankan aplikasi dengan:
    flutter run

⚠️ **Emulator harus menggunakan Android API 33 atau lebih tinggi**

---

Testing :

Menjalankan test
    flutter test test/presentation/providers/pokemon_list_provider_test.dart