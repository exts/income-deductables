import 'package:income_deductables/load.dart';

List<List<String>> parseCsvFiles(List<String> paths) {
  var items = List<List<String>>();

  if(paths.isEmpty) return items;

  for(var path in paths) {
    for(var item in parseCsvFile(path)) {
      items.add(item);
    }
  }

  return items;
}

List<List<String>> parseCsvFile(String path) {
  var listData = List<List<String>>();

  var data = loadCsvFileContents(path);
  for(var line in data) {
    if(line.isEmpty) continue;

    var parts = line.split(",");
    if(parts.length < 3) continue;

    listData.add(parts);
  }

  return listData;
}