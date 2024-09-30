class DiaryEntity {
  final String id;
  final String entryTitle;
  final String entryContent;
  final String date;

  const DiaryEntity({
    required this.id,
    required this.entryTitle,
    required this.entryContent,
    required this.date,
  });

  DiaryEntity copyWith({
    String? id,
    String? entryTitle,
    String? entryContent,
    String? date,
  }) {
    return DiaryEntity(
      id: id ?? this.id,
      entryTitle: entryTitle ?? this.entryTitle,
      entryContent: entryContent ?? this.entryContent,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return '''DiaryEntity{
    id: $id, 
    entryTitle: $entryTitle, 
    entryContent: $entryContent, 
    date: $date
    }''';
  }
}