import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_gram_app/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/event.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final Function() onDelete;
  final Function()? onTap;
  const EventItem({
    Key? key,
    required this.event,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        child: Container(
          child: Card(
            //color: Color.fromARGB(255, 217, 217, 217),
            color: Colors.white,
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            event.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: userProvider.getUser.uid == event.uid
                              ? IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 19,
                                  ),
                                  onPressed: onDelete,
                                )
                              : Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    // Text(DateFormat.yMMMd().format(
                    //   widget.snap['datePublished'].toDate(),
                    // )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                CupertinoIcons.clock_fill,
                                size: 19,
                                color: Colors.grey[800],
                              ),
                            ),
                            TextSpan(text: '  '),
                            TextSpan(
                                text: event.startTime,
                                style: TextStyle(color: Colors.grey[800])),
                            TextSpan(text: ' - '),
                            TextSpan(
                                text: event.endTime,
                                style: TextStyle(color: Colors.grey[800])),
                          ],
                        ),
                      ),
                    ),

                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.calendar_month_rounded,
                              size: 19,
                              color: Colors.grey[800],
                            ),
                          ),
                          TextSpan(text: '  '),
                          TextSpan(
                              text: DateFormat("EEEE, dd MMMM, yyyy")
                                  .format(event.date),
                              style: TextStyle(color: Colors.grey[800])),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
  );
  }
}
