import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:beer_mqtt/app/modules/connection/mobx/connect_store.dart';
import 'package:beer_mqtt/core/entities/connection.dart';
import 'package:beer_mqtt/shared/helpers/snack_helper.dart';
import 'package:beer_mqtt/shared/style/app_colors.dart';
import 'package:beer_mqtt/shared/style/app_spacing.dart';

class ConnectionLoad extends StatefulWidget {
  const ConnectionLoad({
    Key? key,
    required this.connection,
  }) : super(key: key);
  final Connection connection;

  @override
  State<ConnectionLoad> createState() => _ConnectionLoadState();
}

class _ConnectionLoadState extends State<ConnectionLoad> {
  final ConnectStore _controller = Modular.get();
  late ReactionDisposer _connectionDisposer;
  Color _color = AppColors.appparColor;
  String _text = 'Conectando...';

  @override
  void initState() {
    _connectionDisposer = autorun(
      (_) async {
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {});
        _controller.setConnection(widget.connection);
        await _controller.connect();
        if (_controller.isConnection) {
          _color = AppColors.green.withOpacity(0.8);
          _text = 'Conectado com sucesso';
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 1000));
          Modular.to.popAndPushNamed('./connection/');
          return;
        }
        Modular.to.pop();
        SnackHelper.showSnackInformation(
            'Erro ao conectar no servidor MQTT', Colors.red, context);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _connectionDisposer.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Observer(
      builder: (context) {
        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: _size.height,
            width: _size.width,
            color: _color,
            //margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _text,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
                AppSpacing.spaceh30,
                const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
