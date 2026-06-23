import 'package:flutter/material.dart';
import 'package:idgoat/screens/app/herd/models/goat.dart';
import 'package:idgoat/theme/colors.dart';

class GoatDetailScreen extends StatelessWidget {
  const GoatDetailScreen({
    super.key,
    required this.goat,
    required this.onOpenLineage,
    required this.onOpenProfile,
  });

  final Goat goat;
  final VoidCallback onOpenLineage;
  final VoidCallback onOpenProfile;

  static const _infoGreen = Color(0xFF1C352D);

  @override
  Widget build(BuildContext context) {
    final mother = goat.mother ??
        const GoatParent(
          name: 'Мілка',
          tagId: 'id-002',
          farmName: 'Ферма Енеїда',
        );
    final father = goat.father ??
        const GoatParent(
          name: 'Барон',
          tagId: 'id-010',
          farmName: 'Gospodarstvo Petra',
        );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 14),
          _buildInfoTable(),
          const SizedBox(height: 20),
          const Text(
            'ПОХОДЖЕННЯ (РОДОВІД)',
            style: TextStyle(
              color: AppColors.textGold,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          _buildLineageCard(mother, father),
          const SizedBox(height: 20),
          _buildActionGrid(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: AppColors.textGold,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 44,
              backgroundColor: const Color(0xFF1A2321),
              child: Icon(
                Icons.pets,
                color: AppColors.textGold.withOpacity(0.9),
                size: 44,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goat.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  goat.displayId,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                const SizedBox(height: 8),
                Text(
                  'Статус: ${goat.defaultStatus}',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                if (goat.countdownDays != null ||
                    goat.category == GoatCategory.pregnant) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Відлік: ${goat.countdownDays ?? 19} днів',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTable() {
    final rows = <(String, String)>[
      ('Порода', goat.breed ?? 'Англо-нубійська'),
      ('Кровність', goat.bloodline ?? '96.5% - American F5+'),
      // ('ID', goat.displayId),
      ('Номер ДАР', goat.darNumber ?? '—'),
      ('Рік народження', '${goat.birthYear ?? 2021}'),
      ('Поточна вага', goat.currentWeightKg != null ? '${goat.currentWeightKg} кг' : '—'),
      // ('Вага при нар.', '${goat.birthWeightKg ?? 3.8} кг'),
      // ('Кількість у окоті', '${goat.litterSize ?? 2}'),
      // ('Тип рогів', goat.hornType ?? 'Рогата'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: _infoGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            _InfoRow(label: rows[i].$1, value: rows[i].$2),
            if (i < rows.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildLineageCard(GoatParent mother, GoatParent father) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(child: _ParentColumn(label: 'МАТИ', parent: mother)),
          const SizedBox(width: 12),
          Expanded(child: _ParentColumn(label: 'БАТЬКО', parent: father)),
        ],
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                label: 'ДЕТАЛЬНІШЕ',
                iconAsset: 'assets/icon/details.png',
                iconColor: AppColors.textGold,
                backgroundColor: AppColors.cardBackground,
                textColor: Colors.white,
                onTap: onOpenProfile,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionButton(
                label: 'ДОДАТИ НОТАТКУ',
                iconAsset: 'assets/icon/notes.png',
                iconColor: AppColors.textGold,
                backgroundColor: AppColors.cardBackground,
                textColor: Colors.white,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                label: 'ЗАФІКСУВАТИ\nОХОТУ',
                iconAsset: 'assets/icon/record_hunting.png',
                iconColor: Colors.white,
                backgroundColor: _infoGreen,
                textColor: Colors.white,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionButton(
                label: 'ЗАФІКСУВАТИ\nПОКРИТТЯ',
                iconAsset: 'assets/icon/record_mating.png',
                iconColor: const Color(0xFF1C2D27),
                backgroundColor: AppColors.textGold,
                textColor: const Color(0xFF1C2D27),
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionButton(
                label: 'ПРОДАТИ',
                iconAsset: 'assets/icon/record_sale.png',
                iconColor: Colors.white,
                backgroundColor: AppColors.cardBackground,
                textColor: Colors.white,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionButton(
                label: 'ГЕНЕТИЧНЕ\nДЕРЕВО',
                iconAsset: 'assets/icon/pedigree.png',
                iconColor: Colors.white,
                backgroundColor: AppColors.cardBackground,
                textColor: Colors.white,
                onTap: onOpenLineage,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _ParentColumn extends StatelessWidget {
  const _ParentColumn({required this.label, required this.parent});

  final String label;
  final GoatParent parent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: AppColors.textGold,
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFF1A2321),
            child: Icon(Icons.pets, color: AppColors.textGold, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${parent.name} (${parent.tagId})',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textGold,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          parent.farmName,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    this.icon,
    this.iconAsset,
    required this.iconColor,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final IconData? icon;
  final String? iconAsset;
  final Color iconColor;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: iconAsset != null ? AppColors.textGold : Colors.transparent,
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 88,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconAsset != null
                    ? Image.asset(
                        iconAsset!,
                        width: 40,
                        height: 40,
                      )
                    : Icon(icon, color: iconColor, size: 40),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    ),);
  }
}
