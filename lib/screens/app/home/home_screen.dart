import 'package:flutter/material.dart';
import 'package:idgoat/screens/app/home/my_yard_screen.dart';
import 'package:idgoat/screens/app/navigation/widgets/app_drawer.dart';
import 'package:idgoat/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.showMyYard,
    required this.onOpenMyYard,
    required this.onCloseMyYard,
    required this.onOpenMyGoats,
  });

  final bool showMyYard;
  final VoidCallback onOpenMyYard;
  final VoidCallback onCloseMyYard;
  final VoidCallback onOpenMyGoats;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !showMyYard,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && showMyYard) {
          onCloseMyYard();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: showMyYard ? null : const AppDrawer(),
        appBar: _buildAppBar(context),
        body: showMyYard
            ? MyYardScreen(onOpenMyGoats: onOpenMyGoats)
            : _buildHomeBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: showMyYard
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textMuted),
              onPressed: onCloseMyYard,
            )
          : Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: AppColors.textMuted),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      title: Text(
        showMyYard ? 'Мій двір' : 'IDGOAT',
        style: TextStyle(
          color: showMyYard ? Colors.white : AppColors.textGold,
          fontWeight: FontWeight.bold,
          letterSpacing: showMyYard ? 0 : 1.5,
          fontSize: showMyYard ? 18 : null,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.textMuted),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            showMyYard ? Icons.notifications_none : Icons.notifications,
            color: showMyYard ? AppColors.textMuted : AppColors.textGold,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: AppColors.textMuted),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHomeBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildUserInfo(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildPointsAndMenuButtons(context),
                const SizedBox(height: 20),
                _buildWeeklyPromo(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 1. Про користувача (Реалізовано без зовнішніх картинок) ---
  Widget _buildUserInfo() {
    return Stack(
      children: [
        // Красивий градієнтний фон, який імітує темну атмосферу додатка з макету
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF13221C), // Дуже темний зелено-чорний
                Color(0xFF1C352D), // Зелений відтінок фірмового фону
              ],
            ),
          ),
        ),
        // Контент профілю
        Positioned(
          bottom: 20,
          left: 16,
          right: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Аватарка (Замість фото — іконка або ініціали на золотому фоні)
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColors.textGold,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 46,
                      backgroundColor: Color(0xFF13221C),
                      child: Text(
                        'МК', // Ініціали "Мирослав Кравченко"
                        style: TextStyle(
                          color: AppColors.textGold,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Золота плашка PREMIUM
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.textGold,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star, size: 10, color: Colors.black),
                          SizedBox(width: 4),
                          Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Текстові дані користувача
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Мирослав Кравченко',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.agriculture, size: 16, color: AppColors.textGold),
                        SizedBox(width: 6),
                        Text(
                          'Ферма: Енеїда',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ID: IDG-MYROSLAV',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                    Text(
                      'Регіон: Харківщина',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 2. Поінти + 3 кнопки ---
  Widget _buildPointsAndMenuButtons(BuildContext context) {
    return Column(
      children: [
        // Плашка балансу
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.textGold.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.account_balance_wallet, color: AppColors.textGold, size: 24),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'МОЇ ПОЇНТИ',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 11, letterSpacing: 1),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '12,500',
                    style: TextStyle(color: AppColors.textGold, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              // Кнопка поповнити баланс
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB4C8C1), // Колір плашки з оригінального дизайну
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                icon: const Icon(Icons.add_circle_outline, size: 18),
                label: const Text(
                  'ПОПОВНИТИ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Рядок із трьома великими навігаційними кнопками
        Row(
          children: [
            Expanded(
              child: _buildSquareMenuButton(
                label: 'МІЙ ДВІР',
                icon: Icons.pets,
                onTap: onOpenMyYard,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSquareMenuButton(
                label: 'РИНОК',
                icon: Icons.storefront,
                onTap: () => _showInDevelopmentMessage(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSquareMenuButton(
                label: 'ОГОЛОШЕННЯ',
                icon: Icons.campaign,
                onTap: () => _showInDevelopmentMessage(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showInDevelopmentMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('В розробці'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Допоміжна функція для побудови однакових квадратних кнопок
  Widget _buildSquareMenuButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.textGold, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 3. Акція тижня ---
  Widget _buildWeeklyPromo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3EE), // Світла картка (кремова), як на фото
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Тег "АКЦІЯ ТИЖНЯ"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E2D9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'АКЦІЯ ТИЖНЯ',
              style: TextStyle(
                color: Color(0xFF5A574F),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Контент акції
          const Text(
            'Суперпропозиція:\nПреміум корм для ваших кіз',
            style: TextStyle(
              color: Color(0xFF1C2D27), // Темно-зелений глибокий колір тексту
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}