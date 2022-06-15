abstract class TugasEvent{}

class TugasLoadEvent extends TugasEvent{
  final String slug;
  TugasLoadEvent({required this.slug});
}