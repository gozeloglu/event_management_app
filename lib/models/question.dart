class Question {
  const Question({
    this.id,
    this.askedQuestion,
    this.isAnswered,
  });

  final int id;
  final String askedQuestion;
  final int isAnswered;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json["id"] as int,
      askedQuestion: json["askedQuestion"] as String,
      isAnswered: json["isAnswered"] as int,
    );
  }
}
