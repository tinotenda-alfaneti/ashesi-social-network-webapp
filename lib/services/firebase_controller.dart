import 'package:ashesi_social_network/services/message_structure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDbService {
  final messages = FirebaseFirestore.instance.collection('messages');
  final users = FirebaseFirestore.instance.collection('users');

  Stream<Iterable<Message>> allMessages() => messages
      .snapshots()
      .map((event) => event.docs.map((doc) => Message.fromSnapshot(doc)));

  static final FirebaseDbService _shared = FirebaseDbService._sharedInstance();
  FirebaseDbService._sharedInstance();
  factory FirebaseDbService() => _shared;
}
