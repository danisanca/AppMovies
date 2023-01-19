part of 'bloc.dart';

class GetIndexPage extends BlocBaseEvent {
  GetIndexPage();
}

class SaveIndexPage extends BlocBaseEvent {
  final int index;

  SaveIndexPage(this.index);
}