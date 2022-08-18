import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/services/database.dart';
import 'package:provider/provider.dart';

class TrackerList extends StatelessWidget {
  const TrackerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return const Center(child: Text("Tracker List"));

    // return StreamBuilder<List<BlogPost>>(
    //   stream: database.blogPostsStream(),
    //   builder: (context, snapshot) {
    //     return ListItemsBuilder<BlogPost>(
    //       snapshot: snapshot,
    //       itemBuilder: (context, blogPost) {
    //       }
    //   }
  }
}
