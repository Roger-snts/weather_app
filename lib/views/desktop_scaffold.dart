import 'package:flutter/material.dart';
import 'package:weather_app/controllers/requests.dart';
import 'package:weather_app/data/http_client.dart';
import 'package:weather_app/stores/weather_store.dart';
import 'package:weather_app/widgets/base_widgets.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  late WeatherStore weatherStore =
      WeatherStore(controller: WeatherController.empty());
  final formKey = GlobalKey<FormState>();
  TextEditingController nomeCidade = TextEditingController();
  TextEditingController nomeEstado = TextEditingController();
  TextEditingController nomePais = TextEditingController();

  cityDefine() {
    setState(() {
      weatherStore = WeatherStore(
          controller: WeatherController(
              cliente: HttpCliente(),
              cidade: nomeCidade.text,
              estado: nomeEstado.text,
              pais: nomePais.text));
      weatherStore.getCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: myFormBar(
                formKey,
                nomeCidade,
                nomeEstado,
                nomePais,
                cityDefine,
                weatherStore,
              ),
            ),
            Flexible(
              flex: 4,
              child: myAnimatedBuilder(
                weatherStore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
