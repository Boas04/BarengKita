import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/chat_message.dart';

class _C {
  static const navyDeep    = Color(0xFF2D1F6B);
  static const purpleMid   = Color(0xFF4C3B9E);
  static const purpleLight = Color(0xFF7C5CC6);
  static const purpleSoft  = Color(0xFFEDE9FF);
  static const bg          = Color(0xFFF7F5F2);
  static const textDark    = Color(0xFF1C1917);
  static const textLight   = Color(0xFFA8A29E);
  static const white       = Colors.white;
}

class _Intent {
  final Map<String, int> keywords; // keyword → bobot
  final List<String> responses;
  final String? followUp;
  final List<String>? suggestions; // Quick reply suggestions

  const _Intent({
    required this.keywords,
    required this.responses,
    this.followUp,
    this.suggestions,
  });
}

final _intents = <_Intent>[
  // ── DARURAT ─────────────────────────────────
  _Intent(
    keywords: {
      'darurat': 5, 'bahaya': 5, 'tolong': 4, 'help': 4,
      'sekarang': 3, 'segera': 3, 'panik': 4, 'takut': 3,
      'ancam': 4, 'ancaman': 4, 'dipukul': 5, 'kekerasan': 2,
    },
    responses: [
      '🚨 Keselamatan kamu adalah prioritas!\n\n'
      '• Hubungi Polisi sekarang: 110\n'
      '• Hotline darurat: 119\n'
      '• Ambulans: 118\n\n'
      'Pergi ke tempat aman dan hubungi orang terpercaya. Kamu tidak sendirian.',
      '🚨 Saya dengar kamu. Kalau kamu dalam bahaya:\n\n'
      '• Polisi: 110 (bisa SMS juga)\n'
      '• Hotline 24 jam: 119\n\n'
      'Usahakan pergi ke tempat ramai atau tempat yang kamu rasa aman. Kamu berani sekali minta bantuan.',
    ],
    suggestions: ['Tanda-tanda kekerasan', 'Cara melaporkan', 'Lembaga bantuan'],
  ),

  // ── TANDA / CIRI ────────────────────────────
  _Intent(
    keywords: {
      'tanda': 4, 'ciri': 4, 'gejala': 4, 'tahu': 2,
      'kenali': 3, 'mengenali': 3, 'indikasi': 3,
      'gimana': 1, 'bagaimana': 1,
    },
    responses: [
      'Tanda-tanda kekerasan seksual bisa beragam:\n\n'
      '• Perubahan perilaku mendadak\n'
      '• Menarik diri dari orang-orang terdekat\n'
      '• Ketakutan atau kecemasan berlebih\n'
      '• Gangguan tidur atau mimpi buruk\n'
      '• Luka fisik yang tidak bisa dijelaskan\n\n'
      'Kalau kamu atau seseorang yang kamu kenal menunjukkan tanda ini, kamu bisa cerita lebih ke saya.',
      'Ada beberapa hal yang bisa jadi tanda:\n\n'
      '• Trauma emosional: sedih berkepanjangan, mudah marah\n'
      '• Menghindar dari situasi atau orang tertentu\n'
      '• Hilang minat pada aktivitas yang dulu disukai\n'
      '• Perubahan pola makan atau tidur\n\n'
      'Setiap orang bereaksi berbeda. Yang penting adalah kamu tidak harus menanggungnya sendiri.',
    ],
    followUp: 'Apakah ada situasi spesifik yang ingin kamu ceritakan lebih lanjut?',
    suggestions: ['Cara melaporkan', 'Dukungan psikologis', 'Lembaga bantuan'],
  ),

  // ── CARA LAPOR ──────────────────────────────
  _Intent(
    keywords: {
      'lapor': 5, 'melapor': 5, 'laporkan': 5, 'polisi': 3,
      'aduan': 4, 'adukan': 4, 'pengaduan': 4, 'hukum': 2,
      'proses': 2, 'prosedur': 3, 'cara': 2,
    },
    responses: [
      'Cara melaporkan kekerasan seksual:\n\n'
      '1. Hubungi Polisi: 110\n'
      '2. Hotline nasional: 119\n'
      '3. Datang ke Polres/Polsek terdekat\n'
      '4. Pusat Pelayanan Terpadu (PPT) di rumah sakit\n'
      '5. Komnas Perempuan: (021) 390-3963\n\n'
      'Kamu berhak didampingi dan berhak melapor secara anonim. Ceritamu akan didengar dengan serius.',
      'Melaporkan itu hak kamu, dan kamu tidak harus melakukannya sendirian.\n\n'
      '• Polisi 110 — bisa hubungi kapan saja\n'
      '• Hotline 119 — konsultasi terlebih dahulu\n'
      '• LSM pendamping bisa menemanimu ke kantor polisi\n\n'
      'Privasi kamu dijamin. Kalau kamu mau, saya bisa bantu kamu mempersiapkan apa yang ingin disampaikan.',
    ],
    followUp: 'Mau saya bantu jelaskan lebih lanjut tentang prosesnya?',
    suggestions: ['Lembaga bantuan', 'Hak korban', 'Dukungan psikologis'],
  ),

  // ── PSIKOLOGIS / TRAUMA / KONSELING ─────────
  _Intent(
    keywords: {
      'psikolog': 5, 'trauma': 5, 'konseling': 5, 'terapi': 4,
      'pulih': 4, 'pemulihan': 4, 'sembuh': 4, 'luka': 3,
      'sedih': 3, 'depresi': 4, 'stress': 3, 'stres': 3,
      'cemas': 3, 'anxiety': 3, 'mental': 3,
    },
    responses: [
      'Pemulihan trauma itu proses yang unik untuk setiap orang, dan tidak ada timeline yang "benar".\n\n'
      'Langkah yang bisa membantu:\n'
      '• Bicara dengan orang yang kamu percaya\n'
      '• Konseling dengan psikolog profesional\n'
      '• Bergabung dengan grup survivor\n'
      '• Hotline konseling: 119\n\n'
      'Kamu tidak harus langsung baik-baik saja. Izinkan dirimu berproses.',
      'Wajar sekali kalau kamu merasa berat. Trauma itu nyata dan butuh perhatian.\n\n'
      '• Konseling online tersedia lewat aplikasi ini\n'
      '• Psikolog klinis bisa membantu secara lebih mendalam\n'
      '• Hotline 119 juga punya layanan konseling\n\n'
      'Yang penting adalah kamu mau mencari bantuan — dan itu tanda keberanian, bukan kelemahan.',
    ],
    followUp: 'Boleh saya tanya, apakah kamu sedang mencari bantuan untuk dirimu sendiri atau untuk orang lain?',
    suggestions: ['Lembaga bantuan', 'Cara melaporkan', 'Hak korban'],
  ),

  // ── HAK KORBAN ──────────────────────────────
  _Intent(
    keywords: {
      'hak': 5, 'hak-hak': 5, 'hukum': 3, 'undang': 3,
      'uu': 4, 'perlindungan': 4, 'kompensasi': 4,
      'advokat': 4, 'pengacara': 4, 'pendampingan': 3,
    },
    responses: [
      'Sebagai korban, kamu punya hak penuh:\n\n'
      '• Hak atas perlindungan dan keamanan\n'
      '• Hak didampingi advokat/pengacara\n'
      '• Hak privasi dan kerahasiaan identitas\n'
      '• Hak mendapat kompensasi/restitusi\n'
      '• Hak rehabilitasi psikologis\n'
      '• Hak melapor tanpa takut dikriminalisasi\n\n'
      'Laporan kamu berhak ditangani serius oleh pihak berwenang.',
      'Kamu dilindungi oleh hukum Indonesia (UU TPKS No. 12/2022):\n\n'
      '• Identitasmu wajib dirahasiakan\n'
      '• Berhak mendapat pendampingan hukum gratis\n'
      '• Berhak menolak pertanyaan yang tidak relevan\n'
      '• Pelaku bisa dikenai sanksi pidana\n\n'
      'Kalau kamu butuh info lebih lanjut soal proses hukumnya, saya siap membantu.',
    ],
    suggestions: ['Cara melaporkan', 'Lembaga bantuan', 'Dukungan psikologis'],
  ),

  // ── LEMBAGA BANTUAN ──────────────────────────
  _Intent(
    keywords: {
      'lembaga': 5, 'kontak': 4, 'organisasi': 4, 'tempat': 2,
      'pusat': 3, 'hubungi': 2, 'nomor': 2, 'alamat': 2,
      'lokasi': 3, 'bantuan': 2,
    },
    responses: [
      'Berikut lembaga bantuan yang bisa kamu hubungi:\n\n'
      '📍 P2TP2A Kota Malang\n'
      'Jl. Semeru No. 5, Malang\n'
      'Tel: 0341-123456\n\n'
      '📍 Komnas Perempuan Jatim\n'
      'Jl. Kalimantan No. 12, Surabaya\n'
      'Tel: (031) 123-4567\n\n'
      '📍 Rifka Annisa Yogyakarta\n'
      'Jl. Flores No. 88, Yogyakarta\n'
      'Tel: (0274) 625-3819\n\n'
      'Semua melayani konseling, bantuan hukum, dan pendampingan.',
    ],
    suggestions: ['Cara melaporkan', 'Dukungan psikologis', 'Hak korban'],
  ),

  // ── CONSENT ─────────────────────────────────
  _Intent(
    keywords: {
      'consent': 5, 'persetujuan': 5, 'izin': 3, 'setuju': 3,
      'menolak': 3, 'tolak': 3, 'tidak mau': 4, 'gak mau': 4,
      'dipaksa': 5, 'paksaan': 5, 'memaksa': 5,
    },
    responses: [
      'Consent (persetujuan) itu:\n\n'
      '• Harus jelas, sadar, dan sukarela\n'
      '• Bisa ditarik kapan saja — bahkan di tengah situasi\n'
      '• Diam atau tidak melawan BUKAN berarti setuju\n'
      '• Tidak berlaku kalau seseorang takut, mabuk, atau di bawah tekanan\n\n'
      'Memahami consent adalah dasar dari hubungan yang sehat dan aman.',
      'Kalau seseorang mengatakan "tidak" atau menunjukkan ketidaknyamanan, itu adalah batas yang harus dihormati.\n\n'
      '• Consent bukan sesuatu yang bisa "diambil paksa"\n'
      '• Hubungan romantis sebelumnya tidak otomatis berarti consent\n'
      '• Pakaian, tempat, atau waktu BUKAN alasan pembenaran\n\n'
      'Kamu berhak menetapkan batasmu sendiri, dan itu harus dihormati.',
    ],
    followUp: 'Ada situasi tertentu yang ingin kamu diskusikan?',
  ),

  // ── PENCEGAHAN ──────────────────────────────
  _Intent(
    keywords: {
      'cegah': 4, 'pencegahan': 4, 'mencegah': 4, 'proteksi': 3,
      'aman': 2, 'keamanan': 2, 'lindung': 3, 'jaga': 2,
      'tips': 3, 'saran': 2,
    },
    responses: [
      'Beberapa hal yang bisa membantu menjaga keamananmu:\n\n'
      '• Percayai insting kamu — kalau tidak nyaman, tinggalkan situasinya\n'
      '• Berani bilang "tidak" tanpa merasa perlu menjelaskan\n'
      '• Punya kontak orang terpercaya yang bisa dihubungi cepat\n'
      '• Pelajari situasi yang berisiko dan cara menghindarinya\n\n'
      'Ingat: korban TIDAK pernah bersalah atas apa yang terjadi pada mereka.',
      'Pencegahan bukan hanya soal individu, tapi juga lingkungan:\n\n'
      '• Bangun komunikasi terbuka dengan orang-orang terdekat\n'
      '• Dukung teman yang membutuhkan tanpa menghakimi\n'
      '• Lawan normalisasi kekerasan di lingkunganmu\n\n'
      'Pendidikan dan kesadaran adalah kunci terbesar pencegahan.',
    ],
  ),

  // ── SALAM / SAPAAN ──────────────────────────
  _Intent(
    keywords: {
      'halo': 5, 'hai': 5, 'hi': 5, 'hey': 5, 'hei': 5,
      'selamat': 3, 'pagi': 2, 'siang': 2, 'malam': 2,
      'apa kabar': 5, 'gimana': 2,
    },
    responses: [
      'Halo! Senang kamu mampir ke sini 😊\n\nSaya siap membantu kamu dengan topik seputar kekerasan seksual, dukungan psikologis, hak korban, atau cara melaporkan. Mau mulai dari mana?',
      'Hai! Saya asisten BarengKita.\n\nKamu bisa tanya apa saja soal:\n• Tanda-tanda kekerasan seksual\n• Consent dan batasan\n• Cara melapor\n• Dukungan psikologis\n\nAda yang bisa saya bantu?',
      'Halo, selamat datang! 👋\n\nSaya di sini untuk mendengarkan dan membantu. Ceritakan apa yang ada di pikiranmu.',
    ],
  ),

  // ── TERIMA KASIH ────────────────────────────
  _Intent(
    keywords: {
      'terima kasih': 5, 'makasih': 5, 'thanks': 5, 'thx': 5,
      'thank': 4, 'tengkyu': 4, 'helpful': 3, 'membantu': 3,
    },
    responses: [
      'Sama-sama! Senang bisa membantu 😊\n\nKalau ada hal lain yang ingin kamu tanyakan, jangan ragu ya.',
      'Dengan senang hati! Kamu kuat sekali mau mencari informasi ini.\n\nAda lagi yang bisa saya bantu?',
      'Tentu! Saya selalu ada di sini. Jaga dirimu baik-baik ya 💜',
    ],
  ),
];

