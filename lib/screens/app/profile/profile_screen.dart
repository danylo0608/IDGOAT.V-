import 'package:flutter/material.dart';
import 'package:idgoat/theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildStatsBlock(),
              const SizedBox(height: 24),
              _buildSubscriptionBlock(),
              const SizedBox(height: 32),
              _buildActionButtons(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Аватар або логотип ферми
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.textGold.withOpacity(0.5), width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.textGold.withOpacity(0.1),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.person, color: AppColors.textGold, size: 40),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Мирослав Кравченко',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.verified, color: Colors.blue, size: 18),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Адміністратор / Власник ферми',
                style: TextStyle(
                  color: AppColors.textGold,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.email_outlined, color: AppColors.textMuted, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    'm.kravchenko@farm.ua',
                    style: TextStyle(color: AppColors.textMuted.withOpacity(0.8), fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.phone_outlined, color: AppColors.textMuted, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    '+380 67 123 45 67',
                    style: TextStyle(color: AppColors.textMuted.withOpacity(0.8), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsBlock() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'МОЄ ГОСПОДАРСТВО',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Всього кіз: 45',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.textGold.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.pets, color: AppColors.textGold, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'КЕРУВАННЯ ПІДПИСКОЮ',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.cardBackground,
                AppColors.cardBackground.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.textGold.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pro Plan',
                        style: TextStyle(
                          color: AppColors.textGold,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ферма до 50 голів',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.auto_awesome, color: AppColors.textGold, size: 28),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(color: Colors.white10, height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Діє до:',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        '15 Липня, 2026',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textGold,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Оновити тариф',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildMenuTile(
          icon: Icons.logout,
          label: 'Вийти з профілю',
          color: Colors.white,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildMenuTile(
          icon: Icons.delete_forever_outlined,
          label: 'Видалити аккаунт',
          color: Colors.redAccent,
          onTap: () {},
          isWarning: true,
        ),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isWarning = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: isWarning ? Colors.redAccent.withOpacity(0.05) : AppColors.cardBackground.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isWarning ? Colors.redAccent.withOpacity(0.2) : Colors.white.withOpacity(0.05),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: color.withOpacity(0.3), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
