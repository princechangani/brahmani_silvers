

import 'package:equatable/equatable.dart';

sealed class GenerateBillEvent extends Equatable {
  const GenerateBillEvent();
  @override
  List<Object> get props => [];
}

class AddBillEntryEvent extends GenerateBillEvent{
  final int id;
  final String date;
  final String details;
  final String weight;
  final String crWeight;
  final String pieces;

  AddBillEntryEvent({ required this.id,required this.date, required this.details, required this.weight, required this.crWeight, required this.pieces});

}
class FetchBillEntriesEvent extends GenerateBillEvent{}
