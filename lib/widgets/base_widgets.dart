import "package:flutter/material.dart";
import "package:weather_app/stores/weather_store.dart";

myAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  );
}

myGridBlocks(var item) {
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
        return myGridBlocks(weatherStore.state.value[0]);
      }
    },
  );
}

/*

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