abstract class SertifikatEvent {}

class SertifikatEventLoad extends SertifikatEvent {
  int? page;
  String? type;
  String? order;
  SertifikatEventLoad({this.page, this.type, this.order});
}
