import 'package:online_course/models/fasilitator.dart';
import 'package:online_course/models/kelas.dart';

abstract class DashboardState{}

class DashboardLoadState extends DashboardState{
  final bool loading;
  List<Kelas>? kelasTerbaru = [];
  List<Kelas>? kelasTerpopuler = [];
  List<Kelas>? kelasMendatang = [];
  List<Fasilitator>? fasilitator = [];

  DashboardLoadState({this.loading = false, this.kelasTerbaru, this.kelasTerpopuler, this.kelasMendatang, this.fasilitator});

}