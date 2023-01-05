import 'package:flutter/material.dart';
import 'package:tida_partners/utilss/theme.dart';

import 'AppColors.dart';

class AppSetting extends StatelessWidget {
  const AppSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: setHeadlineMedium("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
               InkWell(
                 onTap: (){},
                 child: Padding(
                   padding: const EdgeInsets.all(2.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                     setMediumLabel("App Notifications"),
                       Switch(value: false, onChanged: null )

                   ],),
                 ),
               ),
              Divider(),

              InkWell(
                 onTap: (){},
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: setMediumLabel("About"),
                 ),
               ),
              Divider(),    InkWell(
                onTap: (){},
                child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: setMediumLabel("Frequently Asked Questions"),
                 ),
              ),
              Divider(),     InkWell(
                onTap: (){},
                child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: setMediumLabel("Terms & Conditions"),
                 ),
              ),
              Divider(),    InkWell(
                onTap: (){},
                child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: setMediumLabel("Privacy Policy"),
                 ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: setSmallLabel("Version 1.0.0"),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
