import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanning_options.freezed.dart';

@freezed
class ScanningOptions with _$ScanningOptions {
  const factory ScanningOptions({
    @Default([]) List<String> services,
    @Default(false) bool ignoreNoName,
    @Default(ScanSorting.none) ScanSorting sorting,
    @Default(ScanSortingDirection.ascending) ScanSortingDirection direction,
  }) = _ScanningOptions;
}

enum ScanSorting { rssi, name, none }
enum ScanSortingDirection { ascending, descending }
