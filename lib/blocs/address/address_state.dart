part of 'address_bloc.dart';

@immutable
abstract class AddressState extends Equatable {}

class AddressInitial extends AddressState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddressLoading extends AddressState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddressLoaded extends AddressState {
  final Address address;
  AddressLoaded({required this.address});

  @override
  // TODO: implement props
  List<Object?> get props => [address];
}

class AddressNotFound extends AddressState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddressFailed extends AddressState {
  final String error;
  AddressFailed({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class TokenExpired extends AddressState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
