//

import 'package:flutter/material.dart';
import 'package:my_play_ground/common/localization/language_constants.dart';

class NetworkMonitorScreen extends StatelessWidget {
  const NetworkMonitorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).network_monitor),
      ),
      body: Center(
        child: Text(translation(context).network_monitor),
      ),
    );
  }
}
