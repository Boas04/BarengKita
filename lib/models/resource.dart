enum ResourceCategory {
  understanding,
  legalRights,
  selfCare,
  supportingOthers,
}

class Resource {
  final String title;
  final String summary;
  final String content;
  final ResourceCategory category;
  final String? sourceUrl;
  final String? imageAsset;

  const Resource({
    required this.title,
    required this.summary,
    required this.content,
    required this.category,
    this.sourceUrl,
    this.imageAsset,
  });

  String get categoryLabel {
    switch (category) {
      case ResourceCategory.understanding:
        return 'Memahami Kekerasan Seksual';
      case ResourceCategory.legalRights:
        return 'Hak Hukum';
      case ResourceCategory.selfCare:
        return 'Perawatan Diri';
      case ResourceCategory.supportingOthers:
        return 'Mendukung Penyintas';
    }
  }
}

final List<Resource> resources = [
  const Resource(
    title: 'Apa itu Kekerasan Seksual?',
    summary:
        'Panduan dasar untuk memahami bentuk-bentuk kekerasan seksual dan dampaknya.',
    content: '''Kekerasan seksual adalah setiap tindakan seksual, upaya untuk mendapatkan tindakan seksual, komentar atau rayuan seksual yang tidak diinginkan, atau tindakan lain yang ditujukan terhadap seksualitas seseorang menggunakan paksaan, ancaman, atau kekuatan fisik, dilakukan oleh siapa saja tanpa memandang hubungannya dengan korban.

**Bentuk-bentuk Kekerasan Seksual:**
• Pelecehan seksual (verbal, non-verbal, fisik)
• Pemerkosaan dan percobaan pemerkosaan
• Eksploitasi seksual
• Kekerasan seksual berbasis siber (KSBS)
• Perkawinan paksa
• Mutilasi genital perempuan

**Dampak pada Korban:**
Kekerasan seksual dapat menimbulkan dampak fisik dan psikologis yang serius, termasuk trauma, PTSD, depresi, dan kecemasan. Setiap korban bereaksi secara berbeda dan semua reaksi adalah valid.

**Ingat:** Kekerasan seksual BUKAN kesalahan korban. Pelaku selalu bertanggung jawab atas tindakannya.''',
    category: ResourceCategory.understanding,
  ),
  const Resource(
    title: 'Hak-Hak Korban Berdasarkan Hukum Indonesia',
    summary:
        'Informasi mengenai UU TPKS 2022 dan hak-hak yang dilindungi hukum.',
    content: '''Undang-Undang Nomor 12 Tahun 2022 tentang Tindak Pidana Kekerasan Seksual (UU TPKS) memberikan perlindungan komprehensif bagi korban kekerasan seksual di Indonesia.

**Hak-Hak Korban:**
• Hak atas penanganan, perlindungan, dan pemulihan
• Hak atas kerahasiaan identitas
• Hak mendapatkan informasi tentang perkembangan kasus
• Hak atas pendampingan hukum secara cuma-cuma
• Hak atas layanan medis dan rehabilitasi
• Hak atas restitusi dari pelaku

**Langkah-Langkah Pelaporan:**
1. Hubungi hotline 129 (SAPA) atau datangi Polres setempat
2. Minta pendampingan dari LSM atau LBH
3. Simpan bukti-bukti yang ada
4. Jalani pemeriksaan visum jika diperlukan

**Unit PPA (Pelayanan Perempuan dan Anak):**
Setiap Polres memiliki Unit PPA yang khusus menangani kasus kekerasan seksual dengan pendekatan yang sensitif gender.''',
    category: ResourceCategory.legalRights,
    sourceUrl: 'https://www.dpr.go.id/jdih/index/id/3397',
  ),
  const Resource(
    title: 'Merawat Diri Setelah Trauma',
    summary:
        'Tips dan panduan self-care untuk penyintas kekerasan seksual dalam proses pemulihan.',
    content: '''Pemulihan dari trauma kekerasan seksual adalah proses yang membutuhkan waktu dan dukungan. Tidak ada cara yang "benar" untuk pulih — setiap perjalanan pemulihan itu unik.

**Perawatan Diri Fisik:**
• Pastikan kebutuhan dasar terpenuhi: makan, tidur, dan minum air
• Olahraga ringan seperti jalan kaki atau yoga dapat membantu
• Hindari alkohol dan zat-zat yang dapat memperburuk trauma
• Kunjungi dokter untuk pemeriksaan kesehatan jika diperlukan

**Perawatan Diri Emosional:**
• Izinkan diri merasakan emosi tanpa menghakimi diri sendiri
• Menulis jurnal dapat membantu memproses perasaan
• Batasi paparan berita atau konten yang memicu trauma
• Lakukan aktivitas yang membawa ketenangan

**Membangun Dukungan:**
• Ceritakan kepada orang yang kamu percaya
• Bergabung dengan support group penyintas
• Pertimbangkan konseling profesional

**Teknik Grounding (saat merasa cemas/panik):**
Coba teknik 5-4-3-2-1:
5 hal yang bisa kamu lihat
4 hal yang bisa kamu sentuh
3 hal yang bisa kamu dengar
2 hal yang bisa kamu cium
1 hal yang bisa kamu rasakan''',
    category: ResourceCategory.selfCare,
  ),
  const Resource(
    title: 'Cara Mendukung Orang yang Kamu Sayangi',
    summary:
        'Panduan untuk keluarga dan teman-teman yang ingin mendukung penyintas.',
    content: '''Jika seseorang yang kamu sayangi mengalami kekerasan seksual, dukunganmu sangat berarti. Berikut cara yang tepat untuk hadir bagi mereka.

**Yang Harus Dilakukan:**
• Dengarkan tanpa menghakimi
• Percayai cerita mereka sepenuhnya
• Tanyakan apa yang mereka butuhkan, jangan berasumsi
• Hormati keputusan mereka, termasuk jika mereka belum siap melapor
• Ingatkan bahwa ini BUKAN kesalahan mereka
• Bantu menghubungkan dengan sumber daya profesional jika diminta

**Yang Harus Dihindari:**
• Jangan tanyakan "Kenapa kamu membiarkan ini terjadi?"
• Jangan katakan "Mungkin kamu salah paham"
• Jangan memaksa untuk cerita lebih banyak
• Jangan menyebarkan informasi tanpa izin
• Jangan membuat keputusan atas nama mereka

**Menjaga Diri Sendiri:**
Mendampingi penyintas bisa melelahkan secara emosional. Pastikan kamu juga merawat diri sendiri dan mencari dukungan jika diperlukan.''',
    category: ResourceCategory.supportingOthers,
  ),
  const Resource(
    title: 'Mengenali Tanda-Tanda Bahaya',
    summary:
        'Pelajari tanda bahaya dalam hubungan dan cara melindungi diri.',
    content: '''Mengenali tanda bahaya (red flags) lebih awal dapat membantu mencegah kekerasan seksual dalam hubungan.

**Tanda Bahaya dalam Hubungan:**
• Pasangan memaksa atau memanipulasi untuk melakukan aktivitas seksual
• Rasa tidak nyaman saat bersamanya namun sulit menolak
• Pasangan tidak menghormati batas (boundaries) yang kamu tetapkan
• Tekanan terus-menerus meski kamu sudah mengatakan "tidak"
• Ancaman atau pemaksaan secara verbal

**Membangun Batasan yang Sehat:**
Setiap orang berhak menentukan batas atas tubuh dan ruang personalnya. "Tidak" adalah kalimat lengkap yang tidak membutuhkan penjelasan.

**Persetujuan (Consent) yang Valid:**
Persetujuan harus:
• Bebas (tanpa paksaan atau tekanan)
• Sadar (tidak dalam kondisi mabuk atau tidak berdaya)
• Spesifik (untuk setiap aktivitas)
• Dapat dicabut kapan saja

**Keselamatan Digital:**
• Hati-hati dengan berbagi foto/video intim
• Kenali risiko sexting dan sextortion
• Blokir dan laporkan konten/pesan yang melecehkan''',
    category: ResourceCategory.understanding,
  ),
];
