import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppColors.dart';
import 'package:tida_partners/academy/academy_list.dart';
import 'package:tida_partners/app_settings.dart';
import 'package:tida_partners/controllers/AcademyController.dart';
import 'package:tida_partners/experiences/experience_list.dart';
import 'package:tida_partners/home_screen.dart';
import 'package:tida_partners/login_screen.dart';
import 'package:tida_partners/my_profile.dart';
import 'package:tida_partners/utilss/SharedPref.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Bookings.dart';
import 'tournaments/tournament_list.dart';

class NavBar extends StatelessWidget {
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse("https://tidasports.com/contact-us/"))) {
      throw 'Could not launch';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(Preferences.getName().capitalizeFirst!),
            accountEmail: Text(Preferences.getEmail().capitalizeFirst!),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  'https://tidasports.com/wp-content/uploads/2022/11/Tida-Logo-1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: PRIMARY_COLOR,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My profile'),
            onTap: () => Get.to(() => MyProfile()),
          ),
          ListTile(
            leading: Icon(Icons.bookmarks),
            title: Text('Bookings'),
            onTap: () => Get.to(() => Bookings()),
          ),
          ListTile(
            leading: Icon(Icons.place),
            title: Text('Venues'),
            onTap: () => Get.to(() => HomeScreen()),
          ),
          ListTile(
              leading: Icon(Icons.class_),
              title: Text('Academies'),
              onTap: () {
                bool test = Get.isRegistered<AcademyController>();
                if (test) {
                  final _c = Get.put(AcademyController());
                  _c.onInit();
                }
                Get.to(() => AcademyList());
              }),
          ListTile(
            leading: Icon(Icons.tour_outlined),
            title: Text('Tournaments'),
            onTap: () => Get.to(() => TournamentList()),
          ),
          ListTile(
            leading: Icon(Icons.stars),
            title: Text('Experiences'),
            onTap: () => Get.to(() => ExperienceList()),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () => Get.to(() => AppSetting()),
          ),
          ListTile(
            leading: Icon(Icons.support_agent_sharp),
            title: Text('Contact Us'),
            onTap: () => _launchUrl(),
          ),
          Divider(),
          ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                showAlertDialog(context);
              }),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: PRIMARY_COLOR),
      ),
      onPressed: () {
        Preferences.clearAll();
        Get.offAll(() => LoginScreen());
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Do you want to logout?"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
