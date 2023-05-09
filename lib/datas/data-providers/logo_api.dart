class LogoApi {
  static String assetLogo(String symbol, {int size = 2}) =>
      "https://assets.coincap.io/assets/icons/$symbol@${size}x.png";
}
