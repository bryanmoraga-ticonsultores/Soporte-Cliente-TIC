import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

import '../../common.dart';
import '../../consts.dart';
import '../../models/platform_model.dart';
import '../../models/state_model.dart';

class CompanyStatusWidget extends StatefulWidget {
  const CompanyStatusWidget({Key? key}) : super(key: key);

  @override
  State<CompanyStatusWidget> createState() => _CompanyStatusWidgetState();
}

class RequestAssistanceButton extends StatefulWidget {
  const RequestAssistanceButton({Key? key}) : super(key: key);

  @override
  State<RequestAssistanceButton> createState() =>
      _RequestAssistanceButtonState();
}

class _RequestAssistanceButtonState extends State<RequestAssistanceButton> {
  bool _sending = false;
  bool _showReasonField = false;
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _openReasonField() {
    setState(() => _showReasonField = true);
  }

  void _cancelReasonField() {
    setState(() {
      _showReasonField = false;
      _reasonController.clear();
    });
  }

  Future<void> _sendRequest() async {
    setState(() => _sending = true);
    try {
      final myId = await bind.mainGetMyId();

      final resp = await http.post(
        Uri.parse('https://<DIRECCION_SERVIDOR>/api/support/request'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': myId,
          'timestamp': DateTime.now().toIso8601String(),
          'reason': _reasonController.text.trim(),
        }),
      );

      if (resp.statusCode == 200) {
        _showSnack('Solicitud enviada. Un técnico te contactará pronto.');
        setState(() {
          _showReasonField = false;
          _reasonController.clear();
        });
      } else {
        _showSnack('No se pudo enviar la solicitud (${resp.statusCode}).');
      }
    } catch (e) {
      _showSnack('Error de conexión al enviar la solicitud.');
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    if (!_showReasonField) {
      return ElevatedButton.icon(
        onPressed: _openReasonField,
        icon: Icon(Icons.support_agent, size: 18),
        label: Text('Solicitar Asistencia'),
      );
    }

    return Container(
      constraints: BoxConstraints(maxWidth: 320),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _reasonController,
            autofocus: true,
            maxLines: 3,
            maxLength: 200,
            enabled: !_sending,
            decoration: InputDecoration(
              hintText: '¿Cuál es el motivo de tu solicitud?',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _sending ? null : _cancelReasonField,
                child: Text('Cancelar'),
              ),
              SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _sending ? null : _sendRequest,
                icon: _sending
                    ? SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(Icons.support_agent, size: 18),
                label: Text(_sending ? 'Enviando...' : 'Enviar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompanyStatusWidgetState extends State<CompanyStatusWidget> {
  final _svcStopped = Get.find<RxBool>(tag: 'stop-service');
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _updateStatus(); // primera lectura inmediata
    _updateTimer = Timer.periodic(Duration(seconds: 1), (_) => _updateStatus());
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  Future<void> _updateStatus() async {
    final status =
        jsonDecode(await bind.mainGetConnectStatus()) as Map<String, dynamic>;
    final statusNum = status['status_num'] as int;
    if (statusNum == 0) {
      stateGlobal.svcStatus.value = SvcStatus.connecting;
    } else if (statusNum == -1) {
      stateGlobal.svcStatus.value = SvcStatus.notReady;
    } else if (statusNum == 1) {
      stateGlobal.svcStatus.value = SvcStatus.ready;
    } else {
      stateGlobal.svcStatus.value = SvcStatus.notReady;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final status = stateGlobal.svcStatus.value;
      final bool stopped = _svcStopped.value;

      final Color dotColor = stopped || status == SvcStatus.connecting
          ? kColorWarn
          : (status == SvcStatus.ready
              ? Color.fromARGB(255, 50, 190, 166) // mismo verde que el original
              : Color.fromARGB(255, 224, 79, 95)); // mismo rojo que el original

      final String label = stopped
          ? 'Servicio detenido'
          : status == SvcStatus.connecting
              ? 'Conectando...'
              : status == SvcStatus.notReady
                  ? 'Sin conexión'
                  : 'Conectado';

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: dotColor,
            ),
          ),
          SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      );
    });
  }
}

class CompanyPane extends StatelessWidget {
  const CompanyPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 6),
          Text(
            '<NombreDeApp>',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Estado:',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(width: 6),
              CompanyStatusWidget(),
            ],
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RequestAssistanceButton(),
          ),
          Expanded(child: SizedBox()),
          buildFooter(context),
        ],
      ),
    );
  }

  Widget buildFooter(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10);
    final linkStyle = style?.copyWith(decoration: TextDecoration.underline);

    void openUrl(String url) {
      canLaunchUrlString(url).then((can) {
        if (can) {
          launchUrlString(url);
        }
      });
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => openUrl('https://ticonsultores.cl/terms.html'),
          child: Text('Términos de Uso', style: linkStyle),
        ),
        Text(' - ', style: style),
        InkWell(
          onTap: () => openUrl('https://ticonsultores.cl/privacy.html'),
          child: Text('Privacidad', style: linkStyle),
        ),
        Text(' - ', style: style),
        Text('TiConsultores SpA.', style: style),
      ],
    );
  }
}
