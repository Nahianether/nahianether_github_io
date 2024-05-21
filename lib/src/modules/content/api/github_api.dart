import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpsss;

import '../models/git_repo.dart';

class GithubApi {
  Future<ResultData> getAllRepos() async {
    List<GitRepoModel> gitRepoModelList;
    var request = httpsss.Request(
        'GET',
        Uri.parse(
            'https://api.github.com/users/Nahianether/repos?page=1&per_page=100'));

    httpsss.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      gitRepoModelList = gitRepoModelFromJson(body);
      return ResultData(true, gitRepoModelList, '');
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
