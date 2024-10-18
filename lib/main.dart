import 'package:flutter/material.dart';
import 'package:weather_app/controllers/requests.dart';
import 'package:weather_app/data/http_client.dart';
import 'package:weather_app/stores/weather_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WeatherStore cityStore = WeatherStore(controller: WeatherController(cliente: HttpCliente(), cidade: "Ji-Paraná", estado: "RO", pais: "BR"));

  @override
  void initState() {
    super.initState();
    cityStore.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: AnimatedBuilder(
            animation: Listenable.merge(
                [cityStore.isLoading, cityStore.state, cityStore.erro]),
            builder: (context, child) {
              if (cityStore.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (cityStore.erro.value.isNotEmpty) {
                return Center(
                    child: Text(
                  cityStore.erro.value,
                  textAlign: TextAlign.center,
                ));
              }

              if (cityStore.state.value.isEmpty) {
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
                    itemCount: cityStore.state.value.length,
                    itemBuilder: (_, index) {
                      final item = cityStore.state.value[index];
                      return Column(
                        children: [
                          ListTile(
                              trailing: Text(item.temperaturaInCelsius.toStringAsFixed(2), style: TextStyle(fontSize: 22),), 
                              title: Text("Temperatura atual"),
                              ),
                        ],
                      );
                    });
              }
            }));
  }
}
