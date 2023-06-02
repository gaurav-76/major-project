import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_gram_app/model/notices.dart';
import 'package:college_gram_app/model/posts.dart';
import 'package:college_gram_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //uploadPost
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String name,
    String profImage,
  ) async {
    String res = 'some error occurred';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Posts post = Posts(
        description: description,
        uid: uid,
        name: name,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );

      _firestore.collection("posts").doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // upload Notice
  Future<String> uploadNotice(
    File file,
    String title,
    String description,
    String uid,
    String uploadedBy,
    //String fileurl,
  ) async {
    String res = 'some error occurred';
    try {
      // ignore: unnecessary_null_comparison
      if (file == null) {
        return res = 'Please select file';
      } else if (title.isNotEmpty) {
        String noticeUrl =
            await StorageMethods().uploadNoticeToStorage('notices', file, true);

        String noticeId = const Uuid().v1();

        Notices notice = Notices(
          title: title,
          description: description,
          noticeUrl: noticeUrl,
          uid: uid,
          noticeId: noticeId,
          datePublished: DateTime.now(),
          name: uploadedBy,
        );

        _firestore.collection("notices").doc(noticeId).set(notice.toJson());
        res = 'success';
      } else {
        return res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }


  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "some error occurred";
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'postId': postId,
          'commentText': text,
          'uid': uid,
          'name': name,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = "success";
      } else {
        res = "Please write something first...";
      }
    } catch (e) {
      print(e.toString());
    }

    return res;
  }

  //Deleting Post
  Future<String> deletePost(String postId) async {
    String res = 'some error occurred';
    try {
      await _firestore.collection("posts").doc(postId).delete();
      res = 'success';
    } catch (e) {
      print(e.toString());
    }

    return res;
  }
}
