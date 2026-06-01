import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:idgoat/screens/app/herd/models/goat.dart';
import 'package:idgoat/theme/colors.dart';

class AdministrationTab extends StatelessWidget {
  const AdministrationTab({super.key, required this.goat});

  final Goat goat;

  static const _textSoftWhite = Color(0xFFBCBCBC);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralInfo(),
          const SizedBox(height: 24),
          _buildOwnersBlock(),
          const SizedBox(height: 24),
          _buildGalleryBlock(),
          const SizedBox(height: 24),
          _buildTransactionHistory(),
          const SizedBox(height: 24),
          _buildDocumentsBlock(),
          const SizedBox(height: 32),
          _buildArchiveButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildGeneralInfo() {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: ExpansionTile(
          collapsedIconColor: AppColors.textGold,
          iconColor: AppColors.textGold,
          title: const Text(
            'ЗАГАЛЬНА ІНФОРМАЦІЯ',
            style: TextStyle(
              color: AppColors.textGold,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  _buildInfoRow('Кличка', goat.name),
                  _buildInfoRow('Системний ID', goat.tagId),
                  _buildInfoRow('Заводчик', goat.breeder ?? '—'),
                  _buildInfoRow('Власник', goat.owner ?? '—'),
                  _buildInfoRow('Стать', goat.isDoe ? 'Коза' : 'Козел'),
                  _buildInfoRow('Репродуктивний статус', goat.reproductiveStatus ?? '—'),
                  _buildInfoRow('Порода та Кровність', '${goat.breed ?? '—'} (${goat.bloodline ?? '—'})'),
                  if (goat.physiologicalStatus.isNotEmpty)
                    _buildInfoRow('Фізіологічний статус', goat.physiologicalStatus.join(', ')),
                  _buildInfoRow('Номер ДАР', goat.darNumber ?? '—'),
                  _buildInfoRow('Електронний ідентифікатор', goat.electronicId ?? '—'),
                  _buildInfoRow('Дата народження', goat.birthDate != null ? DateFormat('dd.MM.yyyy').format(goat.birthDate!) : '—'),
                  _buildInfoRow('Поточна вага', goat.currentWeightKg != null ? '${goat.currentWeightKg} кг' : '—'),
                  _buildInfoRow('Кількість у окоті', goat.litterSize?.toString() ?? '—'),
                  _buildInfoRow('Склад окоту', goat.litterComposition ?? '—'),
                  _buildInfoRow('Вага при народженні', goat.birthWeightKg != null ? '${goat.birthWeightKg} кг' : '—'),
                  _buildInfoRow('Тип рогів', goat.hornType ?? '—'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnersBlock() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ЗАВОДЧИК',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 10,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            goat.breeder ?? '—',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'ПОТОЧНИЙ ВЛАСНИК',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 10,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            goat.owner ?? '—',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryBlock() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Фотогалерея',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Text(
                    'Переглянути всі',
                    style: TextStyle(color: AppColors.textGold, fontSize: 12),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textGold,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: const Center(
                  child: Icon(Icons.image, color: Colors.white24, size: 36),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionHistory() {
    final history = <Map<String, String>>[
      {
        'date': '15.03.2024',
        'desc': 'Приватний продаж: Ферма "Золоте Копито"',
        'color': 'gold',
      },
      {'date': '10.01.2024', 'desc': 'Реєстрація народження', 'color': 'mint'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Історія транзакцій',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Text(
                    'Переглянути всі',
                    style: TextStyle(color: AppColors.textGold, fontSize: 12),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textGold,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];
            final isGold = item['color'] == 'gold';

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: isGold
                            ? AppColors.textGold
                            : const Color(0xFFB4C8C1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (index != history.length - 1)
                      Container(width: 1.5, height: 50, color: Colors.white12),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['date']!,
                        style: TextStyle(
                          color: isGold ? AppColors.textGold : Colors.white54,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['desc']!,
                        style: const TextStyle(
                          color: _textSoftWhite,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildDocumentsBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Документи',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDocButton('Сертифікат ДНК', Icons.verified_user),
            ),
            const SizedBox(width: 14),
            Expanded(child: _buildDocButton('Племсвідоцтво', Icons.assignment)),
          ],
        ),
        const SizedBox(height: 14),
        _buildDocButton('Лабораторні аналізи', Icons.biotech_outlined),
      ],
    );
  }

  Widget _buildDocButton(String title, IconData icon) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.textGold, size: 28),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArchiveButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B0000),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.cancel_outlined, size: 20),
        label: const Text(
          'Архів / Смерть',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
