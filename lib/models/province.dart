import 'district.dart';

class Province{
  final String _regionName;
  final String _regionCode1;
  Province(this._regionName, this._regionCode1);


  Province.withRegionName(this._regionName) : _regionCode1 = '';

  String get regionCode1 => _regionCode1;

  String get regionName => _regionName;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Province &&
          runtimeType == other.runtimeType &&
          _regionName == other._regionName;

  @override
  int get hashCode => _regionName.hashCode;

  @override
  String toString() {
    return '$_regionName - $_regionCode1}';
  }
}