import 'package:flutter/material.dart';
import 'app_background.dart';

class SafetyPage extends StatelessWidget {
  const SafetyPage({super.key});

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
              Icons.health_and_safety,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Техника безопасности',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Основные правила безопасной работы при сварке.',
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

  Widget buildSafetyCard({
    required IconData icon,
    required String title,
    required List<String> items,
    required Color accentColor,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: accentColor.withOpacity(0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: accentColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...items.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.only(top: 7, right: 10),
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15.5,
                        height: 1.45,
                        color: Color(0xFF4B5563),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text('Техника безопасности'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
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
                  buildSafetyCard(
                    icon: Icons.visibility,
                    title: 'Средства индивидуальной защиты',
                    accentColor: const Color(0xFF2E7D32),
                    items: const [
                      'Использовать сварочную маску или щиток с подходящим светофильтром.',
                      'Надевать краги, плотную спецодежду и закрытую обувь.',
                      'Одежда должна защищать кожу от искр и брызг металла.',
                    ],
                  ),
                  buildSafetyCard(
                    icon: Icons.electrical_services,
                    title: 'Электробезопасность',
                    accentColor: const Color(0xFF1976D2),
                    items: const [
                      'Перед началом работы проверить исправность аппарата и кабелей.',
                      'Не работать с повреждённой изоляцией проводов.',
                      'Не касаться токоведущих частей мокрыми руками.',
                    ],
                  ),
                  buildSafetyCard(
                    icon: Icons.air,
                    title: 'Вентиляция и рабочее место',
                    accentColor: const Color(0xFF00838F),
                    items: const [
                      'Рабочее место должно хорошо проветриваться.',
                      'При сварке в помещении использовать вытяжку или вентиляцию.',
                      'Убрать рядом все легковоспламеняющиеся материалы.',
                    ],
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