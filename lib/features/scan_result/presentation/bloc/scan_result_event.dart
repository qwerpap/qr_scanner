import 'package:equatable/equatable.dart';

abstract class ScanResultEvent extends Equatable {
  const ScanResultEvent();

  @override
  List<Object?> get props => [];
}

class ScanResultInitialized extends ScanResultEvent {
  final String qrData;

  const ScanResultInitialized(this.qrData);

  @override
  List<Object?> get props => [qrData];
}

class ScanResultCopyRequested extends ScanResultEvent {
  const ScanResultCopyRequested();
}

class ScanResultShareRequested extends ScanResultEvent {
  const ScanResultShareRequested();
}

class ScanResultSaveRequested extends ScanResultEvent {
  const ScanResultSaveRequested();
}

class ScanResultOpenLinkRequested extends ScanResultEvent {
  const ScanResultOpenLinkRequested();
}

class ScanResultNotificationDismissed extends ScanResultEvent {
  const ScanResultNotificationDismissed();
}
