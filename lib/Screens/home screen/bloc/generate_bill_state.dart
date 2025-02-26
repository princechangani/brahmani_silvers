

import 'package:brahmani_silvers/model/bill_model.dart';
import 'package:equatable/equatable.dart';

sealed class GenerateBillState extends Equatable {
  @override
  List<Object> get props => [];
  const GenerateBillState();
}

 class GenerateBillInitial extends GenerateBillState {}


class GenerateBillLoadingState extends GenerateBillState{}


class BillAddedState extends GenerateBillState{}

class BillLoadedState extends GenerateBillState{
  final List<BillModel> billList;
  BillLoadedState(this.billList);
  @override
  List<Object> get props => [billList];
}
class BillFetchError extends GenerateBillState{
  final String error ;

  BillFetchError(this.error);

  @override
  List<Object> get props => [error];

}
