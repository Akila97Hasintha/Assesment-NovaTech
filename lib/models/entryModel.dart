class EntryModel {
    final String api;
  final String description;
  final String auth;

  final String cors;
  final String link;
  final String category;

  EntryModel({
    required this.api,
    required this.description,
    required this.auth,
    
    required this.cors,
    required this.link,
    required this.category,
  });

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
       api: json['API'] ?? '',
      description: json['Description'] ?? '',
      auth: json['Auth'] ?? '',
      cors: json['Cors'] ?? '',
      link: json['Link'] ?? '',
      category: json['Category'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'API': api,
      'Description': description,
      'Auth': auth,
      'Cors': cors,
      'Link': link,
      'Category': category,
    };
  }
}
