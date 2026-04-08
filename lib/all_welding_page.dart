import 'package:flutter/material.dart';
import 'manual_arc_page.dart';
import 'submerged_arc_page.dart';
import 'electroslag_page.dart';
import 'co2_page.dart';
import 'app_background.dart';

class AllWeldingPage extends StatelessWidget {
  const AllWeldingPage({super.key});

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
            'Все сварки',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Выбери нужный вид сварки и открой калькулятор с расчётами.',
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

  Widget buildWeldingCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color startColor,
    required Color endColor,
    required Widget page,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: startColor.withOpacity(0.22),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.92),
                fontSize: 15.5,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => page),
                  );
                },
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text(
                  'Открыть калькулятор',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: startColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text('Все сварки'),
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
                  buildWeldingCard(
                    context: context,
                    icon: Icons.flash_on,
                    title: 'Ручная дуговая сварка',
                    description:
                    'Расчёт тока, скорости сварки, массы наплавленного металла, времени и расхода электродов.',
                    startColor: const Color(0xFFE65100),
                    endColor: const Color(0xFFFF9800),
                    page: const ManualArcPage(),
                  ),
                  buildWeldingCard(
                    context: context,
                    icon: Icons.settings_input_component,
                    title: 'Сварка под флюсом',
                    description:
                    'Расчёт тока, коэффициентов, скорости подачи проволоки, скорости сварки, расхода проволоки и флюса.',
                    startColor: const Color(0xFF0D47A1),
                    endColor: const Color(0xFF1976D2),
                    page: const SubmergedArcPage(),
                  ),
                  buildWeldingCard(
                    context: context,
                    icon: Icons.electrical_services,
                    title: 'Электрошлаковая сварка',
                    description:
                    'Расчёт числа электродов, тока на электрод, суммарного тока, напряжения шлаковой ванны и скорости сварки.',
                    startColor: const Color(0xFF6A1B9A),
                    endColor: const Color(0xFF8E24AA),
                    page: const ElectroslagPage(),
                  ),
                  buildWeldingCard(
                    context: context,
                    icon: Icons.co2,
                    title: 'Сварка в CO₂',
                    description:
                    'Расчёт тока, напряжения дуги, расхода газа, скорости подачи проволоки, времени и расхода проволоки.',
                    startColor: const Color(0xFF1B5E20),
                    endColor: const Color(0xFF388E3C),
                    page: const Co2Page(),
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