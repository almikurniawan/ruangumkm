import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/dashboard/dashboard_event.dart';
import 'package:online_course/blocs/dashboard/dashboard_state.dart';
import 'package:online_course/models/fasilitator.dart';
import 'package:online_course/models/kelas.dart';
import 'package:online_course/repositories/dashboardService.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(DashboardLoadState dashboardLoadState) : super(DashboardLoadState(loading: true)){
    on<DashboardLoadEvent>((event, emit) async{
      emit(DashboardLoadState(loading: true));
      Map<String, dynamic> result = await DashboardService().loadDashboard();
      List<Kelas> kelasTerbaru = List.from(result['event_baru']).map((item) => Kelas.fromJson(item)).toList();
      List<Kelas> kelasTerpopuler = List.from(result['event_populer']).map((item) => Kelas.fromJson(item)).toList();
      List<Kelas> kelasMendatang = List.from(result['event_mendatang']).map((item) => Kelas.fromJson(item)).toList();
      List<Fasilitator> fasilitator = List.from(result['fasilitator']).map((item) => Fasilitator.fromJson(item)).toList();
      emit(DashboardLoadState(loading: false, kelasTerbaru: kelasTerbaru, kelasTerpopuler: kelasTerpopuler, kelasMendatang: kelasMendatang, fasilitator : fasilitator));
    });
  }
}