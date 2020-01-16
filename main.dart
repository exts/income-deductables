import 'package:money2/money2.dart';
import 'package:income_deductables/load.dart';
import 'package:income_deductables/parse_csv.dart';
import 'package:income_deductables/calculate.dart';

const pathsFilename = "paths.yml";

void main() {
  try {
    var paths = loadPathModel(pathsFilename);
    var files = loadCsvFiles(paths);
    var items = parseCsvFiles(files);
    print("Total Deductable ${Money.from(calculateDeductables(items), Currency.create('USD', 2))}");
  } on Exception catch(e) {
    print("There was an error: ${errMsg(e)}");
  }
}

String errMsg(Exception msg) {
  return msg.toString().replaceAll("Exception: ", "");
}