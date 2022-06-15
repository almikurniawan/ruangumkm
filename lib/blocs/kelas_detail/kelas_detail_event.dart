abstract class KelasDetailEvent{}

class KelasDetailLoadEvent extends KelasDetailEvent{
  final String slug;
  KelasDetailLoadEvent({required this.slug});
}