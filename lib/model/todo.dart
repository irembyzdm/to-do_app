class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList(){
    return [
      ToDo(id:'01',todoText: 'Sabah Egzersizleri', isDone: true),
      ToDo(id:'02',todoText: 'Market Alışverişi', isDone: true),
      ToDo(id:'03',todoText: 'Maillerini Kontrol Et'),
      ToDo(id:'04',todoText: 'Ekiple Toplantı'),
      ToDo(id:'05',todoText: 'Mobil Uygulamalara 2 saat çalış'),
      ToDo(id:'06',todoText: 'Esra ile Akşam Yemeği'),
    ];
  }
}