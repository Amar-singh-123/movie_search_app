import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class InternetChecker extends StatelessWidget {
  const InternetChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        var isOnLine =
            snapshot.data?.contains(ConnectivityResult.mobile) == true ||
                snapshot.data?.contains(ConnectivityResult.wifi) == true ||
                snapshot.data?.contains(ConnectivityResult.ethernet) == true;
        return Visibility(
          visible: isOnLine == false,
          child: SizedBox(
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(isOnLine ? "Online" : "offline",style:TextStyle(
                  color:  isOnLine ? CupertinoColors.activeGreen : CupertinoColors.systemRed,
                  fontWeight: FontWeight.bold
                ) ,),
                CupertinoSwitch(
                  trackColor:  isOnLine ? CupertinoColors.activeGreen : CupertinoColors.systemRed,
                  value: isOnLine,
                  thumbColor: CupertinoColors.white,
                  onChanged: (bool value) {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
