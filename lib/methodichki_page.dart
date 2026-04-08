import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';
import 'app_background.dart';

class MethodichkaItem {
  final String title;
  final String fileName;
  final String assetPath;

  const MethodichkaItem({
    required this.title,
    required this.fileName,
    required this.assetPath,
  });
}

class MethodichkiPage extends StatelessWidget {
  const MethodichkiPage({super.key});

  static const List<MethodichkaItem> methodichki = [
    MethodichkaItem(
      title: 'Методические указания по ДП',
      fileName: 'metodicheskie ukfzania po DP.docx',
      assetPath: 'assets/methodichki/metodicheskie ukfzania po DP.docx',
    ),
    MethodichkaItem(
      title: 'Методичка курсовой 2026',
      fileName: 'metodichka kursovoi 2026.docx',
      assetPath: 'assets/methodichki/metodichka kursovoi 2026.docx',
    ),

  ];

  Future<File> _copyAssetToLocalFile(MethodichkaItem item) async {
    final data = await rootBundle.load(item.assetPath);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${item.fileName}');
    await file.writeAsBytes(
      data.buffer.asUint8List(),
      flush: true,
    );
    return file;
  }

  Future<void> _openFile(BuildContext context, MethodichkaItem item) async {
    try {
      final file = await _copyAssetToLocalFile(item);
      await OpenFilex.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось открыть файл: $e')),
      );
    }
  }

  Future<void> _downloadFile(BuildContext context, MethodichkaItem item) async {
    try {
      final file = await _copyAssetToLocalFile(item);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Файл сохранён: ${file.path}'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось сохранить файл: $e')),
      );
    }
  }

  Future<void> _shareFile(BuildContext context, MethodichkaItem item) async {
    try {
      final file = await _copyAssetToLocalFile(item);
      await Share.shareXFiles(
        [XFile(file.path)],
        text: item.title,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось поделиться файлом: $e')),
      );
    }
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
              Icons.description,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Методички',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Здесь можно открыть, скачать или отправить учебные Word-файлы.',
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

  Widget buildMethodichkaCard(BuildContext context, MethodichkaItem item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
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
                  color: const Color(0xFF1565C0).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.description,
                  color: Color(0xFF1565C0),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            item.fileName,
            style: const TextStyle(
              fontSize: 14.5,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _openFile(context, item),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Открыть'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _downloadFile(context, item),
                  icon: const Icon(Icons.download),
                  label: const Text('Скачать'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _shareFile(context, item),
              icon: const Icon(Icons.share),
              label: const Text('Поделиться'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF6A1B9A),
                side: const BorderSide(
                  color: Color(0xFF6A1B9A),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
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
        title: const Text('Методички'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1565C0),
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
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                buildHeaderCard(),
                const SizedBox(height: 18),
                ...methodichki.map((item) => buildMethodichkaCard(context, item)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}