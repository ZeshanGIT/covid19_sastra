class PostModel {
  String title, uid, url, description;
  int mediaType;

  PostModel(this.uid, Map<String, dynamic> json) {
    title = json['t'];
    description = json['d'];
    url = json['u'];
    mediaType = json['mt'];
  }
}
