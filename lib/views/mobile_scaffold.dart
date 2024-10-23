import 'package:flutter/material.dart';
import 'package:weather_app/controllers/requests.dart';
import 'package:weather_app/data/http_client.dart';
import 'package:weather_app/stores/weather_store.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: Listenable.merge(
                    [weatherStore.isLoading, weatherStore.state, weatherStore.erro]),
                builder: (context, child) {
                  if (weatherStore.isLoading.value) {
                    return CircularProgressIndicator();
                  }

                  if (weatherStore.erro.value.isNotEmpty) {
                    return Center(
                        child: Text(
                      weatherStore.erro.value,
                      textAlign: TextAlign.center,
                    ));
                  }

                  if (weatherStore.state.value.isEmpty) {
                    return const Center(
                      child: Text(
                        "Nenhum item encontrado...",
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 12,
                            ),
                        itemCount: weatherStore.state.value.length,
                        itemBuilder: (_, index) {
                          final item = weatherStore.state.value[index];
                          return Column(
                            children: [
                              ListTile(
                                trailing: Text(
                                  item.temperaturaInCelsius.toStringAsFixed(2),
                                  style: TextStyle(fontSize: 22),
                                ),
                                title: Text("Temperatura atual"),
                              ),
                            ],
                          );
                        });
                  }
                },
              ),
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
