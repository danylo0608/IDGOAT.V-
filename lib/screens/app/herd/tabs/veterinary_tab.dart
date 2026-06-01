import 'package:flutter/material.dart';
import 'package:idgoat/theme/colors.dart';

class VeterinaryTab extends StatefulWidget {
  const VeterinaryTab({super.key});

  @override
  State<VeterinaryTab> createState() => _VeterinaryTabState();
}

class _VeterinaryTabState extends State<VeterinaryTab> {
  String _activeSection = 'MEDICAL'; // MEDICAL, DISEASE

  final medicalHistory = <Map<String, dynamic>>[
    {
      'type': 'КВТ',
      'day': '14',
      'title': 'Антибіотик А-200',
      'subtitle': 'Профілактика інфекцій',
      'dose': '5.0 ік',
    },
    {
      'type': 'ИОТ',
      'day': '28',
      'title': 'Вітаміни Complex B',
      'subtitle': 'Плановий огляд',
      'dose': '2.5 ік',
    },
    {
      'type': 'ИОТ',
      'day': '10',
      'title': 'Дегельмінтизація',
      'subtitle': 'Регулярна чистка',
      'dose': '10.0 ік',
    },
  ];

  final diseaseHistory = <Map<String, dynamic>>[
    {
      'date': '20.04.2024',
      'title': 'Мастит',
      'status': 'Вилікувано',
      'symptoms': 'Набряк вимені, підвищена температура',
      'severity': 'Середня',
    },
    {
      'date': '05.02.2024',
      'title': 'Травма копита',
      'status': 'Вилікувано',
      'symptoms': 'Кульгавість на ліву передню',
      'severity': 'Легка',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMilkBanBanner(),
              const SizedBox(height: 24),
              _buildSectionSwitcher(),
              const SizedBox(height: 24),
              if (_activeSection == 'MEDICAL') _buildMedicalHistory() else _buildDiseaseHistory(),
              const SizedBox(height: 80),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: _buildAddButton(),
        ),
      ],
    );
  }

  Widget _buildMilkBanBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF8B0000),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.block, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Збір молока заборонено',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Залишилось: 3 дні 12 годин',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _buildSectionButton('MEDICAL', 'Медична історія'),
          _buildSectionButton('DISEASE', 'Історія захворювань'),
        ],
      ),
    );
  }

  Widget _buildSectionButton(String id, String label) {
    final isSelected = _activeSection == id;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeSection = id),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Медичні записи',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildViewAllButton(),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: medicalHistory.length,
          itemBuilder: (context, index) {
            final item = medicalHistory[index];
            return _buildMedicalItem(item);
          },
        ),
      ],
    );
  }

  Widget _buildDiseaseHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Журнал захворювань',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildViewAllButton(),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: diseaseHistory.length,
          itemBuilder: (context, index) {
            final item = diseaseHistory[index];
            return _buildDiseaseItem(item);
          },
        ),
      ],
    );
  }

  Widget _buildMedicalItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.02)),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item['type'], style: const TextStyle(color: AppColors.textMuted, fontSize: 9, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(item['day'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(item['subtitle'], style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.textGold.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.textGold.withOpacity(0.2)),
              ),
              child: Text(item['dose'], style: const TextStyle(color: AppColors.textGold, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiseaseItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.02)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item['status'],
                    style: const TextStyle(color: Color(0xFF4CAF50), fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(item['symptoms'], style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: AppColors.textMuted, size: 14),
                    const SizedBox(width: 6),
                    Text(item['date'], style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.textGold, size: 14),
                    const SizedBox(width: 6),
                    Text('Складність: ${item['severity']}', style: const TextStyle(color: AppColors.textGold, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewAllButton() {
    return TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      icon: const Text(
        'ВСІ ЗАПИСИ',
        style: TextStyle(color: AppColors.textGold, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
      label: const Icon(Icons.open_in_new, color: AppColors.textGold, size: 14),
    );
  }

  Widget _buildAddButton() {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: AppColors.textGold,
      foregroundColor: Colors.black,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      icon: const Icon(Icons.add, size: 24),
      label: Text(
        _activeSection == 'MEDICAL' ? 'ДОДАТИ ПРЕПАРАТ' : 'НОВЕ ЗАХВОРЮВАННЯ',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }
}
