import 'package:flutter/material.dart';
import 'app_background.dart';
class Practice8Page extends StatefulWidget {
  const Practice8Page({super.key});

  @override
  State<Practice8Page> createState() => _Practice8PageState();
}

class _Practice8PageState extends State<Practice8Page> {
  final TextEditingController thicknessController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController diameterController = TextEditingController();

  String selectedConnectionType = 'Стыковое';
  String selectedSteel = 'Ст3сп';
  String resultText = '';

  void calculate() {
    final double? thickness = double.tryParse(thicknessController.text);
    final double? length = double.tryParse(lengthController.text);
    final double? diameter = double.tryParse(diameterController.text);

    if (thickness == null || length == null || diameter == null) {
      setState(() {
        resultText = 'Ошибка: заполните все поля числами.';
      });
      return;
    }

    double k;

    if (diameter >= 1 && diameter <= 2) {
      k = 27;
    } else if (diameter >= 3 && diameter <= 4) {
      k = 35;
    } else if (diameter >= 5 && diameter <= 6) {
      k = 50;
    } else {
      setState(() {
        resultText = 'Ошибка: диаметр электрода должен быть в диапазоне 1–6 мм.';
      });
      return;
    }

    double current = k * diameter;

    if (thickness >= 3) {
      current = current * 1.1;
    }

    const double aN = 8.5;
    const double density = 7.8;
    const double fShv = 0.3;

    final double speed = (aN * current) / (density * fShv) * 100;
    final double lengthCm = length / 10;
    final double mass = fShv * lengthCm * density;
    final double mainTime = mass / (current * aN);
    final double totalTime = mainTime / 0.55;
    final double electrodes = mass / 1000 * 1.6;

    setState(() {
      resultText = '''
Исходные данные:
Тип соединения: $selectedConnectionType
Марка стали: $selectedSteel
Толщина металла: ${thickness.toStringAsFixed(2)} мм
Длина шва: ${length.toStringAsFixed(2)} мм
Диаметр электрода: ${diameter.toStringAsFixed(2)} мм

1. Расчёт сварочного тока:
Iсв = K × dэ
Iсв = ${k.toStringAsFixed(0)} × ${diameter.toStringAsFixed(2)} = ${(k * diameter).toStringAsFixed(2)} А

С учётом поправки по толщине:
Iсв = ${current.toStringAsFixed(2)} А

2. Скорость сварки:
Vсв = aн × Iсв / (ρ × Fшв) × 100
Vсв = ${speed.toStringAsFixed(2)} м/ч

3. Масса наплавленного металла:
Gн = Fшв × L × ρ
Gн = ${mass.toStringAsFixed(2)} г

4. Основное время:
tо = Gн / (Iсв × aн)
tо = ${mainTime.toStringAsFixed(4)} ч

5. Полное время сварки:
T = tо / Kп
T = ${totalTime.toStringAsFixed(4)} ч

6. Расход электродов:
Gм = Gн × Kэ
Gм = ${electrodes.toStringAsFixed(3)} кг
''';
    });
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    thicknessController.dispose();
    lengthController.dispose();
    diameterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Практическая №8'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Расчёт режимов ручной дуговой сварки',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedConnectionType,
              decoration: InputDecoration(
                labelText: 'Тип соединения',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Стыковое', child: Text('Стыковое')),
                DropdownMenuItem(value: 'Угловое', child: Text('Угловое')),
                DropdownMenuItem(value: 'Тавровое', child: Text('Тавровое')),
                DropdownMenuItem(value: 'Нахлесточное', child: Text('Нахлесточное')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedConnectionType = value!;
                });
              },
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: selectedSteel,
              decoration: InputDecoration(
                labelText: 'Марка стали',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Ст3сп', child: Text('Ст3сп')),
                DropdownMenuItem(value: '09Г2С', child: Text('09Г2С')),
                DropdownMenuItem(value: '10ХСНД', child: Text('10ХСНД')),
                DropdownMenuItem(value: '20', child: Text('20')),
                DropdownMenuItem(value: '15', child: Text('15')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedSteel = value!;
                });
              },
            ),
            const SizedBox(height: 14),
            buildTextField(
              label: 'Толщина металла, мм',
              controller: thicknessController,
            ),
            buildTextField(
              label: 'Длина шва, мм',
              controller: lengthController,
            ),
            buildTextField(
              label: 'Диаметр электрода, мм',
              controller: diameterController,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Рассчитать',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                resultText.isEmpty
                    ? 'Здесь появятся результаты расчёта.'
                    : resultText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}