// ─────────────────────────────────────────────────
//  RESPONSE ENGINE
// ─────────────────────────────────────────────────
class _ResponseEngine {
  static final _rng = Random();

  static Map<String, dynamic> getResponse(String input) {
    final lower = input.toLowerCase();

    // Scoring setiap intent
    _Intent? bestIntent;
    int bestScore = 0;

    for (final intent in _intents) {
      int score = 0;
      for (final entry in intent.keywords.entries) {
        if (lower.contains(entry.key)) {
          score += entry.value;
        }
      }
      if (score > bestScore) {
        bestScore = score;
        bestIntent = intent;
      }
    }

    // Kalau ada intent yang cocok (score > 2)
    if (bestIntent != null && bestScore > 2) {
      final response = bestIntent.responses[
          _rng.nextInt(bestIntent.responses.length)];
      final suggestions = bestIntent.suggestions ?? [
        'Tanda-tanda kekerasan', 'Cara melaporkan', 'Lembaga bantuan'
      ];
      if (bestIntent.followUp != null && _rng.nextBool()) {
        return {
          'text': '$response\n\n${bestIntent.followUp}',
          'suggestions': suggestions,
        };
      }
      return {'text': response, 'suggestions': suggestions};
    }

    // Fallback — tetap relevan dan empatik
    const fallbacks = [
      'Terima kasih sudah mau cerita. Bisakah kamu jelaskan lebih lanjut?',
      'Saya ingin memastikan saya memahami kamu dengan baik. Bisa cerita lebih detail?',
      'Hmm, saya belum sepenuhnya mengerti maksudmu. Coba ceritakan dengan kata-kata lain?',
    ];

    return {
      'text': fallbacks[_rng.nextInt(fallbacks.length)],
      'suggestions': ['Tanda-tanda kekerasan', 'Cara melaporkan', 'Lembaga bantuan', 'Dukungan psikologis'],
    };
  }
}

