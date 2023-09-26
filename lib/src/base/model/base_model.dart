


class ChatModel {

  late String name;
  late String notification;
  late String time;
  late String img;
  late String status;

  ChatModel(this.name,this.notification,this.img,this.time,this.status,);


}



class ChatMessageModel {

  final String senderId;
  final String receiverId;
  final String messageContent;
  final String sentTime;

  ChatMessageModel(
      {required this.senderId, required this.receiverId, required this.messageContent, required this.sentTime});

}