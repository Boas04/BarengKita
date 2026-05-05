# BarengKita

Platform Flutter yang menyediakan layanan darurat, konseling, dan sumber daya untuk korban kekerasan seksual di Indonesia.

## Tentang Aplikasi

**BarengKita** hadir sebagai ruang aman digital bagi penyintas dan korban kekerasan seksual. Nama "BarengKita" mencerminkan komitmen bahwa tidak seorang pun harus menghadapi situasi ini sendirian.

## Fitur Utama

### 🆘 Layanan Darurat (Emergency)
- Tombol SOS langsung terhubung ke hotline SAPA 129
- Daftar kontak darurat nasional (Polisi 110, Ambulans 118)
- Informasi layanan pendampingan 24 jam

### 🤝 Konseling
- Direktori organisasi pendukung terpercaya di Indonesia
- Filter layanan online/offline
- Kontak langsung via telepon, email, dan website

### 📚 Sumber Daya
- Artikel edukasi tentang kekerasan seksual
- Panduan hak hukum (UU TPKS 2022)
- Tips perawatan diri pasca-trauma
- Panduan mendukung penyintas

## Teknologi

- **Framework**: Flutter / Dart
- **State Management**: Provider
- **Packages**: url_launcher, google_fonts, shared_preferences

## Menjalankan Aplikasi

### Prasyarat
- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 3.0.0

### Langkah-langkah

```bash
# Clone repositori
git clone https://github.com/Boas04/BarengKita.git
cd BarengKita

# Install dependensi
flutter pub get

# Jalankan aplikasi
flutter run

# Jalankan test
flutter test
```

## Struktur Proyek

```
lib/
├── main.dart              # Entry point & navigasi utama
├── theme/
│   └── app_theme.dart     # Konfigurasi tema dan warna
├── models/
│   ├── emergency_contact.dart  # Model kontak darurat
│   ├── counselor.dart          # Model organisasi konseling
│   └── resource.dart           # Model sumber daya
├── screens/
│   ├── home_screen.dart        # Halaman beranda
│   ├── emergency_screen.dart   # Halaman layanan darurat
│   ├── counseling_screen.dart  # Halaman konseling
│   └── resources_screen.dart   # Halaman sumber daya
└── widgets/
    └── section_header.dart    # Widget header section
test/
├── widget_test.dart    # Widget tests
└── models_test.dart    # Unit tests untuk model data
```

## Kontribusi

Kami menyambut kontribusi dari siapa saja. Silakan buka _issue_ atau _pull request_ untuk perbaikan dan fitur baru.

## Lisensi

MIT License

---

> _"Kamu tidak sendirian. BarengKita ada untuk kamu."_
