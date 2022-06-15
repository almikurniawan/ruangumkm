import 'package:online_course/models/kelas_saya_model.dart';

abstract class KelasState {}

class KelasErrorState extends KelasState {
  final int errorCode;
  final String errorMessage;
  KelasErrorState(this.errorCode, this.errorMessage);
}

class KelasStateLoad extends KelasState{
  final bool statusLoading;
  final List<KelasSayaModel> kelas;
  final int page;
  final String type;
  final String order;
  final int totalPage;
  String? search = "";

  KelasStateLoad({required this.statusLoading, required this.kelas, required this.page, required this.type, required this.order, required this.totalPage, this.search});

  KelasStateLoad copyFrom({bool? statusLoading, List<KelasSayaModel>? kelas, int? page, String? type, String? order, int? totalPage, String? search}){
    return KelasStateLoad(
      statusLoading: statusLoading ?? this.statusLoading, 
      kelas: kelas ?? this.kelas, 
      page: page ?? this.page,
      type: type ?? this.type, 
      order: order ?? this.order, 
      totalPage: totalPage ?? this.totalPage,
      search: search ?? this.search
    );
  }
}