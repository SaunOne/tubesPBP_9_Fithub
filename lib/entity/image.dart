class ImageUser {
  String Message;
  String Encoder;

  ImageUser({required this.Message, required this.Encoder});

  ImageUser.empty({this.Message = '',
    this.Encoder = ''});

  factory ImageUser.fromJson(Map<String, dynamic> json) {
    return ImageUser(
      Message: json['message'] ?? '',
      Encoder: json['ENCODER'] ?? '',
    );
  }

}