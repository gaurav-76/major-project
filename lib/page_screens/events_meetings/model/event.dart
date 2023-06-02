import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title;
  final String? description;
  final String meetingLink;
  final DateTime date;
  final String eventId;
  final String uid;
  final String name;
  final String startTime;
  final String endTime;
  Event(
      {required this.title,
      this.description,
      required this.meetingLink,
      required this.date,
      required this.eventId,
      required this.uid,
      required this.name,
      required this.startTime,
      required this.endTime
      });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
        date: data['date'].toDate(),
        title: data['title'],
        description: data['description'],
        meetingLink: data['meetingLink'],
        eventId: snapshot.id,
        uid: data['uid'],
        name: data['uploadedBy'],
        startTime: data['startTime'],
        endTime: data['endTime']);
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "title": title,
      "description": description,
      "meetingLink": meetingLink,
      "uid": uid,
      "name": name,
      "eventId": eventId,
      "startTime" : startTime,
      "endTime" : endTime
    };
  }
}
