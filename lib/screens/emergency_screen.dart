import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/emergency_contact.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  Future<void> _callNumber(String phoneNumber, BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tidak dapat menghubungi $phoneNumber'),
            backgroundColor: AppTheme.emergencyRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final available24h =
        emergencyContacts.where((c) => c.isAvailable24h).toList();
    final others =
        emergencyContacts.where((c) => !c.isAvailable24h).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: AppBar(
        title: const Text('Layanan Darurat'),
        backgroundColor: AppTheme.emergencyRed,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSOSCard(context),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Hotline 24 Jam',
              subtitle: 'Tersedia setiap saat',
              icon: Icons.access_time,
              color: AppTheme.emergencyRed,
            ),
            const SizedBox(height: 12),
            ...available24h.map(
              (contact) => _ContactCard(
                contact: contact,
                onCall: () => _callNumber(contact.phoneNumber, context),
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Layanan Pendampingan',
              subtitle: 'Lembaga bantuan dan advokasi',
              icon: Icons.support_agent,
              color: AppTheme.calmBlue,
            ),
            const SizedBox(height: 12),
            ...others.map(
              (contact) => _ContactCard(
                contact: contact,
                onCall: () => _callNumber(contact.phoneNumber, context),
              ),
            ),
            const SizedBox(height: 16),
            _buildSafetyTips(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.emergencyRed, Color(0xFFB71C1C)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.emergencyRed.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '⚠️ Dalam Bahaya?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hubungi SAPA 129 segera — layanan tersedia 24 jam untuk membantu kamu.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _callNumber('129', context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.emergencyRed,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            icon: const Icon(Icons.phone, size: 22),
            label: const Text(
              'Hubungi SAPA 129',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyTips(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.tips_and_updates,
                    color: AppTheme.primaryPurple),
                const SizedBox(width: 8),
                Text(
                  'Tips Keselamatan',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryPurple,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...[
              'Jika dalam bahaya langsung, hubungi 110 (Polisi) atau 118 (Ambulans).',
              'Simpan nomor-nomor penting ini di ponsel kamu.',
              'Ceritakan situasimu kepada seseorang yang kamu percaya.',
              'Kamu berhak mendapat bantuan — jangan ragu untuk meminta tolong.',
            ].map(
              (tip) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 14)),
                    Expanded(
                        child: Text(tip,
                            style: const TextStyle(fontSize: 13, height: 1.5))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final EmergencyContact contact;
  final VoidCallback onCall;

  const _ContactCard({required this.contact, required this.onCall});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.emergencyRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(contact.icon, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          contact.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      if (contact.isAvailable24h)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.safeGreen.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '24 Jam',
                            style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.safeGreen,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    contact.phoneNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.calmBlue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onCall,
              icon: const Icon(Icons.phone),
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.safeGreen,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
