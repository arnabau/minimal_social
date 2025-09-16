import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social/components/my_drawer.dart';
import 'package:minimal_social/components/my_post_button.dart';
import 'package:minimal_social/components/my_textfield.dart';
import 'package:minimal_social/database/firestore.dart';
// import 'package:minimal_social/helpers/helpers_functions.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirestoreDatabase database = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("W A L L"),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        foregroundColor: Colors.white60,
        elevation: 0,
        //actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                    controller: newPostController,
                    obscureText: false,
                    hintText: "Say something...",
                  ),
                ),
                MyPostButton(onTap: postMessage),
              ],
            ),
          ),

          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final posts = snapshot.data!.docs;

              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No Posts..."),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(message),
                          subtitle: Text(
                            userEmail,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
