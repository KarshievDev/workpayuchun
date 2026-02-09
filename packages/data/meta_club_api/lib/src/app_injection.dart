import 'package:core/core.dart';
import 'package:meta_club_api/meta_club_api.dart';

class MetaClubApiInjection{
  Future<void> initInjection() async {
    instance.registerSingleton<MetaClubApiClient>(MetaClubApiClient(httpService: instance()));
    instance.registerSingleton<HRMCoreBaseService>(HRMCoreBaseServiceImpl(connectivityStatusProvider: instance(), metaClubApiClient: instance()));
  }
}