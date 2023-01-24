import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppColors.dart';
import 'package:tida_partners/academy/academy_list.dart';
import 'package:tida_partners/app_settings.dart';
import 'package:tida_partners/experiences/experience_list.dart';
import 'package:tida_partners/home_screen.dart';
import 'package:tida_partners/login_screen.dart';
import 'package:tida_partners/my_profile.dart';
import 'package:tida_partners/utilss/SharedPref.dart';
import 'package:url_launcher/url_launcher.dart';

import 'tournaments/tournament_list.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(Preferences.getName()),
            accountEmail: Text(Preferences.getEmail()),
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
            onTap: () => Get.to(()=>MyProfile()),
          ),
          ListTile(
            leading: Icon(Icons.place),
            title: Text('Venues'),
            onTap: () => Get.to(()=> HomeScreen()),
          ),
          ListTile(
            leading: Icon(Icons.class_),
            title: Text('Academies'),
            onTap: () => Get.to(()=> AcademyList()),

          ), ListTile(
            leading: Icon(Icons.tour_outlined),
            title: Text('Tournaments'),
            onTap: () => Get.to(()=> TournamentList()),

          ),ListTile(
            leading: Icon(Icons.stars),
            title: Text('Experiences'),
            onTap: () => Get.to(()=> ExperienceList()),

          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Get.to(()=> AppSetting()),
          ),
          ListTile(
            leading: Icon(Icons.support_agent_sharp),
            title: Text('Contact Tida Sport'),
            onTap: () => _launchCaller,
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap:(){
              Preferences.clearAll();
    Get.offAll(()=>LoginScreen());


    }),

        ],
      ),
    );
  }
  _launchCaller() async {
    const url = "tel:+916283777710";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
