import 'dart:io';

import 'package:income_deductables/path_model.dart';
import 'package:yaml/yaml.dart';

List<String> loadCsvFileContents(String path) {
  var file = new File(path);
  if(file.existsSync()) {
    return file.readAsLinesSync();
  }
  return List<String>();
}

PathModel loadPathModel(String filename) {
  var file = new File(filename);
  if(!file.existsSync()) {
    throw Exception("Paths file ($filename) doesn't exist");
  }

  var data = file.readAsStringSync();
  if(data.isEmpty) {
    throw Exception("Path settings is empty, please provide yaml data");
  }

  var yaml = loadYaml(data);
  if(yaml["files"] == null && yaml["directories"] == null) {
    throw Exception("You need to provide at least an array of `files` or `directories` for this script in your $filename");
  }

  return PathModel.fromYAML(yaml);
}

List<String> loadCsvFiles(PathModel model) {
  var files = List<String>();

  for(var file in model.files) {
    var tmp = new File(file);
    if(tmp.existsSync() && (file.endsWith('.csv') || file.endsWith('.txt'))) {
      var path = _fixFilePath(tmp.path);
      if(files.contains(path)) continue;
      files.add(file);
    }
  }

  for(var dir in model.directories) {
    var tmp = new Directory(dir);
    if(!tmp.existsSync()) continue;

    for(var file in tmp.listSync()) {
      var path = _fixFilePath(file.path);
      if(path.endsWith('.csv') || path.endsWith('.txt')) {
        if(files.contains(path)) continue;
        files.add(path);
      }
    }
  }

  return files;
}

String _fixFilePath(String path) {
  return path.replaceAll("\\", "/");
}