import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'app_background.dart';
class SubmergedArcPage extends StatefulWidget {
  const SubmergedArcPage({super.key});

  @override
  State<SubmergedArcPage> createState() => _SubmergedArcPageState();
}

class _SubmergedArcPageState extends State<SubmergedArcPage> {
  final diameterController = TextEditingController(text: '3');
  final currentDensityController = TextEditingController(text: '40');
  final seamAreaController = TextEditingController(text: '0.50');
  final lengthController = TextEditingController(text: '1000');
  final psiController = TextEditingController(text: '0.03');
  final kpController = TextEditingController(text: '0.65');

  String currentType = 'Переменный ток';
  String result = '';

  double? parse(TextEditingController c) =>
      double.tryParse(c.text.replaceAll(',', '.'));

  void calculate() {
    final d = parse(diameterController);
    final a = parse(currentDensityController);
    final f = parse(seamAreaController);
    final lMm = parse(lengthController);
    final psi = parse(psiController);
    final kp = parse(kpController);

    if ([d, a, f, lMm, psi, kp].contains(null)) {
      setState(() {
        result = 'Ошибка: заполни все поля числами.';
      });
      return;
    }

    const rho = 7.8;
    final current = (math.pi * d! * d / 4.0) * a!;
    double ar;

    if (currentType == 'Переменный ток') {
      ar = 7.0 + 0.04 * current / d;
    } else {
      ar = 11.0;
    }

    final an = ar * (1 - psi!);
    final vFeed = (4 * ar * current) / (math.pi * d * d * rho);
    final vWeld = (an * current) / (rho * f!) * 100.0;
    final arcVoltage = 34.0;
    final fluxConsumption = ((arcVoltage - 1.8) * 780) / vWeld;
    final lCm = lMm! / 10.0;
    final gN = f * lCm * rho;
    final gWire = gN * (1 + psi);
    final tMain = gN / (current * an);
    final tTotal = tMain / kp!;

    setState(() {
      result = '''
Сварка под флюсом

1) Сварочный ток:
Iсв = π × d² / 4 × a
Iсв = ${current.toStringAsFixed(2)} А

2) Коэффициент расплавления:
aр = ${ar.toStringAsFixed(2)} г/А·ч

3) Коэффициент наплавки:
aн = aр × (1 - ψ)
aн = ${an.toStringAsFixed(2)} г/А·ч

4) Скорость подачи проволоки:
Vп.п = 4 × aр × Iсв / (π × d² × ρ)
Vп.п = ${vFeed.toStringAsFixed(2)} м/ч

5) Скорость сварки:
Vсв = aн × Iсв / (ρ × Fв) × 100
Vсв = ${vWeld.toStringAsFixed(2)} м/ч

6) Масса наплавленного металла:
Gн = ${gN.toStringAsFixed(2)} г

7) Расход проволоки:
Gпр = Gн × (1 + ψ)
Gпр = ${(gWire / 1000).toStringAsFixed(3)} кг

8) Расход флюса:
Gф = ((Uд - 1.8) × 780) / Vсв
Gф = ${fluxConsumption.toStringAsFixed(2)} г/пог. м

9) Основное время:
tо = ${tMain.toStringAsFixed(4)} ч

10) Полное время:
T = ${tTotal.toStringAsFixed(4)} ч
''';
    });
  }

  Widget field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF546E7A)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.14),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFF1976D2),
              width: 1.6,
            ),
          ),
        ),
      ),
    );
  }

  Widget infoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0D47A1),
            Color(0xFF1976D2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D47A1).withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.settings_input_component,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Сварка под флюсом',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Калькулятор для студентов: ток, коэффициенты, скорость подачи проволоки, скорость сварки, расход проволоки и флюса.',
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

  Widget resultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: result.isEmpty
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(
                Icons.analytics_outlined,
                color: Color(0xFF0D47A1),
              ),
              SizedBox(width: 8),
              Text(
                'Результаты расчёта',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'После нажатия на кнопку «Рассчитать» здесь появятся все вычисления и готовые результаты.',
            style: TextStyle(
              fontSize: 15.5,
              height: 1.45,
              color: Color(0xFF4B5563),
            ),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.analytics_outlined,
                color: Color(0xFF0D47A1),
              ),
              SizedBox(width: 8),
              Text(
                'Результаты расчёта',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            result,
            style: const TextStyle(
              fontSize: 15.5,
              height: 1.5,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    diameterController.dispose();
    currentDensityController.dispose();
    seamAreaController.dispose();
    lengthController.dispose();
    psiController.dispose();
    kpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text('Сварка под флюсом'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          children: [
            infoCard(),
            const SizedBox(height: 18),
            DropdownButtonFormField<String>(
              value: currentType,
              decoration: InputDecoration(
                labelText: 'Род тока',
                labelStyle: const TextStyle(color: Color(0xFF546E7A)),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.blue.withOpacity(0.14),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Color(0xFF1976D2),
                    width: 1.6,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Переменный ток',
                  child: Text('Переменный ток'),
                ),
                DropdownMenuItem(
                  value: 'Постоянный ток обратной полярности',
                  child: Text('Постоянный ток обратной полярности'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  currentType = value!;
                });
              },
            ),
            const SizedBox(height: 14),
            field('Диаметр проволоки dпр, мм', diameterController),
            field('Плотность тока a, А/мм²', currentDensityController),
            field('Площадь одного валика Fв, см²', seamAreaController),
            field('Длина шва L, мм', lengthController),
            field('Коэффициент потерь ψ', psiController),
            field('Коэффициент использования поста Kп', kpController),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.calculate_rounded, size: 24),
                label: const Text(
                  'Рассчитать',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            resultCard(),
          ],
        ),
      ),
    );
  }
}