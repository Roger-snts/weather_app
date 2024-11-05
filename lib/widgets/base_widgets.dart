import "package:flutter/material.dart";
import "package:weather_app/stores/weather_store.dart";

myAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  );
}

myGridBlocks(var item, BoxConstraints constraints) {
  if (constraints.maxWidth < 550) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      childAspectRatio: 1,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(12),
      children: [
        myBlock(item.temperaturaInCelsius),
        myBlock(item.tituloEstado),
        myBlock(item.umidade),
        myBlock(item.descricaoEstado),
      ],
    );
  } else if (constraints.maxWidth < 1100) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      childAspectRatio: 1,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(8),
      children: [
        myBlock(item.temperaturaInCelsius),
        myBlock(item.tituloEstado),
        myBlock(item.umidade),
        myBlock(item.descricaoEstado),
      ],
    );
  } else {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      childAspectRatio: 1,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(8),
      children: [
        myBlock(item.temperaturaInCelsius),
        myBlock(item.tituloEstado),
        myBlock(item.umidade),
        myBlock(item.descricaoEstado),
      ],
    );
  }
}

myBlock(var item, {var complemento}) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: const Color(0x894489FF),
        alignment: Alignment.center,
        child: Text(
          item,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    ),
  );
}

myAnimatedBuilder(WeatherStore weatherStore) {
  return AnimatedBuilder(
    animation: Listenable.merge(
        [weatherStore.isLoading, weatherStore.state, weatherStore.erro]),
    builder: (context, child) {
      if (weatherStore.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
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
        return LayoutBuilder(builder: (context, constraints) {
          return myGridBlocks(weatherStore.state.value[0], constraints);
        });
      }
    },
  );
}

myFormBar(
  var formKey,
  TextEditingController nomeCidade,
  TextEditingController nomeEstado,
  TextEditingController nomePais,
  Function cityDefine,
  WeatherStore weatherStore,
) {
  return Column(
    children: [
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
        child: Flexible(
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Cidade"),
                      Flexible(
                        child: TextFormField(
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
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Estado:"),
                      Flexible(
                        child: TextFormField(
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
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("País:"),
                      Flexible(
                        child: TextFormField(
                          autocorrect: true,
                          maxLength: 5,
                          keyboardType: TextInputType.streetAddress,
                          decoration: const InputDecoration(hintText: "Sigla"),
                          controller: nomePais,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Sigla do País";
                            } else {
                              return null;
                            }
                          },
                        ),
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
      )
    ],
  );
}


/*
Formatar para Lista
GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: weatherStore.state.value.length,
            itemBuilder: (_, index) {
              final item = weatherStore.state.value[index];
              return myGridBlocks(item);
            });

*/