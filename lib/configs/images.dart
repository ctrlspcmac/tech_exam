import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const bottomImage = _Image('bottom_image.png');
  static const profilePlaceHolderImage = _Image('profile_holder.png');
  static const loginBottomImage = _Image('login_image_bottom.png');
  static const loginAccentImage = _Image('accent_login.png');
  static const icWallet = _Image('account_balance_wallet.png');
  static const viewList = _Image('view_list.png');
  static const usernameImg = _Image('account_circle.png');

  static Future precacheAssets(BuildContext context) async {
    await precacheImage(bottomImage, context);
    await precacheImage(profilePlaceHolderImage, context);
    await precacheImage(icWallet, context);
    await precacheImage(loginAccentImage, context);
    await precacheImage(viewList, context);
    await precacheImage(usernameImg, context);
  }
}
