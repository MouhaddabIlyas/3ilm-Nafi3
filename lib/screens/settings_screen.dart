import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:_3ilm_nafi3/screens/terms_conditions_page.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDialogOpen = false;

  void _showTermsAndConditions(BuildContext context) {
    setState(() {
      _isDialogOpen = true;
    });

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            color: Colors.white,
            child: TermsAndConditionsPage(),
          ),
        );
      },
    ).then((_) {
      setState(() {
        _isDialogOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => _showTermsAndConditions(context),
              child: const Text("Show Terms & Conditions"),
            ),
          ),
          if (_isDialogOpen)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
        ],
      ),
    );
  }
}
