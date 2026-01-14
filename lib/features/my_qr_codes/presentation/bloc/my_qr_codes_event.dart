import 'package:equatable/equatable.dart';

class MyQrCodesEvent extends Equatable {
  const MyQrCodesEvent();

  @override
  List<Object?> get props => [];
}

class MyQrCodesInitialized extends MyQrCodesEvent {
  const MyQrCodesInitialized();
}

class MyQrCodesCategoryChanged extends MyQrCodesEvent {
  final String categoryId;

  const MyQrCodesCategoryChanged(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class MyQrCodesSearchChanged extends MyQrCodesEvent {
  final String query;

  const MyQrCodesSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class MyQrCodesItemDeleted extends MyQrCodesEvent {
  final String id;

  const MyQrCodesItemDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class MyQrCodesRefreshed extends MyQrCodesEvent {
  const MyQrCodesRefreshed();
}
