class Note {
  final int id;
  final String name;
  final String basicInfo;
  final String imageUrl;
  final String description;
  final int price;
  int amount;

  Note({
    required this.id,
    required this.name,
    required this.basicInfo,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.amount,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['ID'],
      name: json['Name'],
      basicInfo: json['BasicInfo'],
      imageUrl: json['ImageURL'],
      description: json['Description'],
      price: json['Price'],
      amount: json['Amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'BasicInfo': basicInfo,
      'ImageURL': imageUrl,
      'Description': description,
      'Price': price,
      'Amount': amount,
    };
  }
}
