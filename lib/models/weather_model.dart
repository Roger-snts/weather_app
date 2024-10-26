
class WeatherModel {
  final String cidade;
  final String estado;
  final String pais;
  final String lat;
  final String lon;
  final String tituloEstado;
  final String descricaoEstado;
  final String umidade;
  final String temperaturaInCelsius;
  final double velocidadeVentoKM;

  WeatherModel({
    required this.tituloEstado,
    required this.descricaoEstado,
    required this.umidade,
    required this.velocidadeVentoKM,
    required this.temperaturaInCelsius,
    required this.cidade,
    required this.estado,
    required this.pais,
    required this.lat,
    required this.lon,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map, String state) {
    return WeatherModel(
      cidade: map['name'],
      estado: state,
      pais: map['sys']['country'],
      lat: map['coord']['lat'].toString(),
      lon: map['coord']['lon'].toString(),
      tituloEstado: map['weather'][0]['main'],
      descricaoEstado: map['weather'][0]['description'],
      umidade: map['main']['humidity'].toString(),
      temperaturaInCelsius: (map['main']['temp'] - 273).toStringAsFixed(2),
      velocidadeVentoKM: map['wind']['speed'] * 3.6,
    );
  }
}
