import 'package:flutter/material.dart';
import 'package:weather_app/controllers/requests.dart';
import 'package:weather_app/data/http_client.dart';
import 'package:weather_app/stores/weather_store.dart';
import 'package:weather_app/widgets/base_widgets.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  late WeatherStore weatherStore = WeatherStore(controller: WeatherController(cliente: HttpCliente(), cidade: " ", estado: " ", pais: " "));
  final formKey = GlobalKey<FormState>();
  TextEditingController nomeCidade = TextEditingController();
  TextEditingController nomeEstado = TextEditingController();
  TextEditingController nomePais = TextEditingController();

  cityDefine() {
    setState(() {
       weatherStore = WeatherStore(controller: WeatherController(cliente: HttpCliente(), cidade: nomeCidade.text, estado: nomeEstado.text, pais: nomePais.text));
       weatherStore.getCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: myAnimatedBuilder(weatherStore)
            ),
            const Row(
              children: [
                Icon(Icons.pin_drop_outlined),
                Text(
                  "Defina o local",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ],
            ),
            Form(
              key: formKey,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Cidade"),
                          TextFormField(
                            autocorrect: true,
                            maxLength: 18,
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(hintText: "Nome"),
                            controller: nomeCidade,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Informe: cidade";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Estado:"),
                          TextFormField(
                            autocorrect: true,
                            maxLength: 5,
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(hintText: "UF"),
                            controller: nomeEstado,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Sigla da UF";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("País:"),
                          TextFormField(
                            autocorrect: true,
                            maxLength: 5,
                            keyboardType: TextInputType.streetAddress,
                            decoration:
                                const InputDecoration(hintText: "Sigla"),
                            controller: nomePais,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Sigla do País";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cityDefine();
                        weatherStore.getCities();
                      }
                    },
                    child: const Icon(Icons.search),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
