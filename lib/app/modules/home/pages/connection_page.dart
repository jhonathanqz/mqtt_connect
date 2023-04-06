import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:beer_mqtt/app/modules/home/mobx/home_store.dart';
import 'package:beer_mqtt/shared/helpers/snack_helper.dart';
import 'package:beer_mqtt/shared/style/app_spacing.dart';
import 'package:beer_mqtt/shared/widgets/banner/banner_connection.dart';
import 'package:beer_mqtt/shared/widgets/scaffold/scaffold_primary.dart';
import 'package:beer_mqtt/shared/widgets/textfield/primary_textfield.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final _editController = TextEditingController();

  final HomeStore _controller = Modular.get();

  @override
  void initState() {
    _editController.text = '15';
    _controller.result = 'Sem dados';
    _controller.isSendActive = false;
    _controller.setLoop('15');

    super.initState();
  }

  @override
  void dispose() {
    _editController.dispose();
    if (_controller.isSendActive) {
      _controller.setLoop('0');
      return;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => _onBack(),
          child: ScaffoldPrimary(
            title: 'Conexão',
            header: BannerConnection(
              isConnected: _controller.isConnection,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      AppSpacing.spaceh15,
                      const Text(
                        'Preencha a quantidade de envios',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppSpacing.spaceh30,
                      PrimaryTextField(
                        controller: _editController,
                        onChanged: _controller.setLoop,
                        label: 'Loop',
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Text(
                          'Resultado: ' + _controller.result,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _service(),
                    child: Text(
                      _controller.isSendActive
                          ? 'Parar envio'
                          : 'Iniciar envio',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _onBack() {
    if (_controller.isConnection) {
      _controller.disconnectMqqt();
      _controller.isConnection = false;
    }
    Modular.to.pop();
    return false;
  }

  void _service() {
    FocusScope.of(context).requestFocus(
      FocusNode(),
    );
    if (!_controller.isConnection) {
      SnackHelper.showSnackInformation(
          'Você não está conectado!', Colors.red, context);
      return;
    }
    if (_controller.isSendActive) {
      _controller.setLoop('');
      _editController.text = '';
      setState(() {});
      return;
    }

    _controller.testePublish();
  }
}
