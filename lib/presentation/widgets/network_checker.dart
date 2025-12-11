import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker extends StatefulWidget {
  final Widget child;

  const NetworkChecker({super.key, required this.child});

  @override
  State<NetworkChecker> createState() => _NetworkCheckerState();
}

class _NetworkCheckerState extends State<NetworkChecker> {
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((results) {
      final isConnected = results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi) ||
          results.contains(ConnectivityResult.ethernet);
      setState(() {
        _isOnline = isConnected;
      });
    });
  }

  Future<void> _checkConnection() async {
    final results = await Connectivity().checkConnectivity();
    final isConnected = results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet);
    setState(() {
      _isOnline = isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!_isOnline)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Internet yo\'q',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
