import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/data/exceptions.dart';
import 'package:weather_app/data/http_client.dart';
import 'package:weather_app/models/weather_model.dart';

// Classe abstrata para controlar a url em HTTP
abstract class IHTTPController {
  late String url;
  late String? apiKey;
}

// Classe base para o Weather

abstract class IWeatherController {
  Future<List<WeatherModel>> getWeather();
  late IHttpCliente cliente;
  late String cidade;
  late String estado;
  late String pais;
}

// Controller para pegar os dados da cidade e temperatura

class WeatherController implements IWeatherController, IHTTPController {
  @override
  String cidade;

  @override
  IHttpCliente cliente;

  @override
  String estado;

  @override
  String pais;

  @override
  String? apiKey = dotenv.env["apiKey"];

  @override
  late String url =
      "https://api.openweathermap.org/data/2.5/weather?q=$cidade,$estado,$pais&appid=$apiKey";

  WeatherController(
      {required this.cliente,
      required this.cidade,
      required this.estado,
      required this.pais});

  factory WeatherController.empty(){
    return WeatherController(
      cliente: HttpCliente(),
      cidade: " ",
      estado: " ",
      pais: " ",
      );
  }


  @override
  Future<List<WeatherModel>> getWeather() async {
    final response = await cliente.get(url: url);

    if (response.statusCode == 200) {
      final List<WeatherModel> weatherList = [];

      // Decodificando o Json para Map
      final body = jsonDecode(response.body);

      // Atribuindo o Map ao model de cidade
      WeatherModel weather = WeatherModel.fromMap(body, estado);
      weatherList.add(weather);

      // retornando a lista de Cidades
      return weatherList;
    } else if (response.statusCode == 404) {
      throw StatusNotFoundException(
          mensagem: "A URL está indisponível no momento.");
    } else {
      throw Exception("Não foi possível acessar a URL.");
    }
  }
}
