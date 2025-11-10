import 'dart:async';
import 'package:flutter/material.dart';

class QuizQuestionPage extends StatefulWidget {
  final String level;

  const QuizQuestionPage({Key? key, required this.level}) : super(key: key);

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  int currentQuestionIndex = 0;
  int selectedIndex = -1;
  int timeLeft = 30;
  Timer? timer;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Siapakah tokoh utama dalam kisah Mahabharata yang dikenal sebagai pemanah ulung dan murid kesayangan Drona?",
      "options": ["Bima", "Nakula", "Arjuna", "Karna"],
      "answer": 2,
    },
    {
      "question": "Wayang berasal dari kebudayaan negara mana?",
      "options": ["India", "Indonesia", "Thailand", "Malaysia"],
      "answer": 1,
    },
    {
      "question":
          "Tokoh wayang berwajah hitam dan dikenal sebagai kuat adalah?",
      "options": ["Arjuna", "Yudhistira", "Bima", "Kresna"],
      "answer": 2,
    },
    {
      "question": "Siapa raja dari kerajaan Astina?",
      "options": ["Duryudana", "Abimanyu", "Puntadewa", "Baladewa"],
      "answer": 0,
    },
    {
      "question": "Dalang dalam pertunjukan wayang berfungsi sebagai?",
      "options": [
        "Pemain gamelan",
        "Penyanyi",
        "Pengendali cerita dan suara",
        "Penari",
      ],
      "answer": 2,
    },
    {
      "question": "Wayang kulit terbuat dari bahan apa?",
      "options": ["Kayu", "Kertas", "Kulit kerbau", "Bambu"],
      "answer": 2,
    },
    {
      "question": "Wayang digunakan untuk menyampaikan?",
      "options": ["Pesan moral", "Iklan", "Berita", "Tantangan"],
      "answer": 0,
    },
    {
      "question": "Siapa dewa tertinggi dalam pewayangan?",
      "options": [
        "Batara Guru",
        "Batara Narada",
        "Batara Indra",
        "Batara Surya",
      ],
      "answer": 0,
    },
    {
      "question": "Siapakah ayah dari Gatutkaca?",
      "options": ["Arjuna", "Nakula", "Bima", "Kresna"],
      "answer": 2,
    },
    {
      "question": "Siapakah dalang terkenal asal Indonesia?",
      "options": ["Ki Manteb Sudharsono", "Ki Sugino", "Ki Cakra", "Ki Warno"],
      "answer": 0,
    },
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        t.cancel();
        showAnswerDialog(false, -1); // waktu habis dianggap salah
      }
    });
  }

  void showAnswerDialog(bool isCorrect, int selectedIndex) {
    final correctAnswer =
        questions[currentQuestionIndex]["options"][questions[currentQuestionIndex]["answer"]];
    final selectedAnswer = selectedIndex != -1
        ? questions[currentQuestionIndex]["options"][selectedIndex]
        : "Tidak menjawab";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? "Benar!" : "Salah!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isCorrect
                  ? "Jawaban yang benar: $correctAnswer"
                  : "Jawaban kamu: $selectedAnswer\nJawaban yang benar: $correctAnswer",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              goToNextQuestion();
            },
            child: const Text("Lanjut"),
          ),
        ],
      ),
    );
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedIndex = -1;
      });
      startTimer();
    } else {
      timer?.cancel();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Kuis Selesai!"),
          content: const Text(
            "Selamat, kamu telah menyelesaikan semua pertanyaan.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Tutup"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final options = question["options"] as List<String>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(widget.level),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("${currentQuestionIndex + 1}/${questions.length}"),
            ),
            const SizedBox(height: 16),

            // Timer
            Text(
              "Waktu: $timeLeft detik",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Question
            Text(
              question["question"],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),

            // Options
            ...List.generate(options.length, (index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() => selectedIndex = index);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.brown[300] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    options[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: selectedIndex == -1
                  ? null
                  : () {
                      final correctAnswerIndex = question["answer"] as int;
                      bool isCorrect = selectedIndex == correctAnswerIndex;
                      timer?.cancel();
                      showAnswerDialog(isCorrect, selectedIndex);
                    },
              child: Text(
                "Kirim Jawaban",
                style: const TextStyle(
                  color: Colors.white, // ⬅️ ubah di sini (misal: Colors.yellow, Colors.black, dll)
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
