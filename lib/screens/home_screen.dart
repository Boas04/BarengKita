import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chatbot_screen.dart';
import '../utils/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _panicPressed = false;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  // Track which FAQ/tip accordion item is expanded
  int? _expandedTipIndex;

  final List<_ServiceItem> _services = const [
    _ServiceItem(title: 'Bantuan Hukum', subtitle: 'Pendampingan hukum',
      icon: Icons.balance_rounded, iconBg: Color(0xFFEDE9FF), iconColor: Color(0xFF4C3B9E)),
    _ServiceItem(title: 'Konseling Psikologis', subtitle: 'Dukungan emosional',
      icon: Icons.favorite_rounded, iconBg: Color(0xFFFFE9E9), iconColor: Color(0xFFC92B2B)),
    _ServiceItem(title: 'Konseling Online', subtitle: 'Chat aman & terenkripsi',
      icon: Icons.chat_bubble_rounded, iconBg: Color(0xFFE6F4FF), iconColor: Color(0xFF1A6FB8)),
    _ServiceItem(title: 'Ruang Aman', subtitle: 'Komunitas & dukungan',
      icon: Icons.security_rounded, iconBg: Color(0xFFE8F8EF), iconColor: Color(0xFF1A8C4E)),
  ];

  // Exactly 9 articles — perfect 3×3 grid
  final List<_ArticlePreview> _allArticles = const [
    _ArticlePreview(
      title: 'Memahami Kekerasan Seksual', tag: 'Edukasi',
      description: 'Bentuk, tanda, dan langkah awal yang perlu diketahui.',
      icon: Icons.menu_book_rounded,
      gradient: [Color(0xFF6B48FF), Color(0xFF9B7BFF)],
      detail: 'Kekerasan seksual tidak selalu berbentuk fisik. Ia juga bisa berupa komentar, ancaman, tekanan, atau tindakan yang membuat seseorang tidak nyaman. Jika kamu melihat tanda-tandanya, yang paling penting adalah memastikan keselamatan dulu, lalu cari bantuan dari orang terpercaya atau layanan profesional.',
    ),
    _ArticlePreview(
      title: 'Hak Korban UU TPKS', tag: 'Hukum',
      description: 'Pahami hak-hak yang dilindungi undang-undang.',
      icon: Icons.gavel_rounded,
      gradient: [Color(0xFF1A6FB8), Color(0xFF4DAFFF)],
      detail: 'UU TPKS No. 12 Tahun 2022 memberikan perlindungan nyata bagi korban. Setiap korban berhak mendapatkan perlindungan, pendampingan hukum, rehabilitasi psikologis, dan kompensasi. Identitas korban wajib dijaga kerahasiaannya sepanjang proses hukum berlangsung.',
    ),
    _ArticlePreview(
      title: 'Pentingnya Consent', tag: 'Edukasi',
      description: 'Batasan dan persetujuan yang wajib dipahami.',
      icon: Icons.volunteer_activism_rounded,
      gradient: [Color(0xFFE84040), Color(0xFFFF8C69)],
      detail: 'Consent berarti persetujuan yang jelas, sadar, dan sukarela. Persetujuan bisa ditarik kapan saja. Kalau seseorang diam, takut, tertekan, atau tidak sadar penuh — itu bukan consent.',
    ),
    _ArticlePreview(
      title: 'Pemulihan Trauma', tag: 'Pemulihan',
      description: 'Langkah kecil menuju rasa aman.',
      icon: Icons.spa_rounded,
      gradient: [Color(0xFF1A8C4E), Color(0xFF4DCC88)],
      detail: 'Pemulihan trauma tidak berjalan lurus. Ada hari ringan, ada hari berat. Langkah kecil seperti tidur cukup, bicara dengan orang aman, dan bertemu psikolog membantu proses pulih berjalan lebih stabil.',
    ),
    _ArticlePreview(
      title: 'Cara Melapor Aman', tag: 'Panduan',
      description: 'Langkah-langkah melapor yang mudah dipahami.',
      icon: Icons.report_rounded,
      gradient: [Color(0xFFE8923A), Color(0xFFFFBD59)],
      detail: 'Melapor adalah langkah berani. Kamu bisa melapor ke polisi (110), hotline (119), P2TP2A, atau lewat aplikasi ini secara anonim. Semua laporan dijaga kerahasiaannya dan ditangani dengan serius.',
    ),
    _ArticlePreview(
      title: 'Dampak Psikologis KS', tag: 'Psikologi',
      description: 'Memahami apa yang dirasakan korban.',
      icon: Icons.psychology_rounded,
      gradient: [Color(0xFF9B3DB8), Color(0xFFD08BFF)],
      detail: 'Korban kekerasan seksual dapat mengalami PTSD, depresi, kecemasan, dan penurunan harga diri. Memahami dampak ini penting agar korban tidak merasa sendirian dan segera mendapatkan bantuan profesional.',
    ),
    _ArticlePreview(
      title: 'Dukung Orang Terdekat', tag: 'Dukungan',
      description: 'Cara hadir untuk korban dengan tepat.',
      icon: Icons.people_rounded,
      gradient: [Color(0xFFC92B6A), Color(0xFFFF7BAA)],
      detail: 'Percayai cerita mereka, dengarkan tanpa menghakimi, dan validasi perasaan mereka. Jangan paksa mereka untuk melapor. Frasa sederhana seperti "Saya percaya kamu" bisa sangat berarti.',
    ),
    _ArticlePreview(
      title: 'Pencegahan pada Anak', tag: 'Pencegahan',
      description: 'Edukasi body autonomy sejak kecil.',
      icon: Icons.child_care_rounded,
      gradient: [Color(0xFF2D7DD2), Color(0xFF72C3FF)],
      detail: 'Ajarkan anak tentang batasan tubuh sejak dini. Gunakan nama yang benar untuk bagian tubuh, ajarkan bahwa tubuh mereka adalah milik mereka, dan ciptakan lingkungan di mana anak merasa aman untuk berbicara.',
    ),
    _ArticlePreview(
      title: 'Keamanan Digital', tag: 'Tips',
      description: 'Lindungi privasi dan data pribadimu.',
      icon: Icons.shield_rounded,
      gradient: [Color(0xFF3D6B4F), Color(0xFF6DBF8A)],
      detail: 'Di era digital, privasi sangat penting. Gunakan aplikasi terenkripsi, hindari berbagi lokasi real-time, dan waspada terhadap jejak digital. Aplikasi BARENGKITA menggunakan enkripsi end-to-end untuk menjaga keamanan datamu.',
    ),
  ];

  // Tips as FAQ accordion — with longer body text for the expanded state
  final List<_TipItem> _tips = const [
    _TipItem(
      icon: Icons.shield_rounded, color: Color(0xFF4C3B9E),
      title: 'Anda Tidak Sendirian',
      body: 'Selalu ada yang siap mendengar dan membantu kapanpun Anda membutuhkan. Tim kami tersedia 24 jam sehari, 7 hari seminggu untuk memberikan dukungan yang Anda butuhkan.'),
    _TipItem(
      icon: Icons.lock_rounded, color: Color(0xFF1A6FB8),
      title: 'Privasi Terjamin',
      body: 'Semua data dienkripsi dengan standar keamanan tinggi. Laporan dapat dibuat secara anonim sepenuhnya. Identitas Anda tidak akan pernah kami bagikan kepada pihak manapun tanpa izin eksplisit dari Anda.'),
    _TipItem(
      icon: Icons.favorite_rounded, color: Color(0xFFC92B2B),
      title: 'Minta Bantuan = Berani',
      body: 'Meminta bantuan adalah langkah paling berani yang bisa kamu ambil. Tidak ada yang perlu dihadapi sendirian. Mencari pertolongan adalah tanda kekuatan, bukan kelemahan.'),
    _TipItem(
      icon: Icons.verified_rounded, color: Color(0xFF1A8C4E),
      title: 'Bukan Salah Anda',
      body: 'Kekerasan seksual tidak pernah menjadi kesalahan korban. Apapun yang terjadi, Anda tidak bersalah. Kami percaya dan mendukung Anda sepenuhnya dalam proses pemulihan ini.'),
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  Future<void> _callPolice() async {
    try { await launchUrl(Uri.parse('tel:110')); } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tidak bisa melakukan panggilan')));
    }
  }

  Future<void> _callHotline() async {
    try { await launchUrl(Uri.parse('tel:119')); } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tidak bisa melakukan panggilan')));
    }
  }

  Future<void> _contactViaWhatsApp() async {
    const phoneNumber = '6281230136868';
    final url = 'https://wa.me/$phoneNumber?text=Halo, saya butuh bantuan segera';
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tidak bisa membuka WhatsApp')));
    }
  }

  void _showPanicDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Bantuan Darurat', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        content: Text('Pilih nomor yang ingin dihubungi:\n\n110 - Kepolisian\n119 - Hotline Bantuan',
          style: GoogleFonts.dmSans()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          FilledButton.tonal(
            onPressed: () { Navigator.pop(context); _callHotline(); },
            child: const Text('119')),
          FilledButton(
            onPressed: () { Navigator.pop(context); _callPolice(); },
            style: FilledButton.styleFrom(backgroundColor: AppTheme.errorColor),
            child: const Text('110')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Transform.translate(
              offset: const Offset(0, -14),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildPanicButton(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Layanan Kami', showSeeAll: false),
                  const SizedBox(height: 10),
                  // Services fill full width horizontally
                  _buildServicesRow(),
                  const SizedBox(height: 22),
                  _buildSectionHeader('Info & Artikel', showSeeAll: false),
                  const SizedBox(height: 10),
                  _buildArticleSection(),
                  const SizedBox(height: 22),
                  _buildTipsSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4C3B9E),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatbotScreen())),
        child: const Icon(Icons.chat_bubble_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2D1F6B), Color(0xFF4C3B9E), Color(0xFF7C5CC6)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      child: Stack(children: [
        Positioned(top: -40, right: -40,
          child: Container(width: 180, height: 180,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), shape: BoxShape.circle))),
        Positioned(bottom: -58, left: 90,
          child: Container(width: 220, height: 220,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), shape: BoxShape.circle))),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                width: 34, height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.30))),
                child: Icon(Icons.shield_rounded, size: 18, color: Colors.white.withOpacity(0.92))),
              const SizedBox(width: 9),
              Text('BarengKita', style: GoogleFonts.plusJakartaSans(
                fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.2)),
            ]),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 6, height: 6,
                  decoration: const BoxDecoration(color: Color(0xFFA8F0C6), shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text('Layanan 24/7 · Anonim · Aman',
                  style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.85), letterSpacing: 0.2)),
              ]),
            ),
            const SizedBox(height: 12),
            Text('Halo, Kami\ndi Sini untuk Anda',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2, letterSpacing: -0.5)),
            const SizedBox(height: 7),
            Text('Dukungan hukum & psikologis terpercaya untuk korban kekerasan seksual.',
              style: GoogleFonts.dmSans(fontSize: 12.8, color: Colors.white.withOpacity(0.72), height: 1.5)),
          ]),
        ),
      ]),
    );
  }

  Widget _buildPanicButton() {
    return GestureDetector(
      onTapDown: (_) => setState(() => _panicPressed = true),
      onTapUp: (_) { setState(() => _panicPressed = false); _showPanicDialog(); },
      onTapCancel: () => setState(() => _panicPressed = false),
      child: AnimatedBuilder(
        animation: _pulseAnim,
        builder: (_, child) => Transform.scale(scale: _panicPressed ? 0.97 : _pulseAnim.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE84040), Color(0xFFC92B2B)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [BoxShadow(
              color: const Color(0xFFC92B2B).withOpacity(_panicPressed ? 0.45 : 0.32),
              blurRadius: _panicPressed ? 28 : 20, offset: const Offset(0, 6))],
          ),
          child: Row(children: [
            Container(width: 40, height: 40,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.16), shape: BoxShape.circle),
              child: const Icon(Icons.call_rounded, color: Colors.white, size: 20)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text('TOMBOL DARURAT', style: GoogleFonts.plusJakartaSans(
                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.3)),
              const SizedBox(height: 2),
              Text('110 Polisi · 119 Hotline', style: GoogleFonts.dmSans(
                fontSize: 11, color: Colors.white.withOpacity(0.80))),
            ])),
            Container(width: 26, height: 26,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.16), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 17)),
          ]),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showSeeAll = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: GoogleFonts.plusJakartaSans(
          fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.textDark, letterSpacing: -0.3)),
        if (showSeeAll)
          Text('Lihat semua', style: GoogleFonts.dmSans(
            fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF4C3B9E))),
      ],
    );
  }

  // ── Services: fill full width, evenly spaced side-by-side ────────────────
  Widget _buildServicesRow() {
    return SizedBox(
      height: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _services.asMap().entries.map((entry) {
          final i = entry.key;
          final s = entry.value;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: i == 0 ? 0 : 7),
              child: _buildServiceCard(s),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildServiceCard(_ServiceItem s) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3))]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: s.iconBg, borderRadius: BorderRadius.circular(9)),
            child: Icon(s.icon, color: s.iconColor, size: 16)),
          const SizedBox(height: 6),
          Text(
            s.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10, fontWeight: FontWeight.w700,
              color: AppTheme.textDark, height: 1.2)),
          const SizedBox(height: 4),
          Container(height: 2, width: 14,
            decoration: BoxDecoration(color: s.iconColor, borderRadius: BorderRadius.circular(2))),
        ],
      ),
    );
  }

  // ── Article Section — strict 3×3 (9 items, hardcoded) ────────────────────
  Widget _buildArticleSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Each card: fixed height of 110px regardless of screen width
        const double cardHeight = 110.0;
        final double cardWidth = (constraints.maxWidth - 16) / 3; // 2 gaps × 8px
        final double aspectRatio = cardWidth / cardHeight;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: aspectRatio,
          ),
          itemCount: 9,
          itemBuilder: (_, i) => _buildArticleCard(_allArticles[i]),
        );
      },
    );
  }

  Widget _buildArticleCard(_ArticlePreview article) {
    return GestureDetector(
      onTap: () => _showArticleDetail(article),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: article.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [BoxShadow(
            color: article.gradient[0].withOpacity(0.22),
            blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Decorative icon watermark bottom-right
            Positioned(
              right: -8, bottom: -8,
              child: Icon(article.icon, size: 46, color: Colors.white.withOpacity(0.12)),
            ),
            Padding(
              padding: const EdgeInsets.all(9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      article.tag,
                      style: GoogleFonts.dmSans(
                        fontSize: 8, fontWeight: FontWeight.w700,
                        color: Colors.white, letterSpacing: 0.1)),
                  ),
                  // Title
                  Text(
                    article.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.5, fontWeight: FontWeight.w800,
                      color: Colors.white, height: 1.25, letterSpacing: -0.2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Tips Section — FAQ accordion (like image 2) ───────────────────────────
  Widget _buildTipsSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Section header
      Row(children: [
        Container(
          width: 8, height: 8,
          decoration: const BoxDecoration(color: Color(0xFF4C3B9E), shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text('Pertanyaan Umum', style: GoogleFonts.plusJakartaSans(
          fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textDark, letterSpacing: -0.3)),
      ]),
      const SizedBox(height: 12),
      // Accordion items
      ...List.generate(_tips.length, (i) => _buildAccordionItem(i)),
      const SizedBox(height: 14),
      // CTA Banner
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2D1F6B), Color(0xFF4C3B9E)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(
            color: const Color(0xFF4C3B9E).withOpacity(0.30),
            blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Butuh Bantuan\nSekarang?', style: GoogleFonts.plusJakartaSans(
              fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2)),
            const SizedBox(height: 4),
            Text('Kami siap membantu kapanpun.',
              style: GoogleFonts.dmSans(fontSize: 11.5, color: Colors.white.withOpacity(0.72))),
          ])),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _contactViaWhatsApp,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Text('Hubungi', style: GoogleFonts.plusJakartaSans(
                fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF4C3B9E)))),
          ),
        ]),
      ),
    ]);
  }

  Widget _buildAccordionItem(int index) {
    final tip = _tips[index];
    final bool isExpanded = _expandedTipIndex == index;

    return GestureDetector(
      onTap: () => setState(() {
        _expandedTipIndex = isExpanded ? null : index;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isExpanded ? tip.color.withOpacity(0.22) : Colors.black.withOpacity(0.07),
            width: isExpanded ? 1.2 : 0.8,
          ),
          boxShadow: [BoxShadow(
            color: isExpanded ? tip.color.withOpacity(0.07) : Colors.black.withOpacity(0.035),
            blurRadius: isExpanded ? 12 : 4,
            offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            // Header row — always visible
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  // Colored icon pill
                  Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                      color: tip.color.withOpacity(0.10),
                      shape: BoxShape.circle),
                    child: Icon(tip.icon, size: 14, color: tip.color)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tip.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5, fontWeight: FontWeight.w700,
                        color: AppTheme.textDark, letterSpacing: -0.1)),
                  ),
                  // Animated chevron
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: isExpanded ? tip.color : AppTheme.textLight)),
                ],
              ),
            ),
            // Expandable body
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity, height: 0),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(56, 0, 14, 14),
                child: Text(
                  tip.body,
                  style: GoogleFonts.dmSans(
                    fontSize: 12.5, color: AppTheme.textMedium, height: 1.65)),
              ),
              crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 220),
            ),
          ],
        ),
      ),
    );
  }

  void _showArticleDetail(_ArticlePreview article) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.76,
        minChildSize: 0.58,
        maxChildSize: 0.94,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: Container(
                width: 46, height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textLight.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(99)))),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: article.gradient,
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(22)),
                child: Row(children: [
                  Container(
                    width: 52, height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18), shape: BoxShape.circle),
                    child: Icon(article.icon, color: Colors.white, size: 28)),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                      child: Text(article.tag, style: GoogleFonts.dmSans(
                        fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white))),
                    const SizedBox(height: 6),
                    Text(article.title.replaceAll('\n', ' '),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2)),
                  ])),
                ])),
              const SizedBox(height: 20),
              Text(article.description, style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5, fontWeight: FontWeight.w700, color: AppTheme.textDark, height: 1.5)),
              const SizedBox(height: 10),
              Text(article.detail, style: GoogleFonts.dmSans(
                fontSize: 12.5, color: AppTheme.textMedium, height: 1.75)),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EEFF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF4C3B9E).withOpacity(0.15))),
                child: Row(children: [
                  const Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFF4C3B9E)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(
                    'Butuh bantuan cepat? Gunakan Tombol Darurat atau Chatbot di beranda.',
                    style: GoogleFonts.dmSans(fontSize: 11.5, color: const Color(0xFF4C3B9E), height: 1.5))),
                ]),
              ),
              const SizedBox(height: 14),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: const Color(0xFF4C3B9E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                child: Text('Tutup', style: GoogleFonts.plusJakartaSans(
                  fontSize: 13, fontWeight: FontWeight.w700))),
            ]),
          ),
        ),
      ),
    );
  }
}

class _ServiceItem {
  final String title, subtitle;
  final IconData icon;
  final Color iconBg, iconColor;
  const _ServiceItem({required this.title, required this.subtitle,
    required this.icon, required this.iconBg, required this.iconColor});
}

class _ArticlePreview {
  final String title, tag, description, detail;
  final IconData icon;
  final List<Color> gradient;
  const _ArticlePreview({required this.title, required this.tag,
    required this.description, required this.icon,
    required this.gradient, required this.detail});
}

class _TipItem {
  final IconData icon;
  final Color color;
  final String title, body;
  const _TipItem({required this.icon, required this.color,
    required this.title, required this.body});
}