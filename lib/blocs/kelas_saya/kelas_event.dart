abstract class KelasEvent {}

class KelasEventLoad extends KelasEvent {
  int? page;
  String? type;
  String? order;
  KelasEventLoad({this.page, this.type, this.order});
}

class KelasEventLoadAll extends KelasEvent {
  int? page;
  String? type;
  String? order;
  String? search;
  KelasEventLoadAll({this.page, this.type, this.order, this.search});
}