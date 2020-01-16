import 'package:yaml/yaml.dart';

class PathModel {
  List<String> files = List<String>();
  List<String> directories = List<String>();

  PathModel.fromYAML(YamlMap data) {
    if(data["files"] != null && data["files"] is YamlList) {
      for(var file in data["files"]) {
        if(files.contains(file)) continue;
        files.add(file);
      }
    }

    if(data["directories"] != null && data["directories"] is YamlList) {
      for(var dir in data["directories"]) {
        if(directories.contains(dir)) continue;
        directories.add(dir);
      }
    }
  }
}