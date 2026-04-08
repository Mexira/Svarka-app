import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'app_background.dart';
class ElectroslagPage extends StatefulWidget {
  const ElectroslagPage({super.key});

  @override
  State<ElectroslagPage> createState() => _ElectroslagPageState();
}

class _ElectroslagPageState extends State<ElectroslagPage> {
  final thicknessController = TextEditingController(text: '100');
  final gapController = TextEditingController(text: '25');
  final electrodesController = TextEditingController(text: '2');
  final aCoeffController = TextEditingController(text: '250');
  final bCoeffController = TextEditingController(text: '3.5');
  final lnController = TextEditingController(text: '32');
  final kuController = TextEditingController(text: '1.08');

  String result = '';

  double? parse(TextEditingController c) {
    return double.tryParse(c.text.replaceAll(',', '.'));
  }

  void calculate() {
    final s = parse(thicknessController);
    final gap = parse(gapController);
    final n = parse(electrodesController);
    final a = parse(aCoeffController);
    final b = parse(bCoeffController);
    final ln = parse(lnController);
    final ku = parse(kuController);

    if ([s, gap, n, a, b, ln, ku].contains(null)) {
      setState(() {
        result = 'Ошибка: заполни все поля числами.';
      });
      return;
    }

    if (n! <= 0 || gap! <= 0 || s! <= 0 || ku! <= 0) {
      setState(() {
        result =
        'Ошибка: значения толщины, зазора, количества электродов и Kу должны быть больше нуля.';
      });
      return;
    }

    const double rho = 7.8;

    final double iOne = a! + b! * s / n;
    final double iTotal = iOne * n;
    final double uSlag = 12 + math.sqrt(125 + s / (0.075 * n));
    final double vFeed = iOne / 1.9;
    final double vWeld = (n * ln! * iOne) / (rho * gap * s * ku) * 100.0;
    final double hSlag = iTotal * (0.0000375 * iOne - 0.0025) + 30;
    final double crossMove = 66 - 0.22 * s / n;
    final double holdTime = 0.0375 * s / n + 0.75;

    setState(() {
      result = '''
Электрошлаковая сварка

Исходные данные:
Толщина металла S = ${s.toStringAsFixed(2)} мм
Зазор в стыке B = ${gap.toStringAsFixed(2)} мм
Количество электродов nэл = ${n.toStringAsFixed(0)}
Коэффициент A = ${a.toStringAsFixed(2)}
Коэффициент B = ${b.toStringAsFixed(2)}
Коэффициент наплавки Lн = ${ln.toStringAsFixed(2)} г/А·ч
Коэффициент Kу = ${ku.toStringAsFixed(2)}

1) Ток на один электрод:
Iсв = A + B × S / nэл
Iсв = ${a.toStringAsFixed(2)} + ${b.toStringAsFixed(2)} × ${s.toStringAsFixed(2)} / ${n.toStringAsFixed(0)}
Iсв = ${iOne.toStringAsFixed(2)} А

2) Суммарный ток:
Iсвп = Iсв × nэл
Iсвп = ${iOne.toStringAsFixed(2)} × ${n.toStringAsFixed(0)}
Iсвп = ${iTotal.toStringAsFixed(2)} А

3) Напряжение шлаковой ванны:
Uш.в = 12 + √(125 + S / (0.075 × nэл))
Uш.в = 12 + √(125 + ${s.toStringAsFixed(2)} / (0.075 × ${n.toStringAsFixed(0)}))
Uш.в = ${uSlag.toStringAsFixed(2)} В

4) Скорость подачи электродов:
Vп.э = Iсв / 1.9
Vп.э = ${iOne.toStringAsFixed(2)} / 1.9
Vп.э = ${vFeed.toStringAsFixed(2)} м/ч

5) Скорость сварки:
Vсв = nэл × Lн × Iсв / (ρ × B × S × Kу) × 100
Vсв = ${n.toStringAsFixed(0)} × ${ln.toStringAsFixed(2)} × ${iOne.toStringAsFixed(2)} / (7.8 × ${gap.toStringAsFixed(2)} × ${s.toStringAsFixed(2)} × ${ku.toStringAsFixed(2)}) × 100
Vсв = ${vWeld.toStringAsFixed(2)} м/ч

6) Глубина шлаковой ванны:
hшл = Iсвп × (0.0000375 × Iсв − 0.0025) + 30
hшл = ${hSlag.toStringAsFixed(2)} мм

7) Скорость поперечных перемещений:
Uп.п = 66 − 0.22 × S / nэл
Uп.п = 66 − 0.22 × ${s.toStringAsFixed(2)} / ${n.toStringAsFixed(0)}
Uп.п = ${crossMove.toStringAsFixed(2)} м/ч

8) Время выдержки у ползуна:
tв = 0.0375 × S / nэл + 0.75
tв = 0.0375 × ${s.toStringAsFixed(2)} / ${n.toStringAsFixed(0)} + 0.75
tв = ${holdTime.toStringAsFixed(2)} с
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
              color: Colors.blueGrey.withOpacity(0.10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFF7B1FA2),
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
            Color(0xFF6A1B9A),
            Color(0xFF8E24AA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6A1B9A).withOpacity(0.25),
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
              Icons.electrical_services,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Электрошлаковая сварка',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Калькулятор для студентов: ток, напряжение шлаковой ванны, скорость подачи, скорость сварки и дополнительные параметры.',
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
                color: Color(0xFF6A1B9A),
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
                color: Color(0xFF6A1B9A),
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
    gapController.dispose();
    electrodesController.dispose();
    aCoeffController.dispose();
    bCoeffController.dispose();
    lnController.dispose();
    kuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text('Электрошлаковая сварка'),
        centerTitle: true,
        backgroundColor: const Color(0xFF6A1B9A),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          children: [
            infoCard(),
            const SizedBox(height: 18),
            field('Толщина металла S, мм', thicknessController),
            field('Зазор в стыке B, мм', gapController),
            field('Количество электродов nэл', electrodesController),
            field('Коэффициент A', aCoeffController),
            field('Коэффициент B', bCoeffController),
            field('Коэффициент наплавки Lн, г/А·ч', lnController),
            field('Коэффициент Kу', kuController),
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
            const SizedBox(height: 18),
            resultCard(),
          ],
        ),
      ),
    );
  }
}