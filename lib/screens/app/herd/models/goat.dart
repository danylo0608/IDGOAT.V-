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
}
