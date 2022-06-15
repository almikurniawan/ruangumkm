import 'package:online_course/models/Komentar.dart';

abstract class KomentarState {}

class KomentarLoadedState extends KomentarState {
  List<Komentar> komentars;
  bool? isError = false;
  String? errorMessage;
  KomentarLoadedState({required this.komentars, this.errorMessage, this.isError});

  KomentarLoadedState copyFrom(List<Komentar>? komentars, bool? isError, String? errorMessage) {
    return KomentarLoadedState(
      komentars: komentars ?? this.komentars,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}