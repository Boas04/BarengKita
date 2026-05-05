import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  final void Function(int tabIndex) onNavigateToTab;

  const HomeScreen({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildEmergencyBanner(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Layanan Kami'),
              const SizedBox(height: 16),
              _buildServiceCards(),
              const SizedBox(height: 24),
              _buildSectionTitle('Tentang BarengKita'),
              const SizedBox(height: 12),
              _buildAboutCard(),
              const SizedBox(height: 24),
              _buildSafetyNotice(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BarengKita',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.primaryPurple,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Text(
              'Kamu tidak sendirian.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.favorite, color: Colors.white, size: 28),
        ),
      ],
    );
  }

  Widget _buildEmergencyBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => onNavigateToTab(1),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.emergencyRed, Color(0xFFFF5252)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.emergencyRed.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.emergency, color: Colors.white, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dalam Bahaya?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Text(
                    'Tekan di sini untuk akses layanan darurat segera',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppTheme.primaryPurple,
      ),
    );
  }

  Widget _buildServiceCards() {
    final services = [
      _ServiceCardData(
        icon: Icons.emergency,
        title: 'Darurat',
        description: 'Hotline & kontak bantuan cepat',
        color: AppTheme.emergencyRed,
        tabIndex: 1,
      ),
      _ServiceCardData(
        icon: Icons.people,
        title: 'Konseling',
        description: 'Temukan konselor & organisasi pendukung',
        color: AppTheme.calmBlue,
        tabIndex: 2,
      ),
      _ServiceCardData(
        icon: Icons.library_books,
        title: 'Sumber Daya',
        description: 'Artikel & panduan informasi',
        color: AppTheme.safeGreen,
        tabIndex: 3,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _ServiceCard(
          data: service,
          onTap: () => onNavigateToTab(service.tabIndex),
        );
      },
    );
  }

  Widget _buildAboutCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BarengKita adalah platform yang hadir untuk mendampingi dan mendukung korban kekerasan seksual di Indonesia.',
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
            const SizedBox(height: 12),
            const Text(
              'Kami menyediakan:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            ...[
              '🆘 Layanan darurat dan hotline 24/7',
              '🤝 Jaringan konselor dan organisasi terpercaya',
              '📚 Sumber daya edukasi tentang hak dan pemulihan',
              '🔒 Ruang aman tanpa penghakiman',
            ].map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(item, style: const TextStyle(fontSize: 13, height: 1.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryPurple.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryPurple.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock, color: AppTheme.primaryPurple, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Kerahasiaan identitasmu terjaga. Semua informasi yang kamu berikan aman dan tidak akan disebarluaskan.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.primaryPurple,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCardData {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final int tabIndex;

  const _ServiceCardData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.tabIndex,
  });
}

class _ServiceCard extends StatelessWidget {
  final _ServiceCardData data;
  final VoidCallback onTap;

  const _ServiceCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: data.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(data.icon, color: data.color, size: 26),
              ),
              const SizedBox(height: 8),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: data.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.grey[600], height: 1.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
