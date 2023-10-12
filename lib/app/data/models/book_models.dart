class BookModels {
  final String? id;
  final String? bookName;
  final String? bookAuthor;
  final String? publisher;
  final DateTime? publishedDate;

  BookModels(
      {this.id,
      this.bookName,
      this.bookAuthor,
      this.publisher,
      this.publishedDate});

  factory BookModels.fromJson(Map<String, dynamic> json) {
    return BookModels(
      id: json['id'],
      bookName: json['name'],
      bookAuthor: json['name_author'],
      publisher: json['name_publish'],
      publishedDate: json['release_years'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': bookName,
        'name_author': bookAuthor,
        'name_publish': publisher,
        'release_years': publishedDate,
      };
}
