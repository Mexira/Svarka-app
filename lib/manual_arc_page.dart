import 'package:flutter/material.dart';
import 'app_background.dart';
class ManualArcPage extends StatefulWidget {
  const ManualArcPage({super.key});

  @override
  State<ManualArcPage> createState() => _ManualArcPageState();
}

class _ManualArcPageState extends State<ManualArcPage> {
  final thicknessController = TextEditingController();
  final lengthController = TextEditingController();
  final diameterController = TextEditingController();
  final areaController = TextEditingController(text: '0.30');
  final anController = TextEditingController(text: '8.5');
  final keController = TextEditingController(text: '1.6');
  final kpController = TextEditingController(text: '0.55');

  String result = '';

  double? parse(TextEditingController c) =>
      double.tryParse(c.text.replaceAll(',', '.'));

  void calculate() {
    final s = parse(thicknessController);
    final lMm = parse(lengthController);
    final d = parse(diameterController);
    final f = parse(areaController);
    final an = parse(anController);
    final ke = parse(keController);
    final kp = parse(kpController);

    if ([s, lMm, d, f, an, ke, kp].contains(null)) {
      setState(() {
        result = 'Ошибка: заполни все поля числами.';
      });
      return;
    }

    double k;
    if (d! >= 1 && d <= 2) {
      k = 27;
    } else if (d >= 3 && d <= 4) {
      k = 35;
    } else if (d >= 5 && d <= 6) {
      k = 50;
    } else {
      setState(() {
        result = 'Диаметр электрода должен быть от 1 до 6 мм.';
      });
      return;
    }

    double currentBase = k * d;
    double current = currentBase;

    if (s! >= 3) {
      current *= 1.10;
    } else if (s <= 1.5 * d) {
      current *= 0.90;
    }

    const rho = 7.8;
    final lCm = lMm! / 10.0;
    final speed = (an! * current) / (rho * f!) * 100.0;
    final mass = f * lCm * rho;
    final tMain = mass / (current * an);
    final tTotal = tMain / kp!;
    final electrodesKg = (mass / 1000.0) * ke!;

    setState(() {
      result = '''
Ручная дуговая сварка

1) Сварочный ток:
Iсв = K × dэ
Iсв = ${k.toStringAsFixed(0)} × ${d.toStringAsFixed(2)} = ${currentBase.toStringAsFixed(2)} А

С учётом поправки:
Iсв = ${current.toStringAsFixed(2)} А

2) Скорость сварки:
Vсв = aн × Iсв / (ρ × Fшв) × 100
Vсв = ${speed.toStringAsFixed(2)} м/ч

3) Масса наплавленного металла:
Gн = Fшв × L × ρ
Gн = ${mass.toStringAsFixed(2)} г

4) Основное время:
tо = Gн / (Iсв × aн)
tо = ${tMain.toStringAsFixed(4)} ч

5) Полное время:
T = tо / Kп
T = ${tTotal.toStringAsFixed(4)} ч

6) Расход электродов:
Gм = Gн × Kэ
Gм = ${electrodesKg.toStringAsFixed(3)} кг
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
              color: Colors.orange.withOpacity(0.14),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFFFF9800),
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
            Color(0xFFE65100),
            Color(0xFFFF9800),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE65100).withOpacity(0.25),
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
              Icons.flash_on,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Ручная дуговая сварка',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Калькулятор для студентов: ток, скорость сварки, масса наплавленного металла, время и расход электродов.',
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
                color: Color(0xFFE65100),
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
                color: Color(0xFFE65100),
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
    thicknessController.dispose();
    lengthController.dispose();
    diameterController.dispose();
    areaController.dispose();
    anController.dispose();
    keController.dispose();
    kpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text('Ручная дуговая сварка'),
        centerTitle: true,
        backgroundColor: const Color(0xFFE65100),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          children: [
            infoCard(),
            const SizedBox(height: 18),
            field('Толщина металла S, мм', thicknessController),
            field('Длина шва L, мм', lengthController),
            field('Диаметр электрода dэ, мм', diameterController),
            field('Площадь шва Fшв, см²', areaController),
            field('Коэффициент наплавки aн, г/А·ч', anController),
            field('Коэффициент расхода электродов Kэ', keController),
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
                  backgroundColor: const Color(0xFFE65100),
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