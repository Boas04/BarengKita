import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/counselor.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class CounselingScreen extends StatefulWidget {
  const CounselingScreen({super.key});

  @override
  State<CounselingScreen> createState() => _CounselingScreenState();
}

class _CounselingScreenState extends State<CounselingScreen> {
  bool _showOnlineOnly = false;

  List<Counselor> get _filteredCounselors {
    if (_showOnlineOnly) {
      return counselors.where((c) => c.isOnline).toList();
    }
    return counselors;
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka tautan')),
        );
      }
    }
  }

  Future<void> _callNumber(String phoneNumber, BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail(String email, BuildContext context) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tidak dapat mengirim email ke $email')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: AppBar(
        title: const Text('Konseling'),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Organisasi Pendukung',
                    subtitle: 'Lembaga terpercaya untuk pendampingan',
                    icon: Icons.people,
                    color: AppTheme.calmBlue,
                  ),
                  const SizedBox(height: 12),
                  ..._filteredCounselors.map(
                    (counselor) => _CounselorCard(
                      counselor: counselor,
                      onWebsite: counselor.website != null
                          ? () => _launchUrl(counselor.website!, context)
                          : null,
                      onCall: counselor.contactPhone != null
                          ? () =>
                              _callNumber(counselor.contactPhone!, context)
                          : null,
                      onEmail: () =>
                          _sendEmail(counselor.contactEmail, context),
                    ),
                  ),
                  if (_filteredCounselors.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(Icons.search_off,
                                size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 12),
                            Text(
                              'Tidak ada layanan yang tersedia online saat ini.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Text(
            'Filter:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(width: 12),
          FilterChip(
            label: const Text('Online'),
            selected: _showOnlineOnly,
            onSelected: (val) => setState(() => _showOnlineOnly = val),
            selectedColor: AppTheme.calmBlue.withOpacity(0.2),
            checkmarkColor: AppTheme.calmBlue,
            labelStyle: TextStyle(
              color: _showOnlineOnly ? AppTheme.calmBlue : Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CounselorCard extends StatefulWidget {
  final Counselor counselor;
  final VoidCallback? onWebsite;
  final VoidCallback? onCall;
  final VoidCallback onEmail;

  const _CounselorCard({
    required this.counselor,
    required this.onWebsite,
    required this.onCall,
    required this.onEmail,
  });

  @override
  State<_CounselorCard> createState() => _CounselorCardState();
}

class _CounselorCardState extends State<_CounselorCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.calmBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.business,
                        color: AppTheme.calmBlue, size: 26),
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
                                widget.counselor.organizationName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            if (widget.counselor.isOnline)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.safeGreen.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Online',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppTheme.safeGreen,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              widget.counselor.location,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: widget.counselor.services
                              .map(
                                (service) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryPurple
                                        .withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    service,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: AppTheme.primaryPurple),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.counselor.description,
                    style: const TextStyle(fontSize: 13, height: 1.6),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        if (widget.onCall != null)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: widget.onCall,
              icon: const Icon(Icons.phone, size: 16),
              label: const Text('Telepon'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.safeGreen,
                side: const BorderSide(color: AppTheme.safeGreen),
              ),
            ),
          ),
        if (widget.onCall != null) const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: widget.onEmail,
            icon: const Icon(Icons.email, size: 16),
            label: const Text('Email'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.calmBlue,
              side: const BorderSide(color: AppTheme.calmBlue),
            ),
          ),
        ),
        if (widget.onWebsite != null) ...[
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: widget.onWebsite,
              icon: const Icon(Icons.language, size: 16),
              label: const Text('Website'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primaryPurple,
                side: const BorderSide(color: AppTheme.primaryPurple),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
