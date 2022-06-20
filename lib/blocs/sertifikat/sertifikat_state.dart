import 'package:online_course/models/sertifikat_model.dart';

abstract class SertifikatState {}

class SertifikatErrorState extends SertifikatState {
  final int errorCode;
  final String errorMessage;
  SertifikatErrorState(this.errorCode, this.errorMessage);
}

class SertifikatStateLoad extends SertifikatState {
  final bool statusLoading;
  final List<SertifikatModel> kelas;
  final int page;
  final String type;
  final String order;
  final int totalPage;
  String? search = "";

  SertifikatStateLoad(
      {required this.statusLoading,
      required this.kelas,
      required this.page,
      required this.type,
      required this.order,
      required this.totalPage,
      this.search});

  SertifikatStateLoad copyFrom(
      {bool? statusLoading,
      List<SertifikatModel>? kelas,
      int? page,
      String? type,
      String? order,
      int? totalPage,
      String? search}) {
    return SertifikatStateLoad(
        statusLoading: statusLoading ?? this.statusLoading,
        kelas: kelas ?? this.kelas,
        page: page ?? this.page,
        type: type ?? this.type,
        order: order ?? this.order,
        totalPage: totalPage ?? this.totalPage,
        search: search ?? this.search);
  }
}
