import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:beer_mqtt/app/modules/home/mobx/home_store.dart';
import 'package:beer_mqtt/shared/helpers/snack_helper.dart';
import 'package:beer_mqtt/shared/style/app_spacing.dart';
import 'package:beer_mqtt/shared/widgets/banner/banner_connection.dart';
import 'package:beer_mqtt/shared/widgets/scaffold/scaffold_primary.dart';
import 'package:beer_mqtt/shared/widgets/textfield/primary_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final brokerController = TextEditingController();
  final portController = TextEditingController();
  final topicController = TextEditingController();
  final clientIdentController = TextEditingController();
  final _subtopic1Controller = TextEditingController();
  final _subtopic2Controller = TextEditingController();
  final _subtopic3Controller = TextEditingController();

  final HomeStore _controller = Modular.get();

  @override
  void dispose() {
    brokerController.dispose();
    portController.dispose();
    topicController.dispose();
    clientIdentController.dispose();
    _subtopic1Controller.dispose();
    _subtopic2Controller.dispose();
    _subtopic3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return ScaffoldPrimary(
          title: 'Home',
          isLoading: _controller.isLoading,
          header: BannerConnection(
            isConnected: _controller.isConnection,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSpacing.spaceh15,
                  const Text(
                    'Preencha as configurações para conexão',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSpacing.spaceh30,
                  PrimaryTextField(
                    controller: brokerController,
                    onChanged: _controller.setBroker,
                    label: 'Broker',
                  ),
                  AppSpacing.spaceh15,
                  PrimaryTextField(
                    controller: portController,
                    onChanged: _controller.setPort,
                    label: 'Porta',
                  ),
                  AppSpacing.spaceh15,
                  PrimaryTextField(
                    controller: topicController,
                    onChanged: _controller.setTopic,
                    label: 'Topico',
                  ),
                  AppSpacing.spaceh15,
                  PrimaryTextField(
                    controller: clientIdentController,
                    onChanged: _controller.setClientIdentifier,
                    label: 'Identificação cliente',
                  ),
                  AppSpacing.spaceh15,
                  PrimaryTextField(
                    controller: _subtopic1Controller,
                    onChanged: _controller.setSubtopic1,
                    label: 'Ouvir topico 1',
                  ),
                  AppSpacing.spaceh15,
                  PrimaryTextField(
                    controller: _subtopic2Controller,
                    onChanged: _controller.setSubtopic2,
                    label: 'Ouvir topico 2',
                  ),
                  AppSpacing.spaceh15,
                  PrimaryTextField(
                    controller: _subtopic3Controller,
                    onChanged: _controller.setSubtopic3,
                    label: 'Ouvir topico 3',
                  ),
                  AppSpacing.spaceh15,
                  AppSpacing.spaceh15,
                  ElevatedButton(
                    onPressed: () => _showConnect(),
                    child: const Text('Conectar'),
                  ),
                  AppSpacing.spaceh15,
                  Visibility(
                    visible: _controller.isConnection,
                    child: ElevatedButton(
                      onPressed: () async {
                        Modular.to.pushNamed('./connection');
                      },
                      child: const Text('Enviar dados'),
                    ),
                  ),
                  AppSpacing.spaceh15,
                  AppSpacing.spaceh15,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showConnect() async {
    // _controller.isConnection = false;
    if (_controller.isConnection) {
      SnackHelper.showSnackInformation(
          'Você já está conectado', Colors.green, context);
      return;
    }
    if (_controller.connection.broker.toLowerCase().contains('http')) {
      SnackHelper.showSnackInformation(
          'Informe seu BROKER sem o "http"', Colors.red, context);
      return;
    }
    await _controller.connect();
    if (!_controller.isConnection) {
      SnackHelper.showSnackInformation(
          'Erro ao realizar conexão MQTT', Colors.red, context);
    }
  }
}
