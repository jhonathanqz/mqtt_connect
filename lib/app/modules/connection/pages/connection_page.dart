import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:beer_mqtt/app/modules/connection/mobx/connect_store.dart';
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
  final _messageController = TextEditingController();
  final _topicController = TextEditingController();

  final ConnectStore _controller = Modular.get();
  late ReactionDisposer _updatePage;

  @override
  void initState() {
    _messageController.text = 'on';
    _controller.result = [];
    _controller.isSendActive = false;
    _controller.isUpdated = false;
    _controller.setMessage('on');

    _topicController.text = _controller.connection?.topic ?? '';

    _updatePage = reaction(
      (_) => _controller.isUpdated,
      (_) {
        if (_controller.isUpdated) {
          _controller.isUpdated = false;
          setState(() {});
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    if (_controller.isSendActive) {
      _controller.setMessage('off');
      return;
    }
    _updatePage.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Observer(
      builder: (context) {
        final ConnectStore _controller = Modular.get();
        return WillPopScope(
          onWillPop: () async => _onBack(),
          child: ScaffoldPrimary(
            isLoading: _controller.isLoading,
            title: 'Conexão',
            header: BannerConnection(
              isConnected: _controller.isConnection,
            ),
            child: Container(
              height: _size.height,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppSpacing.spaceh15,
                          const Text(
                            'Tópico de envio:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AppSpacing.spaceh30,
                          PrimaryTextField(
                            controller: _topicController,
                            onChanged: _controller.setTopicMessage,
                            label: 'tópico',
                          ),
                          AppSpacing.spaceh15,
                          const Text(
                            'Mensagem de envio:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AppSpacing.spaceh30,
                          PrimaryTextField(
                            controller: _messageController,
                            onChanged: _controller.setMessage,
                            label: 'Mensagem',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Observer(builder: (context) {
                    return Expanded(
                      child: Container(
                        child: _controller.result.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: _controller.result.length,
                                itemBuilder: (context, index) {
                                  final _result = _controller.result[index];
                                  return ListTile(
                                    title: Text('Message: ${_result.message}'),
                                    subtitle: Text('Topic: ${_result.topic}'),
                                  );
                                },
                              )
                            : const Center(child: Text('Sem dados')),
                      ),
                    );
                  }),
                  ElevatedButton(
                    onPressed: () => _service(),
                    child: const Text('Enviar'),
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

  void _service() async {
    FocusScope.of(context).requestFocus(
      FocusNode(),
    );
    if (!_controller.isConnection) {
      SnackHelper.showSnackInformation(
          'Você não está conectado!', Colors.red, context);
      return;
    }
    if (_controller.isSendActive) {
      _controller.setMessage('');
      _messageController.text = '';
      setState(() {});
      return;
    }

    await _controller.testePublish();
  }
}
