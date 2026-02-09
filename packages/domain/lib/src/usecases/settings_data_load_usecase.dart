import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';

class SettingsDataLoadUseCase extends BaseUseCase<Settings?>{
  final HRMCoreBaseService hrmCoreBaseService;

  SettingsDataLoadUseCase({required this.hrmCoreBaseService});

  @override
  Future<Either<Failure, Settings?>> call() async {
    return await hrmCoreBaseService.getSettings();
  }
}