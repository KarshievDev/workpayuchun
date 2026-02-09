import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LoadTravelCategoriesUseCase {
  final HRMCoreBaseService hrmCoreBaseService;

  LoadTravelCategoriesUseCase({required this.hrmCoreBaseService});

  Future<Either<Failure, List<TravelCategory>>> call() {
    return hrmCoreBaseService.travelCategories();
  }
}
