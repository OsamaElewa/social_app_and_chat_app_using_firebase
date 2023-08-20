class MessageModel{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? imageUrl;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
    required this.imageUrl
  });

  MessageModel.fromJson(Map<String,dynamic> json){
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    imageUrl = json['imageUrl'];
  }

  Map<String,dynamic> toMap(){
    return {
      'senderId' : senderId,
      'receiverId' : receiverId,
      'dateTime' : dateTime,
      'text' : text,
      'imageUrl' : imageUrl
    };
  }
}