import 'package:app_movies/app/ui/bloc/bloc_states.dart';

class HomeState extends BlocBaseState {
  late final int _buttomSelected;
  final BlocBaseState status;

  HomeState({int buttomSelected = 1, required this.status})
      : _buttomSelected = buttomSelected;

  HomeState copyWith({BlocBaseState? status, int? index}) => HomeState(
      status: status ?? this.status, buttomSelected: index ?? _buttomSelected);

  @override
  List<Object?> get props => [_buttomSelected, status];

  get indexPage => _buttomSelected;
}
