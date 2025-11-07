import 'package:flutter/material.dart';
import 'chatbotpage.dart';
import 'quiz_page.dart';
import 'cari_dalang_page.dart';
import 'videopage.dart';

class HomeWayangPage extends StatelessWidget {
  const HomeWayangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEFBF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              SizedBox(
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Logo di tengah
                    Center(child: Image.asset("assets/logo.png", height: 31)),

                    // Avatar di kanan atas
                    Align(
                      alignment: Alignment.centerRight,
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("assets/avatar.png"),
                      ),
                    ),
                  ],
                ),
              ),
              // ===== WELCOME TEXT =====
              const Center(
                child: Text(
                  "Selamat Datang, Arya",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4B3425),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ===== BANNER =====
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: const DecorationImage(
                    image: AssetImage("assets/banner.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ===== 4 MENU ICON =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _menuItem(
                    context,
                    "assets/icon_scan.png",
                    "Pengenalan\nWayang",
                  ),
                  _menuItem(context, "assets/icon_quiz.png", "Quiz"),
                  _menuItem(
                    context,
                    "assets/icon_dalang.png",
                    "Mencari\nDalang",
                  ),
                  _menuItem(context, "assets/icon_play.png", "Menjadi\nDalang"),
                ],
              ),

              const SizedBox(height: 35),

              // ===== VIDEO WAYANG SECTION =====
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VideoPage()),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Video Wayang Kulit",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4B3425),
                          ),
                        ),
                        Text(
                          "Selengkapnya",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ===== VIDEO PREVIEW =====
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color(0xffE8D4BE),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ===== VIDEO TITLE =====
                    const Text(
                      "Judul Video Wayang Kulit",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4B3425),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 70),
            ],
          ),
        ),
      ),

      // ===== FLOATING CHATBOT =====
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffE8D4BE),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotPage()),
          );
        },
        child: Image.asset("assets/icon_robot.png", height: 30),
      ),
    );
  }

  // ===== MENU ITEM COMPONENT =====
  Widget _menuItem(BuildContext context, String icon, String label) {
    return GestureDetector(
      onTap: () {
        if (label == "Pengenalan\nWayang") {
          // Navigasi ke halaman pengenalan wayang (belum ada, placeholder)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Halaman Pengenalan Wayang belum tersedia"),
            ),
          );
        } else if (label == "Quiz") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuizPage()),
          );
        } else if (label == "Mencari\nDalang") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CariDalangPage()),
          );
        } else if (label == "Menjadi\nDalang") {
          // Navigasi ke halaman menjadi dalang (belum ada, placeholder)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Halaman Menjadi Dalang belum tersedia"),
            ),
          );
        }
      },
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xffF3E7D3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(child: Image.asset(icon, height: 30)),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xff4B3425),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
