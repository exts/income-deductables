double calculateDeductables(List<List<String>> items) {
  if(items.isEmpty) return 0;

  double total = 0;
  for(var item in items) {
    var value = double.tryParse(item[2].trim());
    if(value != null) {
      total += value;
    }
  }

  return total;
}