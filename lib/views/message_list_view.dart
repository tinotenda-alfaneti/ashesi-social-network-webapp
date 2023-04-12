import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:ashesi_social_network/services/message_structure.dart';
import 'package:flutter/material.dart';

typedef MessageCallBack = void Function(Message note);

class MessagesListView extends StatefulWidget {
  final Iterable<Message> messages;
  final MessageCallBack onTap;
  final MessageCallBack onDeleteMessage;

  const MessagesListView({
    super.key,
    required this.messages,
    required this.onTap,
    required this.onDeleteMessage,
  });

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final message = widget.messages.elementAt(index);
        return ListTile(
          onTap: () {
            widget.onTap(message);
          },
          title: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(8.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                color: Theme.of(context).cardColor,
                elevation: 0.8,
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  margin: const EdgeInsets.only(right: 16, left: 16),
                  child: Column(
                    // padding: const EdgeInsets.only(top: 20),
                    // shrinkWrap: true,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        padding: const EdgeInsets.only(top: 13),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8.0),
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "images/default_user.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: message.senderName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).highlightColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              message.dateSend,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          message.messageBody,
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).disabledColor),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
