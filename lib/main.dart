import 'package:flutter/material.dart';
import 'all_welding_page.dart';
import 'all_formulas_page.dart';
import 'safety_page.dart';
import 'about_page.dart';
import 'app_background.dart';
import 'posters_page.dart';
import 'methodichki_page.dart';
import 'gosty_page.dart';





void main() {
  runApp(const SvarkaStudentApp());
}

class SvarkaStudentApp extends StatelessWidget {
  const SvarkaStudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Сварка для студентов',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F5F7),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void changeBackground() {
    setState(() {
      AppBackground.changeRandom();
    });
  }

  Widget buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 26, color: textColor),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor.withOpacity(0.92),
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 18),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  Widget buildInfoChip({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.42),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withOpacity(0.14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.22),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.engineering,
              size: 42,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Сварка для студентов',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Учебное приложение ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.92),
              fontSize: 15.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              buildInfoChip(
                icon: Icons.calculate,
                text: 'Расчёты',
              ),
              buildInfoChip(
                icon: Icons.functions,
                text: 'Формулы',
              ),
              buildInfoChip(
                icon: Icons.health_and_safety,
                text: 'Безопасность',
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: changeBackground,
              icon: const Icon(Icons.image, color: Colors.white),
              label: const Text(
                'Сменить фон',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.35),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сварка для студентов'),
        centerTitle: true,
        backgroundColor: const Color(0xFF111827),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppBackground.currentBackground,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.45),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                children: [
                  buildHeaderCard(),
                  const SizedBox(height: 20),
                  buildMenuButton(
                    context: context,
                    icon: Icons.flash_on,
                    title: 'Виды сварки',
                    backgroundColor: const Color(0xFFE65100),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllWeldingPage(),
                        ),
                      );
                    },
                  ),
                  buildMenuButton(
                    context: context,
                    icon: Icons.functions,
                    title: 'Формулы',
                    backgroundColor: const Color(0xFF1976D2),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllFormulasPage(),
                        ),
                      );
                    },
                  ),
                  buildMenuButton(
                    context: context,
                    icon: Icons.photo_library,
                    title: 'Плакаты',
                    backgroundColor: const Color(0xFFCAB62B),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PostersPage(),
                        ),
                      );
                    },
                  ),

                  buildMenuButton(
                    context: context,
                    icon: Icons.description,
                    title: 'Методички',
                    backgroundColor: const Color(0xFF0F9F8E),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MethodichkiPage(),
                        ),
                      );
                    },
                  ),
                  buildMenuButton(
                    context: context,
                    icon: Icons.menu_book,
                    title: 'ГОСТы',
                    backgroundColor: const Color(0xFF5B5F63),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GostyPage(),
                        ),
                      );
                    },
                  ),


                  buildMenuButton(
                    context: context,
                    icon: Icons.health_and_safety,
                    title: 'Техника безопасности',
                    backgroundColor: const Color(0xFF2E7D32),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SafetyPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF111827),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.info_outline,
                size: 24,
                color: Colors.white,
              ),
              label: const Text(
                'О приложении',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A1B9A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}