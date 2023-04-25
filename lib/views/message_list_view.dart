import 'package:ashesi_social_network/utils/custom_styles.dart';
import 'package:ashesi_social_network/services/api_controller.dart';
import 'package:ashesi_social_network/services/auth_service/firebase_service.dart';
import 'package:ashesi_social_network/services/message_structure.dart';
import 'package:flutter/material.dart';

typedef MessageCallBack = void Function(Message note);

class MessagesListView extends StatefulWidget {
  final List<Message> messages;
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
        final message = widget.messages[index];
        MainAxisAlignment side;
        if (message.senderEmail == FirebaseAuthService().currentUser!.email) {
          side = MainAxisAlignment.end;
        } else {
          side = MainAxisAlignment.start;
        }
        return Row(
          mainAxisAlignment: side,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ListTile(
                onTap: () {
                  widget.onTap(message);
                },
                title: Card(
                  margin: const EdgeInsets.all(8.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  color: Colors.white,
                  elevation: 0.8,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    margin: const EdgeInsets.only(right: 16, left: 16),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.only(top: 13),
                          child: SingleChildScrollView(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 8.0),
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                              //TODO: Load profile image
                                              image: Image.asset(
                                                      'assets/images/default_user1.png')
                                                  .image, //TODO: Load profile image
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: message.senderName,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (message.senderEmail ==
                                    FirebaseAuthService().currentUser!.email) {
                                  await ApiController()
                                      .deleteMessage(msgId: message.documentId);
                                }
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            const Spacer(),
                            Container(
                              child: Text(
                                message.dateSend,
                                style: const TextStyle(
                                    fontSize: 10, color: themeColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
