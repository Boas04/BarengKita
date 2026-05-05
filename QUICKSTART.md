# Quick Start Guide - BarengKita

## 🚀 Mulai dalam 5 Langkah

### 1. Install Flutter
```bash
# Download di: https://flutter.dev/docs/get-started/install
# Pastikan Flutter sudah di PATH

flutter --version
```

### 2. Navigate ke Project
```bash
cd barengkita_flutter
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run di Emulator atau Device
```bash
# Cek device yang tersedia
flutter devices

# Run aplikasi
flutter run

# Atau dengan device tertentu
flutter run -d <device_id>
```

### 5. Build untuk Production
```bash
# Android APK
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

---

## 📱 Test Features Secara Manual

### Panic Button
1. Buka app
2. Tekan tombol merah "TOMBOL DARURAT"
3. Pilih nomor: 110 atau 119
4. Sistem akan membuka dialer (di emulator, tampil notifikasi)

### Chatbot
1. Tap tab "Chatbot" di bottom nav
2. Ketik pertanyaan seperti:
   - "apa ciri kekerasan seksual?"
   - "bagaimana cara lapor?"
   - "psikolog mana yang bisa bantu?"
3. Bot akan meresponse secara otomatis

### Peta Bantuan
1. Tap tab "Peta" di bottom nav
2. Lihat list lembaga bantuan
3. Klik "Hubungi" untuk call
4. Klik "Buka Maps" (perlu API key untuk full functionality)

### Artikel
1. Tap tab "Artikel" di bottom nav
2. Scroll untuk lihat 6 artikel edukatif
3. Tap salah satu untuk baca detail lengkap
4. Setiap artikel memiliki informasi komprehensif

### Kontak
1. Tap tab "Kontak" di bottom nav
2. Lihat nomor darurat dengan tombol quick call
3. Lihat kontak psikolog dengan opsi: Call, WhatsApp, Email
4. Scroll untuk lihat FAQ

---

## 🛠 Troubleshooting

### Error: "No devices found"
```bash
# Buat emulator baru atau gunakan device fisik
flutter emulators --launch <emulator_name>

# Atau connect device fisik dan enable USB debugging
```

### Error: "Dependencies not found"
```bash
# Clear dan re-install
flutter clean
flutter pub get
```

### Error: "Build failed"
```bash
# Update Flutter ke versi terbaru
flutter upgrade

# Clean build
flutter clean
flutter pub get
flutter run
```

### App crash di startup
- Pastikan Dart SDK compatible (3.0.0+)
- Check if all dependencies installed: `flutter doctor`

---

## 📦 Project Structure Explanation

```
lib/
├── main.dart
│   └── Entry point, MainNavigator dengan bottom nav
│
├── screens/
│   ├── home_screen.dart
│   │   ├── AppBar dengan judul "BarengKita"
│   │   ├── Header welcome
│   │   ├── Panic Button (animated red button)
│   │   ├── Service cards grid
│   │   └── Safety tips
│   │
│   ├── chatbot_screen.dart
│   │   ├── Chat message list
│   │   ├── Input field + send button
│   │   └── Response logic (if-else)
│   │
│   ├── peta_bantuan_screen.dart
│   │   ├── Search/filter (optional)
│   │   └── List of institutions with contact actions
│   │
│   ├── artikel_screen.dart
│   │   ├── Article list view
│   │   ├── Article detail screen
│   │   └── Category badges
│   │
│   └── kontak_screen.dart
│       ├── Emergency numbers
│       ├── Psychologist contacts
│       ├── Partner info
│       └── FAQ section
│
├── models/
│   ├── chat_message.dart (text, isBot, timestamp)
│   ├── bantuan_lembaga.dart (institution data)
│   └── artikel.dart (article data)
│
└── utils/
    └── theme.dart (colors, text styles, button styles)
```

---

## 🎨 Customization

### Mengubah Warna
Edit `lib/utils/theme.dart`:
```dart
static const Color primaryColor = Color(0xFF9C4B7E); // Ubah hex
static const Color accentColor = Color(0xFFE8B4D0);  // Ubah hex
```

### Menambah Artikel
Edit `lib/screens/artikel_screen.dart`, tambah ke `artikelList`:
```dart
Artikel(
  judul: 'Judul Artikel Baru',
  kategori: 'Kategori',
  deskripsi: 'Deskripsi singkat',
  konten: 'Konten lengkap artikel...',
),
```

### Menambah Lembaga Bantuan
Edit `lib/screens/peta_bantuan_screen.dart`, tambah ke `lembagaBantuan`:
```dart
BantuanLembaga(
  nama: 'Nama Lembaga',
  alamat: 'Alamat Lembaga',
  telepon: '0XXXXXXXXXX',
  layanan: 'Jenis layanan',
  latitude: -7.XXX,
  longitude: 112.XXX,
),
```

### Mengubah Kontak Psikolog
Edit `lib/screens/kontak_screen.dart`, modify contact info dalam method `_buildContactCard`.

---

## 🔄 Next Steps untuk Development

### Phase 1 (Foundation - Done)
- ✅ UI/UX dasar
- ✅ Navigation structure
- ✅ Static content

### Phase 2 (Enhancement)
- Firebase integration
- Form laporan dengan backend
- Push notifications
- Database lokal (SQLite)

### Phase 3 (Advanced)
- TensorFlow Lite chatbot
- Audio/video recording
- Real Google Maps
- Encryption & security

### Phase 4 (Deployment)
- Testing & QA
- App Store & Play Store submission
- Server setup
- Analytics integration

---

## 📞 Support

Untuk pertanyaan atau issue:
1. Check README.md
2. Check troubleshooting section
3. Hubungi tim developer

---

**Happy Coding! 🎉**
