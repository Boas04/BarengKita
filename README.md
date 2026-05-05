# BarengKita - Platform Dukungan untuk Korban Kekerasan Seksual

BarengKita adalah aplikasi Flutter yang memberikan dukungan hukum dan psikologis untuk korban kekerasan seksual di Indonesia.

## Fitur Utama

### 1. **Home Screen**
- Tampilan ramah dengan warna ungu muda dan pink soft
- Tombol Darurat (Panic Button) yang responsif
- Quick access ke layanan utama
- Tips keamanan

### 2. **Panic Button (Tombol Darurat)**
- Tekan untuk menghubungi bantuan darurat
- Opsi untuk menghubungi:
  - 110 (Kepolisian)
  - 119 (Hotline Bantuan)
- Interface yang jelas dan mudah dipahami

### 3. **Chatbot Konseling**
- AI chatbot sederhana menggunakan if-else logic
- Menjawab pertanyaan tentang:
  - Tanda-tanda kekerasan seksual
  - Cara melaporkan
  - Dukungan psikologis
  - Hak-hak korban
  - Pencegahan dan edukasi
- Interface percakapan yang user-friendly

### 4. **Peta Bantuan**
- List lembaga bantuan terdekat
- Informasi lembaga:
  - Nama, alamat, nomor telepon
  - Jenis layanan
  - Tombol untuk membuka Maps dan menghubungi
- Data lebih dari 100+ lembaga (dapat diperluas)

### 5. **Artikel Edukasi**
- 6 artikel utama tentang:
  - Memahami kekerasan seksual
  - Pentingnya consent (persetujuan)
  - Proses pemulihan dari trauma
  - Hak-hak korban menurut UU TPKS
  - Cara mendukung korban
  - Pencegahan sejak dini
- Detail lengkap untuk setiap artikel
- Kategori artikel yang jelas

### 6. **Kontak Psikolog**
- Nomor darurat (110, 119, 112)
- Kontak psikolog profesional:
  - Dr. Ikhwanul Ihsan Armalid
  - Gebi Angelina Zahra
  - Iqlima Pratiwi
- Opsi komunikasi: Telepon, WhatsApp, Email
- Informasi mitra kerja (Inside Job IT Solution)
- FAQ tentang layanan

### 7. **Bottom Navigation Bar**
- 5 tab navigasi utama:
  1. Beranda (Home)
  2. Chatbot
  3. Peta Bantuan
  4. Artikel
  5. Kontak

## Persyaratan Teknis

### Minimum Requirements:
- Flutter SDK: 3.0.0+
- Dart SDK: 3.0.0+
- Android SDK: API level 21+
- iOS: 12.0+

### Dependencies:
```yaml
- flutter
- google_maps_flutter: ^2.5.0
- url_launcher: ^6.1.13
- google_fonts: ^6.1.0
- intl: ^0.18.1
```

## Cara Setup dan Menjalankan

### 1. Clone atau Download Project
```bash
cd barengkita_flutter
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Setup Google Maps API (opsional)
Untuk fitur peta yang lengkap, setup Google Maps API:

**Android:**
- Edit `android/app/build.gradle`
- Tambahkan Google Maps API key

**iOS:**
- Edit `ios/Runner/Info.plist`
- Tambahkan Google Maps API key

### 4. Jalankan Aplikasi
```bash
flutter run
```

### 5. Build APK (Android)
```bash
flutter build apk --release
```

### 6. Build IPA (iOS)
```bash
flutter build ios --release
```

## Struktur Project

```
barengkita_flutter/
├── lib/
│   ├── main.dart                 # Entry point aplikasi
│   ├── screens/
│   │   ├── home_screen.dart      # Beranda dengan Panic Button
│   │   ├── chatbot_screen.dart   # Chatbot konseling
│   │   ├── peta_bantuan_screen.dart  # Peta lembaga bantuan
│   │   ├── artikel_screen.dart   # Artikel edukasi
│   │   └── kontak_screen.dart    # Kontak psikolog & darurat
│   ├── models/
│   │   ├── chat_message.dart     # Model pesan chat
│   │   ├── bantuan_lembaga.dart  # Model lembaga bantuan
│   │   └── artikel.dart          # Model artikel
│   └── utils/
│       └── theme.dart            # Tema aplikasi (warna & styling)
├── assets/
│   ├── images/                   # Gambar/ilustrasi
│   ├── icons/                    # Icon custom
│   └── data/                     # Data statis
├── pubspec.yaml                  # Dependencies & konfigurasi
└── README.md                      # Dokumentasi ini
```

## Warna & Design

### Palet Warna:
- **Primary Color (Ungu)**: #9C4B7E
- **Accent Color (Pink Soft)**: #E8B4D0
- **Light Background**: #FAF3F7
- **Text Dark**: #2C2C2C
- **Text Light**: #666666
- **Error**: #E74C3C
- **Success**: #27AE60
- **Warning**: #F39C12

### Design Principle:
- Clean & minimal
- Tidak menakutkan
- User-friendly
- Accessible untuk semua
- Material Design 3

## Pengembangan Lebih Lanjut

### Fitur yang Bisa Ditambahkan:

1. **Firebase Integration**
   - Authentication
   - Real-time database
   - Push notifications

2. **Form Laporan Anonim**
   - Integrasi dengan Google Forms/Spreadsheet
   - Local storage sebelum submit

3. **Offline Mode**
   - SQLite local database
   - Sync ketika online
   - Audio/video recording offline

4. **AI Model TensorFlow Lite**
   - On-device sentiment analysis
   - Chatbot yang lebih canggih
   - Local NLP processing

5. **Maps Integration**
   - Real Google Maps dengan lokasi korban
   - Real-time location sharing
   - Route planning ke lembaga bantuan

6. **Video Calls**
   - Live consultation dengan psikolog
   - Integrasi Jitsi atau Agora

7. **Multimedia Support**
   - Photo/video recording
   - Encryption before upload
   - Cloud storage

8. **Analytics & Reporting**
   - Dashboard untuk lembaga mitra
   - Statistical insights
   - Data visualization

## Kontribusi

Untuk berkontribusi pada project ini:

1. Fork repository
2. Buat branch untuk fitur baru (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

## Lisensi

Project ini dibuat untuk penelitian dan tujuan sosial. Hubungi tim untuk informasi lisensi lebih lanjut.

## Tim Pengembang

**Universitas Negeri Malang - Fakultas Psikologi**

- **Ketua Peneliti**: Dr. Ikhwanul Ihsan Armalid, S.Tr.Sos., M.Psi
- **Anggota Peneliti**: Gebi Angelina Zahra, M.Psi, Psikolog
- **Anggota Peneliti**: Iqlima Pratiwi, S.Psi., M.Si
- **Mahasiswa**: Azalia Davina Putri
- **Mahasiswa**: Ayesha Naura Maritza Arif

**Mitra**: Inside Job (IT Solution)

## Kontak & Support

- Email: ikhwanul.ihsan.fpsi@um.ac.id
- Telepon: 08986059819
- WhatsApp: Hub team untuk info lebih lanjut

---

**Catatan Penting**: Aplikasi ini dibuat dengan dedikasi untuk membantu korban kekerasan seksual di Indonesia. Semua fitur dirancang dengan sensitivitas terhadap trauma dan dengan fokus pada keselamatan serta privasi pengguna.

**Hubungi Nomor Darurat:**
- 110 - Kepolisian
- 119 - Hotline Bantuan
- 112 - Ambulans Darurat
