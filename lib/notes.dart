class Note {
  final String name;
  final String basic_info;
  final String imageUrl;
  final String description;
  final int price;
  int amount;

  Note({
    required this.name,
    required this.basic_info,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.amount,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      name: json['Name'],
      basic_info: json['BasicInfo'],
      imageUrl: json['ImageURL'],
      description: json['Description'],
      price: json['Price'],
      amount: json['Amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'BasicInfo': basic_info,
      'ImageURL': imageUrl,
      'Description': description,
      'Price': price,
      'Amount': amount,
    };
  }
}
