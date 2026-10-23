import 'package:flutter/material.dart';
import 'package:flutter_lab/riverpod/MyInfoNotifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../myinfo/MyInfoScreen.dart';

class MainDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final myInfo = ref.watch(myInfoProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Image.asset(myInfo.userImage, fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  myInfo.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('MyInfo'),
            onTap: (){
              //Navigation 1.0
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MyInfoScreen()));
              context.push('/myinfo/22?q=flutter', extra: {
                'data1': 'hello',
                'data2': 10
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('dio'),
            onTap: (){
              context.push('/dio');
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('provider'),
            onTap: (){
              context.push('/provider-home');
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('riverpod'),
            onTap: (){
              context.push('/riverpod-home');
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('bloc'),
            onTap: (){
              context.push('/bloc-home');
            },
          ),
        ],
      ),
    );
  }
}