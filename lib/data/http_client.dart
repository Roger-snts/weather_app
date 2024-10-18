
import 'package:http/http.dart' as http;

abstract class IHttpCliente{
  Future get({required String url});
}

class HttpCliente implements IHttpCliente {
  final cliente = http.Client();

  @override
  Future get({required String url}) async {
    return await cliente.get(Uri.parse(url));
  }
}

