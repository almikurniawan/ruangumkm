abstract class KomentarEvent {}

class KomentarLoadEvent extends KomentarEvent {
  final String slug;
  KomentarLoadEvent({required this.slug});
}

class KomentarAddEvent extends KomentarEvent {
  final int idSub;
  final int idFasilitator;
  final String komentar;
  final String aksi = 'PESERTA';
  KomentarAddEvent({required this.idSub, required this.idFasilitator, required this.komentar});
}