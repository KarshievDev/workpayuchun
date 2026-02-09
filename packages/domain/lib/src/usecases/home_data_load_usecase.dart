import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class HomeDataLoadUseCase extends BaseUseCase<DashboardModel?>{
  final HRMCoreBaseService hrmCoreBaseService;

  HomeDataLoadUseCase({required this.hrmCoreBaseService});

  @override
  Future<Either<Failure, DashboardModel?>> call() async {
    return await hrmCoreBaseService.getDashboardData();
  }
}
