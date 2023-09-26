

import 'package:flutter/cupertino.dart';

import '../../../../../resources/resources.dart';
import '../model/base_model.dart';

class ChatVM extends ChangeNotifier {

  List<ChatModel>chatList = [

    ChatModel('Sami', 'Your Order Just Arrived!',R.images.user, '10:00',"Online",),
    ChatModel('Hassan', 'Your Order Just Arrived!',R.images.user, '11:00','Offline', ),
    ChatModel('Aqib', 'Your Order Just Arrived!',R.images.user, '12:00','Online', ),

  ];

  List<ChatMessageModel> messagesList = [
    // ChatMessageModel( "Hello, Will", false),
    // ChatMessageModel( "How have you been?", false),
    // ChatMessageModel( "Hey Kriss, I am doing fine dude. wbu?",true),
    // ChatMessageModel( "Is there any thing wrong?", true),
    // ChatMessageModel( "ehhhh, doing OK.", false),


  ];

  // void sendMessage(message){
  //   messagesList.add(ChatMessageModel(message, true));
  //   notifyListeners();
  // }

  void update(){
    notifyListeners();
  }

  int pageIndex = 1;
  void pageIncrement(){
    pageIndex++;
    notifyListeners();
  }








}