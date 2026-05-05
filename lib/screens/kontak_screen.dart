import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme.dart';

class KontakScreen extends StatelessWidget {
  const KontakScreen({Key? key}) : super(key: key);

  Future<void> _launchWhatsApp(String phoneNumber, String message) async {
    final String url =
        'https://wa.me/62${phoneNumber.replaceFirst('0', '')}?text=${Uri.encodeComponent(message)}';
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {}
  }

  Future<void> _launchEmail(String email) async {
    try {
      await launchUrl(Uri.parse('mailto:$email'));
    } catch (e) {}
  }

  Future<void> _launchPhone(String number) async {
    try {
      await launchUrl(Uri.parse('tel:$number'));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: CustomScrollView(
        slivers: [
          // ── SliverAppBar — satu title aja di kiri atas ──────────
          SliverAppBar(
            expandedHeight: 190,
            pinned: true,
            stretch: true,
            backgroundColor: const Color(0xFF2D1F6B),
            title: const SizedBox.shrink(), // hapus title tengah
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2D1F6B), Color(0xFF4C3B9E), Color(0xFF7C5CC6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(children: [
                  Positioned(top: -30, right: -30,
                    child: Container(width: 160, height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06), shape: BoxShape.circle))),
                  Positioned(bottom: -40, left: 60,
                    child: Container(width: 180, height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04), shape: BoxShape.circle))),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          Row(children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.support_agent_rounded,
                                color: Colors.white, size: 20)),
                            const SizedBox(width: 10),
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('Hubungi Kami',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 20, fontWeight: FontWeight.w800,
                                  color: Colors.white, letterSpacing: -0.3)),
                              Text('Kami siap membantu Anda 24/7',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11.5,
                                  color: Colors.white.withOpacity(0.72))),
                            ]),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Nomor Darurat ────────────────────────────
                  _SectionTitle(title: '🚨 Nomor Darurat'),
                  const SizedBox(height: 4),
                  Text('Tap untuk melihat penjelasan',
                    style: GoogleFonts.dmSans(
                      fontSize: 11.5, color: AppTheme.textLight)),
                  const SizedBox(height: 12),
                  _ExpandableEmergency(
                    nomor: '110',
                    judul: 'Kepolisian',
                    icon: Icons.local_police_rounded,
                    color: AppTheme.errorColor,
                    penjelasan: 'Hubungi Polisi untuk melaporkan tindak kekerasan seksual. Tim profesional siap membantu dan mendokumentasikan laporan Anda dengan baik.',
                  ),
                  const SizedBox(height: 10),
                  _ExpandableEmergency(
                    nomor: '119',
                    judul: 'Hotline Bantuan',
                    icon: Icons.headset_mic_rounded,
                    color: AppTheme.warningColor,
                    penjelasan: 'Layanan hotline 24 jam untuk konsultasi dan dukungan emosional. Staf yang terlatih siap mendengarkan dan memberikan panduan Anda kapan saja.',
                  ),
                  const SizedBox(height: 10),
                  _ExpandableEmergency(
                    nomor: '112',
                    judul: 'Ambulans Darurat',
                    icon: Icons.medical_services_rounded,
                    color: AppTheme.primaryColor,
                    penjelasan: 'Hubungi layanan ambulans untuk situasi darurat medis. Mereka akan memberikan bantuan cepat dan membawa Anda ke fasilitas kesehatan terdekat.',
                  ),

                  const SizedBox(height: 28),

                  // ── Kontak Psikolog ──────────────────────────
                  _SectionTitle(title: '👩‍⚕️ Kontak Psikolog'),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    nama: 'Ikhwanul Ihsan Armalid',
                    posisi: 'Ketua Peneliti & Psikolog',
                    telepon: '08986059819',
                    email: 'ikhwanul.ihsan.fpsi@um.ac.id',
                    avatarEmoji: '👨‍🔬',
                    onWa: _launchWhatsApp,
                    onEmail: _launchEmail,
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    nama: 'Gebi Angelina Zahra',
                    posisi: 'Psikolog Klinis',
                    telepon: '08987654321',
                    email: 'gebi.angelina@um.ac.id',
                    avatarEmoji: '👩‍⚕️',
                    onWa: _launchWhatsApp,
                    onEmail: _launchEmail,
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    nama: 'Iqlima Pratiwi',
                    posisi: 'Praktisi Psikologi',
                    telepon: '08976543210',
                    email: 'iqlima.pratiwi@um.ac.id',
                    avatarEmoji: '👩‍💼',
                    onWa: _launchWhatsApp,
                    onEmail: _launchEmail,
                  ),

                  const SizedBox(height: 28),

                  // ── Lembaga Mitra ────────────────────────────
                  _SectionTitle(title: '🤝 Lembaga Mitra'),
                  const SizedBox(height: 12),
                  _buildPartnerCard(
                    nama: 'Inside Job IT Solution',
                    alamat: 'Kalibata City, Tower Jasmine\nRT.9/RW.2, Rawajati, Jakarta Selatan',
                    icon: Icons.business_center_rounded,
                  ),

                  const SizedBox(height: 28),

                  // ── FAQ ──────────────────────────────────────
                  _SectionTitle(title: '❓ Pertanyaan Umum'),
                  const SizedBox(height: 12),
                  _buildFAQCard(
                    pertanyaan: 'Bagaimana cara melaporkan?',
                    jawaban: '1. Form laporan anonim di aplikasi\n2. Hubungi Polisi: 110\n3. Hubungi Hotline: 119\n4. Datang ke P2TP2A terdekat',
                  ),
                  const SizedBox(height: 10),
                  _buildFAQCard(
                    pertanyaan: 'Apakah privasi saya terjamin?',
                    jawaban: 'Ya! Semua data terenkripsi, laporan dapat dibuat anonim, dan informasi pribadi tidak dibagikan kepada siapapun.',
                  ),
                  const SizedBox(height: 10),
                  _buildFAQCard(
                    pertanyaan: 'Biaya layanan konseling?',
                    jawaban: 'Layanan kami 100% GRATIS untuk semua korban kekerasan seksual.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  // ── Contact Card — hanya WA + Email ──────────────────────────────────────
  Widget _buildContactCard({
    required String nama,
    required String posisi,
    required String telepon,
    required String email,
    required String avatarEmoji,
    required Function(String, String) onWa,
    required Function(String) onEmail,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          // Avatar
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.07),
              borderRadius: BorderRadius.circular(14)),
            child: Center(
              child: Text(avatarEmoji,
                style: const TextStyle(fontSize: 26)))),
          const SizedBox(width: 12),
          // Name + badge
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nama, style: GoogleFonts.plusJakartaSans(
                fontSize: 13, fontWeight: FontWeight.w700,
                color: AppTheme.textDark)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(8)),
                child: Text(posisi, style: GoogleFonts.plusJakartaSans(
                  fontSize: 10, fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor))),
            ],
          )),
          const SizedBox(width: 10),
          // WA button
          GestureDetector(
            onTap: () => onWa(telepon, 'Halo, saya ingin berkonsultasi'),
            child: Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF25D366).withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF25D366).withOpacity(0.25))),
              child: Center(child: _WhatsAppIcon())),
          ),
          const SizedBox(width: 8),
          // Email button
          GestureDetector(
            onTap: () => onEmail(email),
            child: Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEA4335).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFEA4335).withOpacity(0.20))),
              child: const Icon(Icons.mail_rounded,
                color: Color(0xFFEA4335), size: 20))),
        ]),
      ),
    );
  }

  // ── Partner Card ──────────────────────────────────────────────────────────
  Widget _buildPartnerCard({
    required String nama,
    required String alamat,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF3EEFF), Color(0xFFEAE0FF)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.15))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(13)),
            child: Icon(icon, color: AppTheme.primaryColor, size: 22)),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nama, style: GoogleFonts.plusJakartaSans(
                fontSize: 13, fontWeight: FontWeight.w700,
                color: AppTheme.textDark)),
              const SizedBox(height: 4),
              Text(alamat, style: GoogleFonts.dmSans(
                fontSize: 11, color: AppTheme.textLight, height: 1.5)),
            ],
          )),
        ]),
      ),
    );
  }

  Widget _buildFAQCard({
    required String pertanyaan,
    required String jawaban,
  }) {
    return _ExpandableFAQ(pertanyaan: pertanyaan, jawaban: jawaban);
  }
}

