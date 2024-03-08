class District{
  final String _districtName;
  final String _districtCode;

  District(this._districtName, this._districtCode);

  String get districtCode => _districtCode;

  String get districtName => _districtName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is District &&
          runtimeType == other.runtimeType &&
          _districtCode == other._districtCode;

  @override
  int get hashCode => _districtCode.hashCode;

  @override
  String toString() {
    return ' $_districtName - $_districtCode}';
  }
}