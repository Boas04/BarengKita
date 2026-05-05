import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/theme.dart';

class PetaBantuanScreen extends StatefulWidget {
  const PetaBantuanScreen({Key? key}) : super(key: key);

  @override
  State<PetaBantuanScreen> createState() => _PetaBantuanScreenState();
}

class _PetaBantuanScreenState extends State<PetaBantuanScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilter = 0;
  late AnimationController _animCtrl;

  final List<_LembagaData> _allLembaga = [
    _LembagaData(
      nama: 'P2TP2A Kota Malang',
      alamat: 'Jl. Semeru No. 5, Malang',
      telepon: '0341-123456',
      layanan: 'Konseling, bantuan hukum, perlindungan',
      kategori: 'legal',
      distanceKm: 0.1,
      jamBuka: 'Buka 24 Jam',
      gradient: [Color(0xFF6B48FF), Color(0xFF9B7BFF)],
      icon: Icons.balance_rounded,
      rating: 4.8,
    ),
    _LembagaData(
      nama: 'Komnas Perempuan Jatim',
      alamat: 'Jl. Kalimantan No. 12, Surabaya',
      telepon: '0821-1234567',
      layanan: 'Advokasi, perlindungan hukum korban',
      kategori: 'legal',
      distanceKm: 89.5,
      jamBuka: 'Buka 08.00–17.00',
      gradient: [Color(0xFF1A6FB8), Color(0xFF4DAFFF)],
      icon: Icons.gavel_rounded,
      rating: 4.6,
    ),
    _LembagaData(
      nama: 'LSM Pendamping Korban KS',
      alamat: 'Jl. Ahmad Yani No. 88, Malang',
      telepon: '0341-654321',
      layanan: 'Pendampingan, konseling psikologis',
      kategori: 'psikolog',
      distanceKm: 1.2,
      jamBuka: 'Buka 09.00–20.00',
      gradient: [Color(0xFFC92B6A), Color(0xFFFF7BAA)],
      icon: Icons.favorite_rounded,
      rating: 4.9,
    ),
    _LembagaData(
      nama: 'RS Panti Waluya Malang',
      alamat: 'Jl. Borobudur No. 17, Malang',
      telepon: '0341-367777',
      layanan: 'Visum, perawatan medis darurat, IGD',
      kategori: 'rumah sakit',
      distanceKm: 2.4,
      jamBuka: 'Buka 24 Jam',
      gradient: [Color(0xFFE84040), Color(0xFFFF8C69)],
      icon: Icons.local_hospital_rounded,
      rating: 4.7,
    ),
    _LembagaData(
      nama: 'Puskesmas Ciptomulyo',
      alamat: 'Jl. Karangbesuki No. 45, Malang',
      telepon: '0341-123789',
      layanan: 'Konsultasi kesehatan, visum et repertum',
      kategori: 'rumah sakit',
      distanceKm: 3.1,
      jamBuka: 'Buka 07.00–14.00',
      gradient: [Color(0xFF1A8C4E), Color(0xFF4DCC88)],
      icon: Icons.medical_services_rounded,
      rating: 4.5,
    ),
    _LembagaData(
      nama: 'LBH Surabaya',
      alamat: 'Jl. Diponegoro No. 26, Surabaya',
      telepon: '031-5678901',
      layanan: 'Bantuan hukum gratis, advokasi',
      kategori: 'legal',
      distanceKm: 91.0,
      jamBuka: 'Buka 08.00–16.00',
      gradient: [Color(0xFF9B3DB8), Color(0xFFD08BFF)],
      icon: Icons.account_balance_rounded,
      rating: 4.7,
    ),
    _LembagaData(
      nama: 'Yayasan Pulih Jakarta',
      alamat: 'Jl. Teluk Peleng No. 63A, Jakarta',
      telepon: '021-7884238',
      layanan: 'Trauma healing, konseling psikologis',
      kategori: 'psikolog',
      distanceKm: 780.0,
      jamBuka: 'Buka 09.00–17.00',
      gradient: [Color(0xFFE8923A), Color(0xFFFFBD59)],
      icon: Icons.psychology_rounded,
      rating: 4.9,
    ),
  ];

  final List<_FilterItem> _filters = const [
    _FilterItem(label: 'Semua', icon: Icons.apps_rounded),
    _FilterItem(label: 'Psikolog', icon: Icons.favorite_rounded),
    _FilterItem(label: 'Rumah Sakit', icon: Icons.local_hospital_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  List<_LembagaData> get _filtered {
    final query = _searchController.text.trim().toLowerCase();
    final filterLabel = _filters[_selectedFilter].label.toLowerCase();

    return _allLembaga.where((l) {
      final textMatch = query.isEmpty ||
          l.nama.toLowerCase().contains(query) ||
          l.alamat.toLowerCase().contains(query) ||
          l.layanan.toLowerCase().contains(query);

      final catMatch = filterLabel == 'semua' || l.kategori == filterLabel;
      return textMatch && catMatch;
    }).toList()
      ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
  }

  Future<void> _openMaps(_LembagaData l) async {
    final query = Uri.encodeComponent('${l.nama}, ${l.alamat}');
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  Future<void> _callLembaga(_LembagaData l) async {
    try {
      await launchUrl(Uri.parse('tel:${l.telepon}'));
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final nearest = filtered.isNotEmpty ? filtered.first : null;

    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: CustomScrollView(
        slivers: [
          // ── Gradient Header ────────────────────────────────────
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            stretch: true,
            backgroundColor: AppTheme.primaryColor,
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
                child: Stack(
                  children: [
                    Positioned(top: -30, right: -30,
                      child: Container(width: 160, height: 160,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), shape: BoxShape.circle))),
                    Positioned(bottom: -40, left: 60,
                      child: Container(width: 180, height: 180,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), shape: BoxShape.circle))),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 36),
                            Row(children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12)),
                                child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 20)),
                              const SizedBox(width: 10),
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text('Peta Bantuan', style: GoogleFonts.plusJakartaSans(
                                  fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.3)),
                                Text('${_allLembaga.length} lembaga tersedia di sekitarmu',
                                  style: GoogleFonts.dmSans(fontSize: 11.5, color: Colors.white.withOpacity(0.72))),
                              ]),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Search bar ───────────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppTheme.textDark),
                      decoration: InputDecoration(
                        hintText: 'Cari lembaga bantuan...',
                        hintStyle: GoogleFonts.plusJakartaSans(color: AppTheme.textLight, fontSize: 13),
                        prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.primaryColor),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ── Filter chips ─────────────────────────────
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final selected = _selectedFilter == i;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedFilter = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: selected ? const LinearGradient(
                                colors: [Color(0xFF4C3B9E), Color(0xFF7C5CC6)],
                                begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
                              color: selected ? null : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: selected ? [BoxShadow(
                                color: const Color(0xFF4C3B9E).withOpacity(0.3),
                                blurRadius: 10, offset: const Offset(0, 4))] : AppTheme.cardShadow,
                            ),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              Icon(_filters[i].icon, size: 14,
                                color: selected ? Colors.white : AppTheme.textMedium),
                              const SizedBox(width: 6),
                              Text(_filters[i].label, style: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w600,
                                color: selected ? Colors.white : AppTheme.textDark)),
                            ]),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Nearest banner ───────────────────────────
                  if (nearest != null) ...[
                    _buildNearestBanner(nearest),
                    const SizedBox(height: 20),
                  ],

                  // ── Section header ───────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${filtered.length} Lembaga Ditemukan',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4C3B9E).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20)),
                        child: Text('Terdekat dulu', style: GoogleFonts.dmSans(
                          fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF4C3B9E))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // ── Lembaga list ──────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: filtered.isEmpty
                ? SliverToBoxAdapter(child: _buildEmpty())
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildLembagaCard(filtered[i], i == 0),
                      ),
                      childCount: filtered.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // ── Nearest Banner ────────────────────────────────────────────────────────
  Widget _buildNearestBanner(_LembagaData l) {
    return GestureDetector(
      onTap: () => _openMaps(l),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: l.gradient,
            begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(
            color: l.gradient[0].withOpacity(0.35),
            blurRadius: 20, offset: const Offset(0, 8))],
        ),
        child: Stack(
          children: [
            Positioned(right: -20, bottom: -20,
              child: Icon(l.icon, size: 90, color: Colors.white.withOpacity(0.10))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Container(width: 6, height: 6,
                        decoration: const BoxDecoration(color: Color(0xFFA8F0C6), shape: BoxShape.circle)),
                      const SizedBox(width: 5),
                      Text('Rekomendasi Utama', style: GoogleFonts.dmSans(
                        fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white)),
                    ]),
                  ),
                ]),
                const SizedBox(height: 12),
                Text(l.nama, style: GoogleFonts.plusJakartaSans(
                  fontSize: 18, fontWeight: FontWeight.w800,
                  color: Colors.white, height: 1.2, letterSpacing: -0.3)),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on_rounded, size: 12, color: Colors.white70),
                  const SizedBox(width: 4),
                  Expanded(child: Text(l.alamat, style: GoogleFonts.dmSans(
                    fontSize: 11.5, color: Colors.white.withOpacity(0.80)))),
                ]),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.access_time_rounded, size: 12, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(l.jamBuka, style: GoogleFonts.dmSans(
                    fontSize: 11, color: Colors.white.withOpacity(0.80))),
                ]),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: () => _openMaps(l),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.map_rounded, size: 16, color: l.gradient[0]),
                      const SizedBox(width: 8),
                      Text('Buka di Google Maps', style: GoogleFonts.plusJakartaSans(
                        fontSize: 13, fontWeight: FontWeight.w700, color: l.gradient[0])),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Lembaga Card ──────────────────────────────────────────────────────────
  Widget _buildLembagaCard(_LembagaData l, bool isFirst) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
        border: isFirst
            ? Border.all(color: l.gradient[0].withOpacity(0.25), width: 1.5)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Icon box with gradient
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [l.gradient[0].withOpacity(0.15), l.gradient[1].withOpacity(0.08)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(16)),
              child: Icon(l.icon, color: l.gradient[0], size: 26),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(l.nama, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textDark))),
                  if (isFirst) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: l.gradient[0].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                      child: Text('Terdekat', style: GoogleFonts.dmSans(
                        fontSize: 9, fontWeight: FontWeight.w700, color: l.gradient[0]))),
                  ],
                ]),
                const SizedBox(height: 3),
                Row(children: [
                  Icon(Icons.location_on_rounded, size: 11, color: AppTheme.textLight),
                  const SizedBox(width: 3),
                  Expanded(child: Text(l.alamat, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(fontSize: 11, color: AppTheme.textLight))),
                ]),
                const SizedBox(height: 3),
                Row(children: [
                  Icon(Icons.access_time_rounded, size: 11, color: AppTheme.textLight),
                  const SizedBox(width: 3),
                  Text(l.jamBuka, style: GoogleFonts.dmSans(fontSize: 10.5, color: AppTheme.textLight)),
                  const SizedBox(width: 8),
                  Container(width: 3, height: 3,
                    decoration: BoxDecoration(color: AppTheme.textLight.withOpacity(0.4), shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Row(children: [
                    const Icon(Icons.star_rounded, size: 11, color: Color(0xFFF39C12)),
                    const SizedBox(width: 2),
                    Text('${l.rating}', style: GoogleFonts.dmSans(
                      fontSize: 10.5, fontWeight: FontWeight.w600, color: AppTheme.textMedium)),
                  ]),
                ]),
                const SizedBox(height: 8),
                // Layanan chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: l.gradient[0].withOpacity(0.07),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: l.gradient[0].withOpacity(0.15))),
                  child: Text(l.layanan, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(fontSize: 10, color: l.gradient[0], fontWeight: FontWeight.w600)),
                ),
              ]),
            ),
            const SizedBox(width: 10),
            // Action button
            GestureDetector(
              onTap: () => _openMaps(l),
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: l.gradient,
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: l.gradient[0].withOpacity(0.3),
                    blurRadius: 8, offset: const Offset(0, 3))]),
                child: const Icon(Icons.map_rounded, color: Colors.white, size: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // ── Empty state ───────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF4C3B9E).withOpacity(0.08),
              shape: BoxShape.circle),
            child: const Icon(Icons.search_off_rounded, size: 40, color: Color(0xFF4C3B9E))),
          const SizedBox(height: 16),
          Text('Tidak ditemukan', style: GoogleFonts.plusJakartaSans(
            fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
          const SizedBox(height: 6),
          Text('Coba kata kunci lain atau ganti filter',
            style: GoogleFonts.dmSans(fontSize: 13, color: AppTheme.textLight)),
        ]),
      ),
    );
  }
}

// ── Data Classes ──────────────────────────────────────────────────────────────
class _LembagaData {
  final String nama, alamat, telepon, layanan, kategori, jamBuka;
  final double distanceKm, rating;
  final List<Color> gradient;
  final IconData icon;

  const _LembagaData({
    required this.nama, required this.alamat, required this.telepon,
    required this.layanan, required this.kategori, required this.distanceKm,
    required this.jamBuka, required this.gradient, required this.icon,
    required this.rating,
  });
}

class _FilterItem {
  final String label;
  final IconData icon;
  const _FilterItem({required this.label, required this.icon});
}