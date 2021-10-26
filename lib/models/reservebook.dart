class ReserveBook {
  String id;
  String reserved_book;
  ReserveBook({
    required this.id,
    required this.reserved_book,
  });
  factory ReserveBook.fromJson(Map<String, dynamic> map) {
    return ReserveBook(
        id: map['id'].toString(), reserved_book: map['reserved_book']);
  }
}
