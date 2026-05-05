class EmergencyContact {
  final String name;
  final String phoneNumber;
  final String description;
  final String icon;
  final bool isAvailable24h;

  const EmergencyContact({
    required this.name,
    required this.phoneNumber,
    required this.description,
    required this.icon,
    this.isAvailable24h = false,
  });
}

final List<EmergencyContact> emergencyContacts = [
  const EmergencyContact(
    name: 'SAPA 129',
    phoneNumber: '129',
    description:
        'Layanan pengaduan kekerasan terhadap perempuan dan anak dari Kementerian PPPA.',
    icon: '🆘',
    isAvailable24h: true,
  ),
  const EmergencyContact(
    name: 'Komnas Perempuan',
    phoneNumber: '021-3903963',
    description:
        'Komisi Nasional Anti Kekerasan terhadap Perempuan — pendampingan dan advokasi.',
    icon: '🤝',
    isAvailable24h: false,
  ),
  const EmergencyContact(
    name: 'LBH APIK Jakarta',
    phoneNumber: '021-8779-1103',
    description:
        'Lembaga Bantuan Hukum Asosiasi Perempuan Indonesia untuk Keadilan.',
    icon: '⚖️',
    isAvailable24h: false,
  ),
  const EmergencyContact(
    name: 'Yayasan Pulih',
    phoneNumber: '021-788-42580',
    description:
        'Layanan kesehatan jiwa dan psikososial untuk penyintas trauma.',
    icon: '🧠',
    isAvailable24h: false,
  ),
  const EmergencyContact(
    name: 'Polisi',
    phoneNumber: '110',
    description:
        'Hubungi kepolisian untuk pelaporan kejahatan seksual dan perlindungan segera.',
    icon: '🚔',
    isAvailable24h: true,
  ),
  const EmergencyContact(
    name: 'Ambulans',
    phoneNumber: '118',
    description: 'Layanan gawat darurat medis.',
    icon: '🚑',
    isAvailable24h: true,
  ),
];
