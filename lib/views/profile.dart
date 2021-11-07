import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_op_gg/api_endpoints/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

var isLoading = true;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String profileName = "";
  String profilePicture = "";
  String profileBanner = "";
  String profileDescription = "";
  String subsNumber = "";
  String timeInDaySinceCreation = "";
  String dateOfCreation = "";
  String karmaNumber = "";
  String karmaPostNumber = "";
  String karmaCommentNumber = "";
  String karmaAwarderNumber = "";
  String karmaAwardeeNumber = "";
  List commentsList = [];
  List posts = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    APIProfile apiProfile = APIProfile();
    // await apiProfile.fetch();
    setState(
      () {
        isLoading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xff202020),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: isLoading
              ? [
                  const CircularProgressIndicator(),
                ]
              : [
                  const Text(
                    "data",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
