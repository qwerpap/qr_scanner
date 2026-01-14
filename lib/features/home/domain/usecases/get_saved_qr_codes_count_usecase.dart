import '../repositories/home_repository.dart';

class GetSavedQrCodesCountUseCase {
  final HomeRepository repository;

  GetSavedQrCodesCountUseCase(this.repository);

  Future<int> execute() async {
    return await repository.getSavedQrCodesCount();
  }
}
