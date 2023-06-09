import 'package:flutter/material.dart';

class BannerConnection extends StatelessWidget {
  const BannerConnection({
    Key? key,
    required this.isConnected,
  }) : super(key: key);

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: isConnected ? Colors.green : Colors.red,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          isConnected ? 'Conectado' : 'Sem conexão',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
