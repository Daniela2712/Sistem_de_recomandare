import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class httpService {

  httpService();

  Future<void> fetchServerInfo() async {
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAIIIIIIICCCCCCCCCCCCCCCCCCCIIIIIIIIIIII");
    final response = await http.get(
        Uri.parse("http://192.168.193.66:8080/api/products/SONY"));
print(response.statusCode);
    if (response.statusCode == 200) {
      print("BBBBBBBBBBBBBBBBBBBBBBB");

      // If the server did return a 200 OK response,
      // then parse the JSON.
      var responseJson = json.decode(response.body);
      print(responseJson);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load server data');
    }
  }
  Future<void> postServerInfo() async {
var n=['node0', 'node2', 'node3', 'node4', 'node5'];
var w=[];
var h=['node0', 'node2', 'node3', 'node4', 'node5'];
w.add('8578');

    for(int i=0;i<=4; i++) {
      final nodeData = {
        'name': n[i].toString(),
        'weight': w[0].toString(),
        'heuristic': "2.4"
      };
      final resp = await http.post(
          Uri.parse(
              'http://192.168.193.66:8080/api/post'),
          headers: { 'content-type': 'application/json'},
          body: json.encode(nodeData)
      );
    }
  }

}