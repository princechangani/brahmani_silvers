class BillModel {
  BillModel({
    this.id,
    this.date,
    this.weight,
    this.crWeight,
    this.details,
    this.pieces,});

  BillModel.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    weight = json['weight'];
    details = json['email'];
    crWeight = json['details'];
    pieces = json['pieces'];
  }
  int? id;
  String? date;
  String? weight;
  String? details;
  String? crWeight;
  String? pieces;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['weight'] = weight;
    map['details'] = details;
    map['crWeight'] = crWeight;
    map['pieces'] = pieces;
    return map;
  }

}