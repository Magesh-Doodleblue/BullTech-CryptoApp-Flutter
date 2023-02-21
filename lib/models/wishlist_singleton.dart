import 'package:shared_preferences/shared_preferences.dart';

class Wishlist {
  static final Wishlist instance = Wishlist._internal();
  final List<String> _coins = [];

  factory Wishlist() {
    return instance;
  }

  Wishlist._internal() {
    _initPreferences();
    _loadFromPrefs();
  }

  void addCoin(String coin) {
    if (!_coins.contains(coin)) {
      _coins.add(coin);
      _saveToPrefs();
    }
  }

  void removeCoin(String coin) {
    _coins.remove(coin);
    _saveToPrefs();
  }

  List<String> getCoins() {
    return _coins;
  }

  Future<void> _initPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // do nothing, just wait for the preferences to be initialized
  }

  Future<void> _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> coins = prefs.getStringList('wishlist') ?? [];
    _coins.addAll(coins);
  }

  Future<void> _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('wishlist', _coins);
  }

  void clearCoins() {
    _coins.clear();
    _saveToPrefs();
  }
}
