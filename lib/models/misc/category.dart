class Category {
  String? id;
  String? description;
  String? key;
  String? title;
  String? displayOrder;

  Category({
    this.id,
    this.description,
    this.key,
    this.title,
    this.displayOrder,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    key = json['key'];
    title = json['title'];
    displayOrder = json['display_order'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['key'] = key;
    data['title'] = title;
    data['display_order'] = displayOrder;
    return data;
  }
}
