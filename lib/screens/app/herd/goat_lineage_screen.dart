import 'package:flutter/material.dart';
import 'package:idgoat/screens/app/herd/models/goat.dart';
import 'package:idgoat/theme/colors.dart';

class GoatLineageScreen extends StatelessWidget {
  const GoatLineageScreen({super.key, required this.goat});

  final Goat goat;

  @override
  Widget build(BuildContext context) {
    final fatherName = goat.father?.name ?? 'Royal Oak';
    final fatherId = goat.father?.tagId ?? 'ID-092';
    final motherName = goat.mother?.name ?? 'Luna II';
    final motherId = goat.mother?.tagId ?? 'ID-105';
    final breedLabel = (goat.breed ?? 'SAANEN').toUpperCase();
    final lineageLabel = goat.bloodline != null
        ? goat.bloodline!.toUpperCase()
        : 'ELITE LINEAGE';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            '${goat.name} (${goat.displayId})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$lineageLabel  •  $breedLabel BREED',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textGold,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          _buildLineageTree(
            mainName: goat.name,
            mainId: '${goat.displayId.toUpperCase()}  •  FEMALE',
            sireName: fatherName,
            sireId: '${fatherId.toUpperCase()}  •  SIRE',
            damName: motherName,
            damId: '${motherId.toUpperCase()}  •  DAM',
          ),
          const SizedBox(height: 32),
          _buildLineageStats(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLineageTree({
    required String mainName,
    required String mainId,
    required String sireName,
    required String sireId,
    required String damName,
    required String damId,
  }) {
    const lineColor = Colors.white24;

    return Column(
      children: [
        _buildGoatAvatar(
          radius: 54,
          name: mainName,
          id: mainId,
          isMain: true,
        ),
        Container(
          height: 24,
          width: 1.5,
          color: AppColors.textGold.withValues(alpha: 0.5),
        ),
        Row(
          children: [
            Expanded(child: Container(height: 1.5, color: Colors.transparent)),
            Expanded(
              child: Container(
                height: 1.5,
                color: AppColors.textGold.withValues(alpha: 0.5),
              ),
            ),
            Expanded(
              child: Container(
                height: 1.5,
                color: AppColors.textGold.withValues(alpha: 0.5),
              ),
            ),
            Expanded(child: Container(height: 1.5, color: Colors.transparent)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 16,
              width: 1.5,
              color: AppColors.textGold.withValues(alpha: 0.5),
            ),
            Container(
              height: 16,
              width: 1.5,
              color: AppColors.textGold.withValues(alpha: 0.5),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildGoatAvatar(
                radius: 36,
                name: sireName,
                id: sireId,
              ),
            ),
            Expanded(
              child: _buildGoatAvatar(
                radius: 36,
                name: damName,
                id: damId,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(height: 20, width: 1.5, color: lineColor),
            Container(height: 20, width: 1.5, color: lineColor),
          ],
        ),
        Row(
          children: [
            Expanded(child: Container(height: 1.5, color: Colors.transparent)),
            Container(height: 1.5, width: 75, color: lineColor),
            Expanded(child: Container(height: 1.5, color: Colors.transparent)),
            Container(height: 1.5, width: 75, color: lineColor),
            Expanded(child: Container(height: 1.5, color: Colors.transparent)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 12, width: 1.5, color: lineColor),
                  Container(height: 12, width: 1.5, color: lineColor),
                ],
              ),
            ),
            SizedBox(
              width: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 12, width: 1.5, color: lineColor),
                  Container(height: 12, width: 1.5, color: lineColor),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildMinifiedAvatar('Titan', 'P-SIRE')),
            Expanded(child: _buildMinifiedAvatar('Bella', 'P-DAM')),
            Expanded(child: _buildMinifiedAvatar('Apollo', 'M-SIRE')),
            Expanded(child: _buildMinifiedAvatar('Gaia', 'M-DAM')),
          ],
        ),
      ],
    );
  }

  Widget _buildGoatAvatar({
    required double radius,
    required String name,
    required String id,
    bool isMain = false,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            color: isMain ? AppColors.textGold : Colors.white24,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.cardBackground,
            child: Icon(
              Icons.pets,
              color: isMain ? AppColors.textGold : Colors.white60,
              size: radius * 0.8,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          id,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMinifiedAvatar(String name, String role) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(1.5),
          decoration: const BoxDecoration(
            color: Colors.white12,
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.cardBackground,
            child: Icon(Icons.pets, color: Colors.white38, size: 20),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          role,
          style: const TextStyle(
            color: Colors.white30,
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLineageStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        children: [
          _buildStatRow('LINEAGE PURITY', '100% SAANEN'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: Divider(color: Colors.white10, height: 1),
          ),
          _buildStatRow('INBREEDING COEFF.', '0.42%'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: Divider(color: Colors.white10, height: 1),
          ),
          _buildStatRow('ELITE ANCESTORS', '', showStars: true),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    String value, {
    bool showStars = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textGold,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        if (showStars)
          const Row(
            children: [
              Icon(Icons.star, color: AppColors.textGold, size: 16),
              SizedBox(width: 4),
              Icon(Icons.star, color: AppColors.textGold, size: 16),
              SizedBox(width: 4),
              Icon(Icons.star, color: AppColors.textGold, size: 16),
            ],
          )
        else
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
