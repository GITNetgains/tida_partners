import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppColors.dart';
import 'package:tida_partners/academy/academy_list.dart';
import 'package:tida_partners/app_settings.dart';
import 'package:tida_partners/home_screen.dart';
import 'package:tida_partners/login_screen.dart';
import 'package:tida_partners/my_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Tida Sports'),
            accountEmail: Text('example@tidasports.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
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
            onTap: () => Get.to(()=> AcademyList()),

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
            onTap: () => Get.to(()=>LoginScreen()),
          ),
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
