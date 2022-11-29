import 'dart:convert';
import 'package:dynamic_pricing/InsuranceCost.dart';
import 'package:http/http.dart';

Future<InsuranceCost> makePostRequest(data) async {

  final uri = Uri.parse('http://127.0.0.1:5000/price');
  final headers= {
    "Access-Control-Allow-Origin": "*",
  'Content-Type': 'application/json',
  'Accept': '*/*'
  };

  String jsonBody = json.encode(data);
  print("Request params:"+ jsonBody);
  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
  );
  Map<String,dynamic> responseMap=json.decode(response.body);
  print("Response Map"+responseMap.toString());
  InsuranceCost insuranceCost= InsuranceCost(responseMap['actualCost'], responseMap['currentCost']);
  return insuranceCost;
}