part of 'address_bloc.dart';

@immutable
abstract class AddressEvent extends Equatable {}

class FetchAddress extends AddressEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitBloc extends AddressEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddAddress extends AddressEvent {
  AddressElement element;
  AddAddress({required this.element});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddFailedAddress extends AddressEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddSuccessAddress extends AddressEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
