class Message{
  int? idUser;
  String? name;
  String? message;
  DateTime? created_at;
  Message({required this.idUser, required this.message, this.created_at, required this.name});

  Message.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    idUser =  json['id_user'];
    message = json['message'];
  }
}