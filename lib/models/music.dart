class Music {
  late int id;
  late String title;
  late String pdf;
  late String audio;
  late DateTime? createdAt;
  late DateTime? updatedAt;
  late int favoris;
  late int typeId;
  late String typeLabel;
  late int numero;
  late String lyrics;

  Music(
      {required this.id,
      required this.title,
      required this.pdf,
      required this.audio,
      required this.favoris,
      this.createdAt,
      this.updatedAt,
      required this.typeId,
      required this.typeLabel,
      required this.numero,
      required this.lyrics});

  Music.fromMap(Map<String, Object?> map) {
    id = map['id'] as int;
    title = map['title'] != null ? map['title'] as String : '';
    pdf = map['pdf'] != null ? map['pdf'] as String : '';
    audio = map['audio'] != null ? map['audio'] as String : '';
    lyrics = map['lyrics'] != null ? map['lyrics'] as String : '';
    createdAt = map['created_at'] != null
        ? DateTime.parse(map['created_at'] as String)
        : null;
    updatedAt = map['updated_at'] != null
        ? DateTime.parse(map['updated_at'] as String)
        : null;
    favoris = map['favoris'] as int;
    typeId = map['type'] != null ? map['type'] as int : 0;
    typeLabel = map['label'] != null ? map['label'] as String : '';
    numero = map['numero'] != null ? map['numero'] as int : 0;
  }
}

List<Music> fakeMusics = List.generate(
  400,
  (i) => Music(
    id: i,
    title: 'Music $i',
    pdf: 'Parole $i',
    audio: 'Audio $i',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    favoris: 0,
    typeId: 0,
    typeLabel: '',
    numero: i,
    lyrics: '',
  ),
);
