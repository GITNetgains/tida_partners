import 'package:flutter/material.dart';
import 'package:tida_partners/AppColors.dart';
import 'package:tida_partners/utilss/theme.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("My Profile"),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.edit, color: Colors.white),
        )],
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
                      minRadius: 60.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                        NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png'),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Tida Sports',
                  style: TextStyle(
                    fontSize: 24  ,
                    color: Colors.white
                  ),
                )

              ],
            ),
          ),

          Container(
            child: Column(
              children:  const  <Widget>[


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
                    'example@tidasport.com',
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
                    '+91987654321',
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
                    'Active ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
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
                Divider(),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width:double.infinity,
                  child: getSecondaryButton("Logout", (){}


                  ),
                ),
                SizedBox(height: 20,),
                setTextButton("Delete Account",)
              ],
            ),
          )
        ],
      ),
    );
  }
}

