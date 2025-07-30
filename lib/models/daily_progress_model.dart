class DailyProgress {
  final int completedTasks;
  final bool rewarded;

  DailyProgress({required this.completedTasks, required this.rewarded});

  Map<String, dynamic> toMap() => {
    'completedTasks': completedTasks,
    'rewarded': rewarded,
  };

  factory DailyProgress.fromMap(Map<String, dynamic> map) {
    return DailyProgress(
      completedTasks: map['completedTasks'] ?? 0,
      rewarded: map['rewarded'] ?? false,
    );
  }
}
