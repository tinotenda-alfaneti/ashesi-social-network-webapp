import 'dart:async';
import 'package:ashesi_social_network/services/message_structure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDbService {
  final messages = FirebaseFirestore.instance.collection('messages');

  // Create a stream between messages collection and this web app, to get real time update
  Stream<Iterable<Message>> allMessages() {
    return messages
        .snapshots()
        .map((event) => event.docs.map((doc) => Message.fromSnapshot(doc)));
  }

  //create a singleton for the database to make sure the data is the same throughout
  static final FirebaseDbService _shared = FirebaseDbService._sharedInstance();
  FirebaseDbService._sharedInstance();
  factory FirebaseDbService() => _shared;
}
