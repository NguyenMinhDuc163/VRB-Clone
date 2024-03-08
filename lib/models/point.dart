class Point{
  String _longitude;
  String _latitude;

  Point(this._longitude, this._latitude);

  String get latitude => _latitude;

  String get longitude => _longitude;

  @override
  String toString() {
    return 'Point{_longitude: $_longitude, _latitude: $_latitude}';
  }
}