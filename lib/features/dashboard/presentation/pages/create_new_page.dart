import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/appbar/create_appbar.dart';

class CreateNewPage extends StatefulWidget {
  const CreateNewPage({super.key});

  @override
  _CreateNewPageState createState() => _CreateNewPageState();
}

class _CreateNewPageState extends State<CreateNewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CreateAppBar(),
      body: Center(
        child: Container(
          width: 369,
          height: 460,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black26,
            //     blurRadius: 3,
            //     spreadRadius: 2,
            //     offset: Offset(0, 2),
            //   ),
            // ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
