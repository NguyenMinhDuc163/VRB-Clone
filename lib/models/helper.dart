// import 'bank_location.dart';
//
// class Helper{
//   static  double distanceBetween(String latitude, String longitude){
//     return Geolocator.distanceBetween
//       (_currentLocation.latitude, _currentLocation.longitude, double.parse(latitude), double.parse(longitude));
//   }
//   static List<Map<String, BankLocation>> sortMap(List<Map<String, BankLocation>> newAddresses)  {
//     for(int i = 0; i < newAddresses.length; i++){
//       List<MapEntry<String, BankLocation>> entries = newAddresses[i].entries.toList();
//       entries.sort((a, b) => distanceBetween(a.value.latitude, a.value.longitude).compareTo(distanceBetween(b.value.latitude, b.value.longitude)));
//       Map<String, BankLocation> sortedMap = Map.fromEntries(entries);
//       newAddresses[i] = sortedMap;
//     }
//     return newAddresses;
//   }
// }