import 'package:flutter/material.dart';
import 'package:idgoat/theme/colors.dart';

class MyYardScreen extends StatelessWidget {
  const MyYardScreen({super.key, required this.onOpenMyGoats});

  final VoidCallback onOpenMyGoats;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'МОЇ КОЗИ',
        'subtitle': 'Кількість: 45',
        'icon': Icons.pets,
        'isNew': false,
        'isPremium': false,
      },
      {
        'title': 'ЖУРНАЛ ПАРУВАНЬ',
        'subtitle': '(NEW)',
        'icon': Icons.assignment,
        'isNew': true,
        'isPremium': false,
      },
      {
        'title': 'ВЕТЕРИНАРНИЙ КАЛЕНДАР',
        'subtitle': '',
        'icon': Icons.calendar_month,
        'isNew': false,
        'isPremium': true,
      },
      {
        'title': 'ЕКОНОМІКА',
        'subtitle': '(NEW)',
        'icon': Icons.attach_money,
        'isNew': true,
        'isPremium': true,
      },
      {
        'title': 'ЗВІТИ ТА СТАТИСТИКА',
        'subtitle': '',
        'icon': Icons.bar_chart,
        'isNew': false,
        'isPremium': true,
      },
      {
        'title': 'КАЛЬКУЛЯТОР РАЦІОНУ',
        'subtitle': '',
        'icon': Icons.calculate,
        'isNew': false,
        'isPremium': true,
      },
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menuItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              mainAxisExtent: 140,
            ),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              final isMyGoats = item['title'] == 'МОЇ КОЗИ';
              return _buildYardCard(
                title: item['title'],
                subtitle: item['subtitle'],
                icon: item['icon'],
                isNew: item['isNew'],
                isPremium: item['isPremium'],
                onTap: isMyGoats ? onOpenMyGoats : () {},
              );
            },
          ),
          const SizedBox(height: 14),
          _buildYardCard(
            title: 'КОРМОВИЙ СКЛАД',
            subtitle: '',
            icon: Icons.calculate,
            isNew: false,
            isPremium: true,
            isFullWidth: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildYardCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isNew,
    required bool isPremium,
    required VoidCallback onTap,
    bool isFullWidth = false,
  }) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: isFullWidth ? 120 : double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: AppColors.textGold, size: 32),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: isNew ? AppColors.textGold : AppColors.textMuted,
                          fontSize: 11,
                          fontWeight: isNew ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isPremium)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: AppColors.textGold,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star, size: 10, color: Colors.black),
            ),
          ),
      ],
    );
  }
}
