import 'package:flutter/material.dart';
import 'app_background.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Widget buildSectionCard({
    required IconData icon,
    required String title,
    required String text,
    Color iconBgColor = const Color(0xFF6A1B9A),
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBgColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: iconBgColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 15.5,
                    height: 1.45,
                    color: Color(0xFF4B5563),
                  ),
                ),
              ],
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
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.engineering,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Сварка для студентов',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Учебное приложение.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text('О приложении'),
        centerTitle: true,
        backgroundColor: const Color(0xFF263238),
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                children: [
                  buildHeaderCard(),
                  const SizedBox(height: 18),
                  buildSectionCard(
                    icon: Icons.info_outline,
                    title: 'О приложении',
                    text:
                    'Это учебное приложение по сварке для студентов. В нём собраны основные виды сварки, формулы, расчёты и другие полезные и важные разделы для будующих специалистов.',
                    iconBgColor: const Color(0xFF1976D2),
                  ),
                  buildSectionCard(
                    icon: Icons.school_outlined,
                    title: 'Назначение',
                    text:
                    'Приложение помогает изучать теорию, выполнять расчёты и использовать формулы в учебной работе.',
                    iconBgColor: const Color(0xFF388E3C),
                  ),
                  buildSectionCard(
                    icon: Icons.build_circle_outlined,
                    title: 'Что есть в приложении',
                    text:
                    'В приложении есть Калькулятор по видам сварки, Основные формулы для стуудентов, плакаты, методички, ГОСТы и техника безопасности .',
                    iconBgColor: const Color(0xFFE65100),
                  ),
                  buildSectionCard(
                    icon: Icons.person,
                    title: 'Разработчик',
                    text:
                    'Разработчик: Борис Ищенко.\nУчебный проект по сварке для студентов, в частности Ангарского индустриального техникума.',
                    iconBgColor: const Color(0xFF6A1B9A),
                  ),
                  buildSectionCard(
                    icon: Icons.update,
                    title: 'Версия',
                    text:
                    'Версия приложения: 1.3.0.\nДобавлены разделы с Плакатами, методичками и Гостами, где можно скачать, открыть и поделиться этими файлами',
                    iconBgColor: const Color(0xFF2E7D32),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}