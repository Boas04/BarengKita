class Counselor {
  final String organizationName;
  final String description;
  final String contactEmail;
  final String? contactPhone;
  final String? website;
  final List<String> services;
  final String location;
  final bool isOnline;

  const Counselor({
    required this.organizationName,
    required this.description,
    required this.contactEmail,
    this.contactPhone,
    this.website,
    required this.services,
    required this.location,
    this.isOnline = false,
  });
}

final List<Counselor> counselors = [
  const Counselor(
    organizationName: 'Yayasan Pulih',
    description:
        'Memberikan layanan kesehatan jiwa dan psikososial berbasis komunitas bagi penyintas trauma, termasuk korban kekerasan seksual.',
    contactEmail: 'info@yayasanpulih.org',
    contactPhone: '021-788-42580',
    website: 'https://yayasanpulih.org',
    services: ['Konseling Individual', 'Terapi Kelompok', 'Pendampingan Psikologis'],
    location: 'Jakarta',
    isOnline: true,
  ),
  const Counselor(
    organizationName: 'LBH APIK Jakarta',
    description:
        'Memberikan bantuan hukum dan konseling bagi perempuan dan anak korban kekerasan, termasuk kekerasan seksual.',
    contactEmail: 'lbhapik@lbhapik.or.id',
    contactPhone: '021-8779-1103',
    website: 'https://lbhapik.org',
    services: ['Bantuan Hukum', 'Konseling', 'Pendampingan Peradilan'],
    location: 'Jakarta',
    isOnline: false,
  ),
  const Counselor(
    organizationName: 'Rifka Annisa',
    description:
        'Organisasi perempuan yang fokus pada penghapusan kekerasan terhadap perempuan, menyediakan konseling dan pendampingan.',
    contactEmail: 'info@rifka-annisa.org',
    contactPhone: '0274-553333',
    website: 'https://rifka-annisa.org',
    services: ['Konseling Krisis', 'Rumah Aman', 'Advokasi'],
    location: 'Yogyakarta',
    isOnline: true,
  ),
  const Counselor(
    organizationName: 'Mitra Perempuan',
    description:
        'Pusat krisis terpadu untuk perempuan dan anak korban kekerasan di Jakarta.',
    contactEmail: 'mitraperempuan@gmail.com',
    contactPhone: '021-8300-454',
    website: null,
    services: ['Konseling', 'Shelter', 'Pendampingan Hukum', 'Medis'],
    location: 'Jakarta',
    isOnline: false,
  ),
  const Counselor(
    organizationName: 'Into The Light Indonesia',
    description:
        'Organisasi yang berfokus pada pencegahan bunuh diri dan kesehatan mental, menyediakan dukungan bagi penyintas trauma.',
    contactEmail: 'care@intothelightid.org',
    contactPhone: null,
    website: 'https://intothelightid.org',
    services: ['Support Group', 'Konseling Online', 'Edukasi Mental Health'],
    location: 'Nasional',
    isOnline: true,
  ),
];
