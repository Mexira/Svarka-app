import 'package:flutter/material.dart';
import 'app_background.dart';

class PosterItem {
  final String title;
  final String imagePath;

  const PosterItem({
    required this.title,
    required this.imagePath,
  });
}

class PostersPage extends StatelessWidget {
  const PostersPage({super.key});

  static const List<PosterItem> posters = [
    PosterItem(
      title: 'Плакат 1',
      imagePath: 'assets/posters/pl-1.jpg',
    ),
    PosterItem(
      title: 'Плакат 2',
      imagePath: 'assets/posters/pl-2.jpg',
    ),
    PosterItem(
      title: 'Плакат 3',
      imagePath: 'assets/posters/pl-3.jpg',
    ),
    PosterItem(
      title: 'Плакат 4',
      imagePath: 'assets/posters/pl-4.jpg',
    ),
    PosterItem(
      title: 'Плакат 5',
      imagePath: 'assets/posters/pl-5.jpg',
    ),

    PosterItem(
      title: 'Плакат 7',
      imagePath: 'assets/posters/pl-7.jpg',
    ),
    PosterItem(
      title: 'Плакат 8',
      imagePath: 'assets/posters/pl-8.jpg',
    ),

    PosterItem(
      title: 'Плакат 10',
      imagePath: 'assets/posters/pl-10.jpg',
    ),

    PosterItem(
      title: 'Плакат 12',
      imagePath: 'assets/posters/pl-12.jpg',
    ),
    PosterItem(
      title: 'Плакат 13',
      imagePath: 'assets/posters/pl-13.jpg',
    ),
    PosterItem(
      title: 'Плакат 14',
      imagePath: 'assets/posters/pl-14.jpg',
    ),
    PosterItem(
      title: 'Плакат 15',
      imagePath: 'assets/posters/pl-15.jpg',
    ),
    PosterItem(
      title: 'Плакат 16',
      imagePath: 'assets/posters/pl-16.jpg',
    ),

    PosterItem(
      title: 'Плакат 19',
      imagePath: 'assets/posters/pl-19.jpg',
    ),
    PosterItem(
      title: 'Плакат 20',
      imagePath: 'assets/posters/pl-20.jpg',
    ),
    PosterItem(
      title: 'Плакат 21',
      imagePath: 'assets/posters/pl-21.jpg',
    ),
    PosterItem(
      title: 'Плакат 22',
      imagePath: 'assets/posters/pl-22.jpg',
    ),

    PosterItem(
      title: 'Плакат 24',
      imagePath: 'assets/posters/pl-24.jpg',
    ),
    PosterItem(
      title: 'Плакат 25',
      imagePath: 'assets/posters/pl-25.jpg',
    ),

    PosterItem(
      title: 'Плакат 30',
      imagePath: 'assets/posters/pl-30.jpg',
    ),

    PosterItem(
      title: 'Плакат 35',
      imagePath: 'assets/posters/pl-35.jpg',
    ),
    PosterItem(
      title: 'Плакат 36',
      imagePath: 'assets/posters/pl-36.jpg',
    ),

    PosterItem(
      title: 'Плакат 38',
      imagePath: 'assets/posters/pl-38.jpg',
    ),

    PosterItem(
      title: 'Плакат 42',
      imagePath: 'assets/posters/pl-42.jpg',

    ),
    PosterItem(
      title: 'Плакат 44',
      imagePath: 'assets/posters/pl-44.jpg',

    ),
    PosterItem(
      title: 'Плакат 45',
      imagePath: 'assets/posters/pl-45.jpg',

    ),
    PosterItem(
      title: 'Плакат 46',
      imagePath: 'assets/posters/pl-46.jpg',

    ),
    PosterItem(
      title: 'Плакат 47',
      imagePath: 'assets/posters/pl-47.jpg',

    ),
    PosterItem(
      title: 'Плакат 49',
      imagePath: 'assets/posters/pl-49.jpg',

    ),
    PosterItem(
      title: 'Плакат 50',
      imagePath: 'assets/posters/pl-50.jpg',

    ),
    PosterItem(
      title: 'Плакат 51',
      imagePath: 'assets/posters/pl-51.jpg',

    ),
    PosterItem(
      title: 'Плакат 52',
      imagePath: 'assets/posters/pl-52.jpg',

    ),
    PosterItem(
      title: 'Плакат 54',
      imagePath: 'assets/posters/pl-54.jpg',

    ),PosterItem(
      title: 'Плакат 55',
      imagePath: 'assets/posters/pl-55.jpg',

    ),PosterItem(
      title: 'Плакат 56',
      imagePath: 'assets/posters/pl-56.jpg',

    ),
    PosterItem(
      title: 'Правила пользования ',
      imagePath: 'assets/posters/1a.jpeg',
    ),

    PosterItem(
      title: 'Газовые баллоны ',
      imagePath: 'assets/posters/2a.png',
    ), PosterItem(
      title: 'Эксплуатация ',
      imagePath: 'assets/posters/3a.jpeg',
    ),

    PosterItem(
      title: 'ТБ быт. газ',
      imagePath: 'assets/posters/5a.jpeg',
    ), PosterItem(
      title: 'Газовый баллон ',
      imagePath: 'assets/posters/full_52.jpg',
    ), PosterItem(
      title: 'Азот ',
      imagePath: 'assets/posters/slide-3.jpg',
    ), PosterItem(
      title: 'Транспортировка ',
      imagePath: 'assets/posters/st.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text('Плакаты'),
        centerTitle: true,
        backgroundColor: const Color(0xFF37474F),
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
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: posters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final poster = posters[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PosterViewerPage(poster: poster),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(22),
                            ),
                            child: Image.asset(
                              poster.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFECEFF1),
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 42,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            poster.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PosterViewerPage extends StatelessWidget {
  final PosterItem poster;

  const PosterViewerPage({super.key, required this.poster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(poster.title),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.8,
          maxScale: 4.0,
          child: Image.asset(
            poster.imagePath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.broken_image,
                    color: Colors.white70,
                    size: 60,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Не удалось открыть изображение',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}