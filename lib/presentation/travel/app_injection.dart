import 'package:core/core.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'bloc/travel_bloc/travel_bloc.dart';
import 'bloc/travel_expense_bloc/travel_expense_bloc.dart';
import 'bloc/travel_meeting_bloc/travel_meeting_bloc.dart';

class TravelInjection {
  Future<void> initInjection() async {
    instance.registerFactory<TravelBlocFactory>(() => () => TravelBloc(
          loadTravelPlanUseCase: instance(),
          submitTravelPlanRequest: instance(),
        ));

    instance.registerFactory<TravelMeetingBlocFactory>(() =>
        ({required TravelPlanItem travelPlanItem}) => TravelMeetingBloc(
            loadTravelMeetingUseCase: instance(),
            travelPlanItem: travelPlanItem,
            submitTravelMeetingUseCase: instance()));

    instance.registerFactory<TravelExpenseBlocFactory>(() =>
        ({required TravelPlanItem travelPlanItem}) => TravelExpenseBloc(
            loadTravelCategoriesUseCase: instance(),
            loadTravelExpenseUseCase: instance(),
            loadTravelModeUseCase: instance(),
            submitTravelExpenseUseCase: instance(),
            travelPlanItem: travelPlanItem));
  }
}
