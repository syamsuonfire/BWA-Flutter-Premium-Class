import 'dart:convert';
import 'dart:io';

import 'package:food_market/models/models.dart';
import 'package:http/http.dart' as http;

part 'user_services.dart';
part 'food_services.dart';
part 'transaction_services.dart';

String baseURL = "http://foodmarket-backend.buildwithangga.id/api/";