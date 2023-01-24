import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_partners/AppColors.dart';
import 'package:tida_partners/utilss/theme.dart';

import 'login_screen.dart';
import 'utilss/SharedPref.dart';

class MyProfile extends StatelessWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("My Profile"),
     /*   actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.edit, color: Colors.white),
          )
        ],*/
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.deepOrange.shade300],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 80.0,
                      child: CircleAvatar(
                        radius: 70.0,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            'https://tidasports.com/wp-content/uploads/2022/11/Tida-Logo-1.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Preferences.getName(),
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    Preferences.getEmail(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Phone',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    Preferences.getPhone(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Account Status',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    Preferences.getStatus() == "1" ? "Active" : "Inactive",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                /*   Divider(),
                ListTile(
                  title: Text(
                    'Linked Bank Account',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'No Account linked ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing: CircleAvatar(
                      backgroundColor: PRIMARY_COLOR,
                      child: Icon(Icons.add,color: Colors.white)),
                ),
                Divider(),*/
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: getSecondaryButton("Logout", () {
                    Preferences.clearAll();
                    Get.offAll(() => LoginScreen());
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                //   setTextButton("Delete Account",)
              ],
            ),
          )
        ],
      ),
    );
  }
}
