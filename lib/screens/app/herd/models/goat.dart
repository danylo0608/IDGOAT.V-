enum GoatCategory { all, doe, buck, pregnant }

class GoatParent {
  const GoatParent({
    required this.name,
    required this.tagId,
    required this.farmName,
  });

  final String name;
  final String tagId;
  final String farmName;
}

class Goat {
  const Goat({
    required this.name,
    required this.tagId,
    required this.category,
    this.breed,
    this.darNumber,
    this.birthYear,
    this.birthWeightKg,
    this.litterSize,
    this.hornType,
    this.bloodline,
    this.statusLabel,
    this.countdownDays,
    this.mother,
    this.father,
    this.currentWeightKg,
    this.birthDate,
    this.electronicId,
    this.breeder,
    this.owner,
    this.reproductiveStatus,
    this.physiologicalStatus = const [],
    this.litterComposition,
    this.isDoe = true,
  });

  final String name;
  final String tagId;
  final GoatCategory category;
  final String? breed;
  final String? darNumber;
  final int? birthYear;
  final double? birthWeightKg;
  final int? litterSize;
  final String? hornType;
  final String? bloodline;
  final String? statusLabel;
  final int? countdownDays;
  final GoatParent? mother;
  final GoatParent? father;

  // New fields
  final double? currentWeightKg;
  final DateTime? birthDate;
  final String? electronicId;
  final String? breeder;
  final String? owner;
  final String? reproductiveStatus;
  final List<String> physiologicalStatus;
  final String? litterComposition;
  final bool isDoe;

  String get displayId {
    if (tagId.toLowerCase().startsWith('id-')) return tagId.toLowerCase();
    return tagId.toLowerCase().replaceFirst('ukr', 'id-');
  }

  String get defaultStatus {
    if (statusLabel != null) return statusLabel!;
    return switch (category) {
      GoatCategory.pregnant => '(запліднення)',
      GoatCategory.buck => '(козел)',
      _ => '(активна)',
    };
  }

  String get ageString {
    if (birthDate == null) {
      if (birthYear != null) {
        final currentYear = DateTime.now().year;
        final years = currentYear - birthYear!;
        return '$years р.';
      }
      return 'Невідомо';
    }

    final now = DateTime.now();
    int years = now.year - birthDate!.year;
    int months = now.month - birthDate!.month;

    if (months < 0) {
      years--;
      months += 12;
    }

    if (years > 0) {
      return '$years р. $months міс.';
    } else {
      return '$months міс.';
    }
  }
}
