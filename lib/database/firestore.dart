import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';

/*

Database that stores post published in the app
The collection in Firebase is called 'Posts'

Each Post contain a message, email and timestamp

 */

class FirestoreDatabase {
  // current user
  User? user = FirebaseAuth.instance.currentUser;
  // get the collection of posts
  final CollectionReference posts = FirebaseFirestore.instance.collection(
    "Posts",
  );

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read posts
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("TimeStamp", descending: true)
        .snapshots();

    return postsStream;
  }
}
