part of 'asset_cubit.dart';

abstract class AssetState extends Equatable {
  const AssetState();

  @override
  List<Object> get props => [];
}

class AssetInitial extends AssetState {}

class AssetLoaded extends AssetState {
  List<AssetModel?> assets;

  AssetLoaded({required this.assets});

  @override
  List<Object> get props => [assets];

}

class AssetPagination extends AssetState {}

class AssetError extends AssetState {
  String message;

  AssetError(this.message);

  @override
  List<Object> get props => [message];
}
