
import 'package:flutter/material.dart';
import 'package:weather_app/controllers/requests.dart';
import 'package:weather_app/data/exceptions.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherStore {
  final IWeatherController controller;

  // Essa parte reage/monitora o Carregamento inicial / Loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Essa parte reage/monitora o Estado da requisição / State
  final ValueNotifier<List<WeatherModel>> state = ValueNotifier<List<WeatherModel>>([]);

  // Essa parte reage/monitora os Erros / Error
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  WeatherStore({required this.controller});

  Future getCities() async {
    isLoading.value = true;

    try {
      final resultado = await controller.getWeather();
      state.value = resultado;

    } on StatusNotFoundException catch(e) {
      erro.value = e.mensagem;
    } catch (e) {
      erro.value = e.toString();
    }
    
    isLoading.value = false;
  }
}

