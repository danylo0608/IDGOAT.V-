import 'package:flutter/material.dart';
import 'package:idgoat/screens/app/navigation/screens/main_layout_screen.dart';
import 'package:idgoat/theme/colors.dart';

class ProfileSelectionScreen extends StatelessWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // 1. Заголовок (фіксований зверху)
              _buildHeader(),
              
              const SizedBox(height: 24),
              
              // 2. Зона з картками, яка тепер ЗАВЖДИ прокручується
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(), // Додає приємний iOS-подібний відскок при скролі
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildProfileCards(context),
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // 3. Кнопка Назад (завжди зафіксована в самому низу екрана)
              _buildBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- 1. Заголовок екрана ---
  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          'Оберіть свій профіль',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Виберіть тип облікового запису для початку роботи',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textMuted, fontSize: 16),
        ),
      ],
    );
  }

  // --- 2. Список карток профілів ---
  Widget _buildProfileCards(BuildContext context) {
    return Column(
      children: [
        _buildProfileCard(
          title: 'Я Фермер (Заводчик)',
          subtitle: 'Керуйте своїм стадом, ведіть облік та продавайте тварин',
          icon: Icons.agriculture,
          iconColor: AppColors.textMuted,
          // iconColor: AppColors.textGold,
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainLayoutScreen()),
              (route) => false,
            );
          },
        ),
        _buildProfileCard(
          title: 'Я Гість (Покупець)',
          subtitle: 'Купуйте тварин та переглядайте найкращі пропозиції на ринку',
          icon: Icons.person_search,
          iconColor: AppColors.textMuted,
        ),
        _buildProfileCard(
          title: 'Я Бізнес-партнер',
          subtitle: 'Продавайте корми, обладнання та послуги на Дошці оголошень',
          icon: Icons.storefront,
          iconColor: AppColors.textMuted,
        ),
      ],
    );
  }

  // --- 3. Кнопка Назад ---
  Widget _buildBackButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back, color: AppColors.textMuted, size: 20),
      label: const Text(
        'НАЗАД',
        style: TextStyle(
          color: AppColors.textMuted,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  // Допоміжний віджет для створення картки профілю
  Widget _buildProfileCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderGold),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(24),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 32),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            subtitle,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white24),
        onTap: onTap,
      ),
    );
  }
}