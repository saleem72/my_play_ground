// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bottom_bar_cubit_cubit.dart';

// class Coordinates {
//   final double x;
//   final double y;

//   Coordinates({
//     required this.x,
//     required this.y,
//   });
// }

class BottomBarCubitState extends Equatable {
  final CustomBottomBarPage page;
  final Offset position;

  const BottomBarCubitState({
    required this.page,
    required this.position,
  });

  @override
  List<Object> get props => [page, position];
}
