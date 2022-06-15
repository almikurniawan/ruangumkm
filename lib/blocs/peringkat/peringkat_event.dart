abstract class PeringkatEvent {}

class PeringkatLoadEvent extends PeringkatEvent {
  final String slug;
  PeringkatLoadEvent({required this.slug});
}
