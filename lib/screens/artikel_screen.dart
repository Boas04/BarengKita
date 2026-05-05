import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../models/artikel.dart';

class ArtikelScreen extends StatefulWidget {
  const ArtikelScreen({Key? key}) : super(key: key);

  @override
  State<ArtikelScreen> createState() => _ArtikelScreenState();
}

class _ArtikelScreenState extends State<ArtikelScreen> {
  final List<Artikel> artikelList = [
    Artikel(
      judul: 'Memahami Kekerasan Seksual',
      kategori: 'Edukasi',
      deskripsi:
          'Kekerasan seksual adalah tindakan yang memaksa seseorang untuk melakukan kontak seksual yang tidak diinginkan.',
      konten:
          'Kekerasan seksual dapat terjadi dalam berbagai bentuk:\n\n'
          '1. Pelecehan Verbal: Komentar seksual yang tidak pantas\n'
          '2. Pelecehan Fisik: Sentuhan tanpa persetujuan\n'
          '3. Pemerkosaan: Hubungan seksual yang dipaksa\n'
          '4. Kekerasan dalam Pacaran\n\n'
          'Tanda-tanda seseorang menjadi korban:\n'
          '• Perubahan perilaku drastis\n'
          '• Ketakutan saat sendirian\n'
          '• Gangguan tidur atau nafsu makan\n'
          '• Depresi atau kecemasan\n\n'
          'Jika mengalami kekerasan seksual, Anda tidak sendirian dan bukan kesalahan Anda.',
    ),
    Artikel(
      judul: 'Pentingnya Consent (Persetujuan)',
      kategori: 'Edukasi',
      deskripsi:
          'Consent adalah persetujuan yang jelas, sadar, dan sukarela dari semua pihak.',
      konten:
          'Konsep Consent yang Penting Dipahami:\n\n'
          'Apa itu Consent?\n'
          'Consent adalah persetujuan yang diberikan secara sadar, sukarela, dan eksplisit.\n\n'
          'Ciri-ciri Consent yang Sehat:\n'
          '✓ Diberikan secara sukarela (tidak dipaksa)\n'
          '✓ Jelas dan eksplisit\n'
          '✓ Dapat diubah kapan saja\n'
          '✓ Spesifik (consent untuk satu hal ≠ consent untuk semua)\n'
          '✓ Diberikan dalam kondisi sadar penuh\n\n'
          'Apa yang BUKAN Consent:\n'
          '✗ Diam atau tidak menolak\n'
          '✗ Mengatakan "tidak" dengan tubuh tetapi mulut bilang "ya"\n'
          '✗ Karena takut atau terancam\n'
          '✗ Karena mabuk atau terpengaruh obat\n\n'
          'Ingat: Consent harus selalu ada dalam setiap interaksi intim.',
    ),
    Artikel(
      judul: 'Proses Pemulihan dari Trauma',
      kategori: 'Pemulihan',
      deskripsi:
          'Pemulihan adalah perjalanan yang unik untuk setiap individu dengan waktu yang berbeda.',
      konten:
          'Tahap-Tahap Pemulihan:\n\n'
          'Tahap 1: Penerimaan\n'
          'Mulai mengakui apa yang terjadi dan mencari bantuan profesional.\n\n'
          'Tahap 2: Memproses Emosi\n'
          'Berbagi dengan orang terpercaya, konseling, atau journaling.\n\n'
          'Tahap 3: Rekonstruksi\n'
          'Mulai membangun kembali harga diri dan kepercayaan diri.\n\n'
          'Tahap 4: Integrasi\n'
          'Mengintegrasikan pengalaman ke dalam identitas pribadi.\n\n'
          'Tips untuk Pemulihan:\n'
          '• Cari dukungan profesional (psikolog/konselor)\n'
          '• Bergabung dengan kelompok support\n'
          '• Praktik self-care dan mindfulness\n'
          '• Beri diri Anda waktu\n'
          '• Hindari self-blame (bukan kesalahan Anda)\n\n'
          'Ingat: Pemulihan bukan garis lurus, tapi itu mungkin.',
    ),
    Artikel(
      judul: 'Hak-Hak Korban Menurut UU TPKS',
      kategori: 'Hukum',
      deskripsi:
          'Indonesia memiliki Undang-Undang Tindak Pidana Kekerasan Seksual (UU TPKS) yang melindungi korban.',
      konten:
          'Undang-Undang Nomor 12 Tahun 2022 tentang Tindak Pidana Kekerasan Seksual\n\n'
          'Hak Korban:\n'
          '1. Hak atas perlindungan dan keamanan pribadi\n'
          '2. Hak untuk didampingi oleh advokat/kuasa hukum\n'
          '3. Hak privasi dan kerahasiaan identitas\n'
          '4. Hak rehabilitasi medis, psikologis, dan sosial\n'
          '5. Hak atas kompensasi dan restitusi\n'
          '6. Hak untuk didengar dan diakui\n\n'
          'Jenis Kekerasan Seksual Menurut UU TPKS:\n'
          '• Perkosaan\n'
          '• Pelecehan Seksual\n'
          '• Pemaksaan Kontrasepsi\n'
          '• Pemaksaan Aborsi\n'
          '• Penyiksaan Seksual\n\n'
          'Cara Melaporkan:\n'
          '1. Hubungi Kepolisian: 110\n'
          '2. Hubungi P2TP2A (Pusat Pelayanan Terpadu)\n'
          '3. Hubungi LSM Pendamping\n\n'
          'Semua laporan akan ditangani dengan serius dan profesional.',
    ),
    Artikel(
      judul: 'Mendukung Seseorang yang Adalah Korban',
      kategori: 'Dukungan',
      deskripsi:
          'Jika teman atau keluarga Anda adalah korban, berikut cara untuk mendukung mereka.',
      konten:
          'Bagaimana Mendukung Korban Kekerasan Seksual:\n\n'
          'Lakukan:\n'
          '✓ Percayai cerita mereka\n'
          '✓ Dengarkan tanpa menghakimi\n'
          '✓ Validasi perasaan mereka\n'
          '✓ Tanyakan apa yang mereka butuhkan\n'
          '✓ Bantu mereka mencari bantuan profesional\n'
          '✓ Hormati privasi mereka\n'
          '✓ Beri mereka kontrol atas keputusan mereka\n\n'
          'Jangan Lakukan:\n'
          '✗ Menghakimi atau menyalahkan mereka\n'
          '✗ Memaksa mereka untuk melaporkan\n'
          '✗ Berbagi cerita mereka tanpa izin\n'
          '✗ Bertanya detail yang tidak perlu\n'
          '✗ Membuat mereka merasa bersalah\n'
          '✗ Meninggalkan mereka sendirian\n\n'
          'Frasa yang Membantu:\n'
          '"Saya percaya Anda"\n'
          '"Ini bukan kesalahan Anda"\n'
          '"Bagaimana saya bisa membantu?"\n'
          '"Anda tidak sendirian dalam ini"\n\n'
          'Dukungan sosial adalah bagian penting dari pemulihan.',
    ),
    Artikel(
      judul: 'Pencegahan Sejak Dini untuk Anak-Anak',
      kategori: 'Pencegahan',
      deskripsi:
          'Pendidikan tentang body autonomy dan keselamatan dapat mencegah kekerasan seksual.',
      konten:
          'Cara Mengajarkan Anak tentang Keselamatan Pribadi:\n\n'
          '1. Ajarkan Tentang Tubuh Mereka\n'
          '• Gunakan nama yang benar untuk bagian tubuh\n'
          '• Jelaskan bahwa tubuh mereka adalah milik mereka\n'
          '• Ajarkan tentang batasan pribadi\n\n'
          '2. Mengajarkan Consent\n'
          '• Tanya sebelum memeluk atau menyentuh\n'
          '• Hormati ketika anak mengatakan "tidak"\n'
          '• Contohkan consent dalam interaksi sehari-hari\n\n'
          '3. Pelajaran Keselamatan\n'
          '• Ajarkan anak membedakan sentuhan yang pantas dan tidak pantas\n'
          '• Ajarkan anak untuk bercerita jika ada yang tidak pantas\n'
          '• Ciptakan lingkungan di mana anak merasa aman berbicara\n\n'
          '4. Tanda-Tanda yang Perlu Diperhatikan:\n'
          '• Perilaku seksualisasi yang tidak sesuai usia\n'
          '• Ketakutan pada orang tertentu\n'
          '• Perubahan perilaku mendadak\n\n'
          'Pencegahan sejak dini adalah investasi terbaik untuk masa depan yang aman.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artikel & Edukasi'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: artikelList.length,
        itemBuilder: (context, index) {
          final artikel = artikelList[index];
          return _buildArtikelCard(artikel, index);
        },
      ),
    );
  }

  Widget _buildArtikelCard(Artikel artikel, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtikelDetailScreen(artikel: artikel),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(artikel.kategori),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      artikel.kategori,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                artikel.judul,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                artikel.deskripsi,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textLight,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Baca selengkapnya →',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String kategori) {
    switch (kategori.toLowerCase()) {
      case 'edukasi':
        return const Color(0xFF4CAF50);
      case 'pemulihan':
        return const Color(0xFF2196F3);
      case 'hukum':
        return const Color(0xFFF44336);
      case 'dukungan':
        return const Color(0xFFFFC107);
      case 'pencegahan':
        return const Color(0xFF9C27B0);
      default:
        return AppTheme.primaryColor;
    }
  }
}

class ArtikelDetailScreen extends StatelessWidget {
  final Artikel artikel;

  const ArtikelDetailScreen({Key? key, required this.artikel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Artikel'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppTheme.lightBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artikel.judul,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kategori: ${artikel.kategori}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                artikel.konten,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textDark,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
