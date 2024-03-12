class BankLocation{
  final String _address;
  final String _type;
  final String _shotName;
  final String _idImage;
  final String _longitude;
  final String _latitude;

  BankLocation(this._address, this._type, this._shotName, this._idImage,
      this._longitude, this._latitude);

  String get latitude => _latitude;

  String get longitude => _longitude;

  String get idImage => _idImage;

  String get shotName => _shotName;

  String get type => _type;

  String get address => _address;

  @override
  String toString() {
    return 'BankLocation{_address: $_address, _type: $_type, _shotName: $_shotName, _idImage: $_idImage, _longitude: $_longitude, _latitude: $_latitude}';
  }
}