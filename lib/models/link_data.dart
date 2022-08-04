class LinkData {
  String? title;
  String? description;
  String? image;
  String? url;
  String? domain;

  LinkData({this.title, this.description, this.image, this.url, this.domain});

  LinkData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    url = json['url'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['url'] = url;
    data['domain'] = domain;
    return data;
  }
}
