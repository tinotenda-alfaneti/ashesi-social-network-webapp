import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Message {
  final String documentId;
  final String dateSend;
  final String messageBody;
  final String senderName;
  final String senderEmail;

  const Message({
    required this.documentId,
    required this.dateSend,
    required this.senderName,
    required this.messageBody,
    required this.senderEmail,
  });

  Message.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        dateSend = snapshot.data()['date-send'],
        senderName = snapshot.data()['sender-name'] as String,
        messageBody = snapshot.data()['message-body'] as String,
        senderEmail = snapshot.data()['sender-email'];
}