// ─────────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────────
class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          'Halo! Saya adalah asisten BarengKita. Saya di sini untuk membantu Anda.\n\nAda yang bisa saya bantu? Tanyakan tentang:\n• Tanda-tanda kekerasan seksual\n• Bagaimana cara melaporkan\n• Dukungan psikologis\n• Hak-hak korban',
      isBot: true,
      suggestions: ['Tanda-tanda kekerasan', 'Cara melaporkan', 'Lembaga bantuan', 'Dukungan psikologis'],
    ),
  ];

  void _sendMessage([String? override]) {
    final text = override ?? _messageController.text.trim();
    if (text.isEmpty || _isTyping) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isBot: false));
      _isTyping = true;
    });
    _messageController.clear();
    _scrollToBottom();

    // Simulasi delay natural (400–900ms)
    final delay = 400 + Random().nextInt(500);
    Future.delayed(Duration(milliseconds: delay), () {
      if (!mounted) return;
      final response = _ResponseEngine.getResponse(text);
      setState(() {
        _messages.add(ChatMessage(
          text: response['text'] as String,
          isBot: true,
          suggestions: response['suggestions'] as List<String>?,
        ));
        _isTyping = false;
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        backgroundColor: _C.navyDeep,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 34, height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy_rounded,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Asisten BarengKita',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Row(children: [
                  Container(
                    width: 6, height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFFA8F0C6), shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _isTyping ? 'Sedang mengetik...' : 'Online · Siap membantu',
                    style: GoogleFonts.dmSans(
                      fontSize: 10.5, color: Colors.white.withOpacity(0.72),
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_C.navyDeep, _C.purpleMid],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return _buildTypingIndicator();
                }
                return _buildBubble(_messages[index], index);
              },
            ),
          ),

          // Input bar
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
            decoration: BoxDecoration(
              color: _C.white,
              border: Border(
                  top: BorderSide(color: Colors.black.withOpacity(0.07))),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12, offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: _C.bg,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.08)),
                    ),
                    child: TextField(
                      controller: _messageController,
                      enabled: !_isTyping,
                      style: GoogleFonts.dmSans(
                          fontSize: 14, color: _C.textDark),
                      decoration: InputDecoration(
                        hintText: _isTyping
                            ? 'Asisten sedang membalas...'
                            : 'Tanyakan sesuatu...',
                        hintStyle: GoogleFonts.dmSans(
                            fontSize: 14, color: _C.textLight),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 13),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _isTyping ? null : _sendMessage,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isTyping
                            ? [_C.textLight, _C.textLight]
                            : [_C.purpleLight, _C.purpleMid],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded,
                        color: Colors.white, size: 18),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 30, height: 30,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_C.navyDeep, _C.purpleMid],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy_rounded,
                color: Colors.white, size: 15),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: _C.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
              border: Border.all(color: Colors.black.withOpacity(0.06)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8, offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const _TypingDots(),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(ChatMessage message, int index) {
    final isBot = message.isBot;
    final isFirstBot =
        isBot && (index == 0 || !_messages[index - 1].isBot);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment:
            isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:
                isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              if (isBot) ...[
                if (isFirstBot)
                  Container(
                    width: 30, height: 30,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_C.navyDeep, _C.purpleMid],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.smart_toy_rounded,
                        color: Colors.white, size: 15),
                  )
                else
                  const SizedBox(width: 30),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.72,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 11),
                  decoration: BoxDecoration(
                    color: isBot ? _C.white : _C.purpleMid,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: isBot
                          ? const Radius.circular(4)
                          : const Radius.circular(18),
                      bottomRight: isBot
                          ? const Radius.circular(18)
                          : const Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isBot
                            ? Colors.black.withOpacity(0.05)
                            : _C.purpleMid.withOpacity(0.25),
                        blurRadius: 8, offset: const Offset(0, 3),
                      ),
                    ],
                    border: isBot
                        ? Border.all(color: Colors.black.withOpacity(0.06))
                        : null,
                  ),
                  child: Text(
                    message.text,
                    style: GoogleFonts.dmSans(
                      fontSize: 13.5,
                      color: isBot ? _C.textDark : Colors.white,
                      height: 1.55,
                    ),
                  ),
                ),
              ),
              if (!isBot) const SizedBox(width: 4),
            ],
          ),
          // Render suggestions jika ada
          if (isBot && message.suggestions != null && message.suggestions!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 38),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: message.suggestions!.map((suggestion) {
                  return GestureDetector(
                    onTap: () => _sendMessage(suggestion),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _C.purpleSoft,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: _C.purpleMid.withOpacity(0.2)),
                      ),
                      child: Text(
                        suggestion,
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          color: _C.purpleMid,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

// ── Animated typing dots ──────────────────────────
class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final delay = i / 3;
            final t = (_ctrl.value - delay).clamp(0.0, 1.0);
            final opacity =
                (0.3 + 0.7 * (t < 0.5 ? t * 2 : (1 - t) * 2))
                    .clamp(0.3, 1.0);
            return Container(
              margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
              width: 7, height: 7,
              decoration: BoxDecoration(
                color: _C.purpleMid.withOpacity(opacity),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}