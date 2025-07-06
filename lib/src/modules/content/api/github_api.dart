import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpsss;

import '../models/git_repo.dart';

class GithubApi {
  static ResultData? _cachedData;
  static DateTime? _lastFetch;
  static const Duration _cacheExpiration = Duration(minutes: 15);
  
  Future<ResultData> getAllRepos() async {
    // Return cached data if available and not expired
    if (_cachedData != null && _lastFetch != null && 
        DateTime.now().difference(_lastFetch!) < _cacheExpiration) {
      return _cachedData!;
    }
    List<GitRepoModel> gitRepoModelList;
    var request = httpsss.Request(
        'GET',
        Uri.parse(
            'https://api.github.com/users/Nahianether/repos?page=1&per_page=100'));

    httpsss.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      gitRepoModelList = gitRepoModelFromJson(body);
      final result = ResultData(true, gitRepoModelList, '');
      // Cache the result
      _cachedData = result;
      _lastFetch = DateTime.now();
      return result;
    } else {
      debugPrint(response.reasonPhrase);
      return ResultData(false, [], jsonDecode(body.toString())['message']);
    }
  }
}

class ResultData {
  final bool success;
  List<GitRepoModel> gitRepoModelList;
  final String message;

  ResultData(this.success, this.gitRepoModelList, this.message);

  //from json
  ResultData.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        gitRepoModelList = json['gitRepoModelList'],
        message = json['message'];

  //to json
  Map<String, dynamic> toJson() => {
        'success': success,
        'gitRepoModelList': gitRepoModelList,
        'message': message,
      };
}