// ── Custom WhatsApp Icon (SVG-like shape biar proper) ─────────────────────────
class _WhatsAppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22, height: 22,
      child: CustomPaint(painter: _WAPainter()),
    );
  }
}

class _WAPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF25D366)
      ..style = PaintingStyle.fill;

    // Outer circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    // Phone handset shape — white
    final phonePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Simple speech bubble phone icon
    path.moveTo(cx - 3.5, cy + 4);
    path.cubicTo(cx - 5, cy + 2, cx - 5, cy - 1, cx - 3, cy - 2);
    path.cubicTo(cx - 2, cy - 2.5, cx - 1, cy - 1.5, cx - 1, cy - 0.5);
    path.cubicTo(cx - 1, cy + 0.5, cx - 2, cy + 1, cx - 1.5, cy + 2);
    path.cubicTo(cx, cy + 4, cx + 3, cy + 4.5, cx + 4, cy + 3);
    path.cubicTo(cx + 5, cy + 1.5, cx + 4.5, cy, cx + 3.5, cy);
    path.cubicTo(cx + 2.5, cy, cx + 2, cy + 1, cx + 1.5, cy);
    path.cubicTo(cx + 1, cy - 1, cx + 2, cy - 4, cx + 3, cy - 3.5);
    path.cubicTo(cx + 5, cy - 2.5, cx + 5, cy + 1, cx + 3.5, cy + 4);

    canvas.drawPath(path, phonePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Expandable FAQ ────────────────────────────────────────────────────────────
class _ExpandableFAQ extends StatefulWidget {
  final String pertanyaan;
  final String jawaban;
  const _ExpandableFAQ({required this.pertanyaan, required this.jawaban});

  @override
  State<_ExpandableFAQ> createState() => _ExpandableFAQState();
}

class _ExpandableFAQState extends State<_ExpandableFAQ>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _ctrl;
  late Animation<double> _rotate;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _rotate = Tween<double>(begin: 0, end: 0.5).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _expanded = !_expanded);
        _expanded ? _ctrl.forward() : _ctrl.reverse();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppTheme.cardShadow,
          border: _expanded
              ? Border.all(color: AppTheme.primaryColor.withOpacity(0.25), width: 1.5)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.help_outline_rounded,
                    color: AppTheme.primaryColor, size: 16)),
                const SizedBox(width: 10),
                Expanded(child: Text(widget.pertanyaan,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700, fontSize: 13,
                    color: AppTheme.textDark))),
                RotationTransition(
                  turns: _rotate,
                  child: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.primaryColor)),
              ]),
              if (_expanded) ...[
                const SizedBox(height: 10),
                Container(height: 1,
                  color: AppTheme.primaryColor.withOpacity(0.10)),
                const SizedBox(height: 10),
                Text(widget.jawaban, style: GoogleFonts.dmSans(
                  fontSize: 12.5, color: AppTheme.textMedium, height: 1.65)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Expandable Emergency Card ──────────────────────────────────────────────────
class _ExpandableEmergency extends StatefulWidget {
  final String nomor;
  final String judul;
  final IconData icon;
  final Color color;
  final String penjelasan;

  const _ExpandableEmergency({
    required this.nomor,
    required this.judul,
    required this.icon,
    required this.color,
    required this.penjelasan,
  });

  @override
  State<_ExpandableEmergency> createState() => _ExpandableEmergencyState();
}

class _ExpandableEmergencyState extends State<_ExpandableEmergency>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _ctrl;
  late Animation<double> _rotate;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _rotate = Tween<double>(begin: 0, end: 0.5).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _expanded = !_expanded);
        _expanded ? _ctrl.forward() : _ctrl.reverse();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppTheme.cardShadow,
          border: _expanded
              ? Border.all(color: widget.color.withOpacity(0.25), width: 1.5)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(14)),
                  child: Icon(widget.icon, color: widget.color, size: 26)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.nomor,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20, fontWeight: FontWeight.w800,
                          color: AppTheme.textDark, letterSpacing: -0.3)),
                      Text(widget.judul,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12, fontWeight: FontWeight.w700,
                          color: widget.color)),
                    ],
                  ),
                ),
                RotationTransition(
                  turns: _rotate,
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                    color: widget.color)),
              ]),
              if (_expanded) ...[
                const SizedBox(height: 10),
                Container(height: 1,
                  color: widget.color.withOpacity(0.10)),
                const SizedBox(height: 10),
                Text(widget.penjelasan,
                  style: GoogleFonts.dmSans(
                    fontSize: 12.5, color: AppTheme.textMedium, height: 1.65)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section Title ─────────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: GoogleFonts.plusJakartaSans(
      fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textDark));
  }
}