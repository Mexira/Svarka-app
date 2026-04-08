import 'package:flutter/material.dart';
import 'app_background.dart';

class AllFormulasPage extends StatelessWidget {
  const AllFormulasPage({super.key});

  Widget buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.42),
        borderRadius: BorderRadius.circular(26),
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
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.functions,
              color: Colors.white,
              size: 38,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Все формулы',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Основные расчётные формулы по видам сварки для учебного использования.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.92),
              fontSize: 15.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormulaCard({
    required String title,
    required String formula,
    required String description,
    required List<String> meanings,
    required Color accentColor,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: accentColor.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: accentColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              formula,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15.5,
              height: 1.45,
              color: Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Обозначения:',
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          ...meanings.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
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
                        fontSize: 15,
                        height: 1.4,
                        color: Color(0xFF374151),
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
        title: const Text('Все формулы'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1976D2),
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

                  buildSectionTitle(
                    icon: Icons.flash_on,
                    title: 'Ручная дуговая сварка',
                    color: const Color(0xFFFF9800),
                  ),
                  buildFormulaCard(
                    title: 'Сварочный ток',
                    formula: 'Iсв = K × dэ',
                    description:
                    'Формула используется для расчёта силы сварочного тока при ручной дуговой сварке.',
                    meanings: const [
                      'Iсв — сила сварочного тока, А',
                      'K — коэффициент',
                      'dэ — диаметр электрода, мм',
                    ],
                    accentColor: const Color(0xFFFF9800),
                  ),
                  buildFormulaCard(
                    title: 'Скорость сварки',
                    formula: 'Vсв = aн × Iсв / (ρ × Fшв) × 100',
                    description:
                    'Формула используется для расчёта скорости сварки.',
                    meanings: const [
                      'Vсв — скорость сварки, м/ч',
                      'aн — коэффициент наплавки, г/А·ч',
                      'Iсв — сварочный ток, А',
                      'ρ — плотность металла, г/см³',
                      'Fшв — площадь поперечного сечения шва, см²',
                    ],
                    accentColor: const Color(0xFFFF9800),
                  ),

                  buildSectionTitle(
                    icon: Icons.settings_input_component,
                    title: 'Сварка под флюсом',
                    color: const Color(0xFF1976D2),
                  ),
                  buildFormulaCard(
                    title: 'Сварочный ток',
                    formula: 'Iсв = π × d² / 4 × a',
                    description:
                    'Расчёт тока по диаметру проволоки и плотности тока.',
                    meanings: const [
                      'Iсв — сила сварочного тока, А',
                      'd — диаметр электродной проволоки, мм',
                      'a — плотность тока, А/мм²',
                    ],
                    accentColor: const Color(0xFF1976D2),
                  ),
                  buildFormulaCard(
                    title: 'Скорость подачи проволоки',
                    formula: 'Vп.п = 4 × aр × Iсв / (π × dпр² × ρ)',
                    description:
                    'Определение скорости подачи электродной проволоки.',
                    meanings: const [
                      'Vп.п — скорость подачи проволоки, м/ч',
                      'aр — коэффициент расплавления, г/А·ч',
                      'Iсв — сварочный ток, А',
                      'dпр — диаметр проволоки, мм',
                      'ρ — плотность металла, г/см³',
                    ],
                    accentColor: const Color(0xFF1976D2),
                  ),

                  buildSectionTitle(
                    icon: Icons.electrical_services,
                    title: 'Электрошлаковая сварка',
                    color: const Color(0xFF8E24AA),
                  ),
                  buildFormulaCard(
                    title: 'Количество электродов',
                    formula: 'nэл = S / lэ',
                    description:
                    'Формула используется для определения количества электродных проволок.',
                    meanings: const [
                      'nэл — число электродов',
                      'S — толщина свариваемого металла, мм',
                      'lэ — расстояние между электродами, мм',
                    ],
                    accentColor: const Color(0xFF8E24AA),
                  ),
                  buildFormulaCard(
                    title: 'Сварочный ток',
                    formula: 'Iсв = A + B × S / nэл\nIсвп = Iсв × nэл',
                    description:
                    'Расчёт тока на один электрод и суммарного сварочного тока.',
                    meanings: const [
                      'Iсв — ток на один электрод, А',
                      'Iсвп — суммарный ток, А',
                      'A, B — коэффициенты',
                      'S — толщина металла, мм',
                      'nэл — количество электродов',
                    ],
                    accentColor: const Color(0xFF8E24AA),
                  ),

                  buildSectionTitle(
                    icon: Icons.co2,
                    title: 'Сварка в CO₂',
                    color: const Color(0xFF388E3C),
                  ),
                  buildFormulaCard(
                    title: 'Сварочный ток',
                    formula: 'Iсв = π × dэ² / 4 × a',
                    description:
                    'Расчёт силы сварочного тока при сварке в CO₂.',
                    meanings: const [
                      'Iсв — сварочный ток, А',
                      'dэ — диаметр электродной проволоки, мм',
                      'a — плотность тока, А/мм²',
                    ],
                    accentColor: const Color(0xFF388E3C),
                  ),
                  buildFormulaCard(
                    title: 'Скорость подачи проволоки',
                    formula: 'Vп.п = 4 × aр × Iсв / (π × dэ² × ρ)',
                    description:
                    'Формула для определения скорости подачи проволоки.',
                    meanings: const [
                      'Vп.п — скорость подачи проволоки, м/ч',
                      'aр — коэффициент расплавления, г/А·ч',
                      'Iсв — сварочный ток, А',
                      'dэ — диаметр проволоки, мм',
                      'ρ — плотность металла, г/см³',
                    ],
                    accentColor: const Color(0xFF388E3C),
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