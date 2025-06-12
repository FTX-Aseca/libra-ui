# [1.1.0](https://github.com/FTX-Aseca/libra-ui/compare/v1.0.0...v1.1.0) (2025-06-12)


### Bug Fixes

* **appium:** Solve merge conflicts ([4d4ed2e](https://github.com/FTX-Aseca/libra-ui/commit/4d4ed2ee58f47dbdb444aa1d263be66a7d8a5cae))


### Features

* **config:** Set up Appium ([55ec4e6](https://github.com/FTX-Aseca/libra-ui/commit/55ec4e62e696da7c0cb54e5520eb4bf4d2ccd349))
* **debin:** Fix Debin ([361ccce](https://github.com/FTX-Aseca/libra-ui/commit/361ccce8d4a835828aba4ec4220258494a96c535))

# [2.0.0-dev](https://github.com/FTX-Aseca/libra-ui/compare/v1.0.0-dev.1...v1.0.0-dev.2) (2025-06-12)

### Bug Fixes

* **appium:** Solve merge conflicts ([4d4ed2e](https://github.com/FTX-Aseca/libra-ui/commit/4d4ed2ee58f47dbdb444aa1d263be66a7d8a5cae))
* **auth:** Fixed register method on AuthDatasourceImpl ([a43e3ff](https://github.com/FTX-Aseca/libra-ui/commit/a43e3fffd83d4076b30e3259a3a6fd4b60cd919c))
* **CD & Release:** Fixed APK and IPA fetching in Release and CD jobs ([d8b5f4e](https://github.com/FTX-Aseca/libra-ui/commit/d8b5f4e670a5cc8efe4310d6b043a11b2ab44a62))
* **CD:** Fixed CD workflow to run semantic release after Android APK and iOS IPA are built ([3aa29d1](https://github.com/FTX-Aseca/libra-ui/commit/3aa29d12f021959a7eb3022ba51c718ff3f2b9d4)), closes [#2](https://github.com/FTX-Aseca/libra-ui/issues/2)
* **CD:** Fixed IPA building flow ([e5374d5](https://github.com/FTX-Aseca/libra-ui/commit/e5374d5776a8b63602c6ddf59da57a569b41474c))
* **CD:** Fixes on CD workflow for IPA build and deploy ([87b8cae](https://github.com/FTX-Aseca/libra-ui/commit/87b8cae87f3285fa55a1013ccb2acb277f571369))
* **CD:** Merged release and CD workflows ([104628b](https://github.com/FTX-Aseca/libra-ui/commit/104628b2bdb9935883c6f4450cf663a24fa5b6ed))
* **CI/CD:** Added .env file on workflows ([bc52d56](https://github.com/FTX-Aseca/libra-ui/commit/bc52d564695fae577ad32642d0d108cef2c95736))
* **CI:** Added test directory and first test file ([05390c2](https://github.com/FTX-Aseca/libra-ui/commit/05390c22a5ee725d9a3436a103d8e78e499d3d30))
* **ci:** Fixed CI workflow Flutter Version ([0773cd6](https://github.com/FTX-Aseca/libra-ui/commit/0773cd65713a3893d740e4bd3b0fe6afc6d1b089))
* **format:** Fixed formatting issues ([1f30d28](https://github.com/FTX-Aseca/libra-ui/commit/1f30d28c59daca46a3a756140e97881ffb1bad3b))
* **format:** formatted files ([56dd2f5](https://github.com/FTX-Aseca/libra-ui/commit/56dd2f56370b2e071932d458621e8672f17c487f))
* **icon:** Fixed icon ([1d5d820](https://github.com/FTX-Aseca/libra-ui/commit/1d5d820209ac5d1ce227019008722b6a3fb36928))
* **router:** Delete unnecessary commet ([a06bc87](https://github.com/FTX-Aseca/libra-ui/commit/a06bc87fd92b75dae4a97ce530effd840c6b6fe1))
* **router:** Fixed routing issues ([d1e48c7](https://github.com/FTX-Aseca/libra-ui/commit/d1e48c73ba247246c52ca2698efad83e7d95265c))
* **transactions:** Updated response at createExternalTransfer ([0c724a1](https://github.com/FTX-Aseca/libra-ui/commit/0c724a1f2fdf56e7f81ea362dcea6381dfa11192))
* **UI:** Added several fixes ([dce9e64](https://github.com/FTX-Aseca/libra-ui/commit/dce9e649f588b9c5e4d31585fe6b82cdbc215858)), closes [#6](https://github.com/FTX-Aseca/libra-ui/issues/6)


### Code Refactoring

* **ui:** Refactored login and register screens ([5ed0570](https://github.com/FTX-Aseca/libra-ui/commit/5ed0570dc5c63a3ea2ba0afded99b0dc871edcb4))


### Features

* **config:** Set up Appium ([55ec4e6](https://github.com/FTX-Aseca/libra-ui/commit/55ec4e62e696da7c0cb54e5520eb4bf4d2ccd349))
* **debin:** Fix Debin ([361ccce](https://github.com/FTX-Aseca/libra-ui/commit/361ccce8d4a835828aba4ec4220258494a96c535))
* **balance:** Can now view current account balance in home screen. ([d0e5c1c](https://github.com/FTX-Aseca/libra-ui/commit/d0e5c1cf26771e5aab7ea1c03f65f5160ea10bfb))
* **CI:** Added .gitmessage and git hooks ([0254f45](https://github.com/FTX-Aseca/libra-ui/commit/0254f452d83f65a7271bac0ce7913bff00296ea5))
* **config:** Init project using clean architecture ([379e18d](https://github.com/FTX-Aseca/libra-ui/commit/379e18db3aba92f986b791c8a03a9d12141b5943))
* **icon:** Added custom icon ([28ed61e](https://github.com/FTX-Aseca/libra-ui/commit/28ed61ed6f9b0ae164fe463b3c90df469159680b))
* **integrations:** Can now perform and visualize debin and top up requests ([63b1672](https://github.com/FTX-Aseca/libra-ui/commit/63b167207e42dd88bd39ca0d89903fdce82ce69f))
* **login:** Implemented login providers and infrastructure classes ([4c01500](https://github.com/FTX-Aseca/libra-ui/commit/4c01500c51e2d22521ae4c41fcfdffdceaf577d5))
* **navigation:** Customized Navbar, added routes for settings and transfer ([eae94e2](https://github.com/FTX-Aseca/libra-ui/commit/eae94e2e3ce4947ace57cc14554f135ad591f152))
* **presentation:** Added home screen ([8158197](https://github.com/FTX-Aseca/libra-ui/commit/81581977794a55acf4948b14fa2d8bfe01fd8f46))
* **presentation:** Added home screen with hardcoded data ([0790b44](https://github.com/FTX-Aseca/libra-ui/commit/0790b44e7f40de65d98218cc709701253de972a4))
* **presentation:** Added settings screen ([4ac62e1](https://github.com/FTX-Aseca/libra-ui/commit/4ac62e107fac6ae98997c7afbc30fe8259e22e8f))
* **settings:** Implemented account details retrieval ([172058b](https://github.com/FTX-Aseca/libra-ui/commit/172058bf2ed75f9216c11d4a424cb48a60da7af5))
* **transaction:** Can now visualize transaction history ([89892fd](https://github.com/FTX-Aseca/libra-ui/commit/89892fd52eb60f541c058132166e69ae14635040))
* **transaction:** Improved date formatting, added swipe to refresh ([f0bac2e](https://github.com/FTX-Aseca/libra-ui/commit/f0bac2ec520bc67a35b97ebf3372dcbc0821b491))
* **transactions:** Added transaction history screen ([1c5c7bd](https://github.com/FTX-Aseca/libra-ui/commit/1c5c7bdc4abac9455451b0e2c83d8485f1b5f6c6))
* **transfer:** Added whole transfer flow, and required screens ([9e6fa62](https://github.com/FTX-Aseca/libra-ui/commit/9e6fa62b9dffed720c0d07f0e1939732a739b40a))


### BREAKING CHANGES

* **icon:** Added flutter_launcher_icons dependency
* **transaction:** Added intl package for date formatting
* **ui:** Fixes:
* **format:** none
Fixes: none
* **presentation:** none
Fixes: none
* **presentation:** Now project won't start if you don't have a .env file with an API_URL variable set at the root of your project
Fixes: none
* **CI:** now commit messages must keep the same format as the one set in `libra-wallet` (our API)
Fixes: none

# 1.0.0-dev.1 (2025-06-05)


### Bug Fixes

* **auth:** Fixed register method on AuthDatasourceImpl ([a43e3ff](https://github.com/FTX-Aseca/libra-ui/commit/a43e3fffd83d4076b30e3259a3a6fd4b60cd919c))
* **CD & Release:** Fixed APK and IPA fetching in Release and CD jobs ([d8b5f4e](https://github.com/FTX-Aseca/libra-ui/commit/d8b5f4e670a5cc8efe4310d6b043a11b2ab44a62))
* **CD:** Fixed CD workflow to run semantic release after Android APK and iOS IPA are built ([3aa29d1](https://github.com/FTX-Aseca/libra-ui/commit/3aa29d12f021959a7eb3022ba51c718ff3f2b9d4)), closes [#2](https://github.com/FTX-Aseca/libra-ui/issues/2)
* **CD:** Fixed IPA building flow ([e5374d5](https://github.com/FTX-Aseca/libra-ui/commit/e5374d5776a8b63602c6ddf59da57a569b41474c))
* **CD:** Fixes on CD workflow for IPA build and deploy ([87b8cae](https://github.com/FTX-Aseca/libra-ui/commit/87b8cae87f3285fa55a1013ccb2acb277f571369))
* **CD:** Merged release and CD workflows ([104628b](https://github.com/FTX-Aseca/libra-ui/commit/104628b2bdb9935883c6f4450cf663a24fa5b6ed))
* **CI/CD:** Added .env file on workflows ([bc52d56](https://github.com/FTX-Aseca/libra-ui/commit/bc52d564695fae577ad32642d0d108cef2c95736))
* **CI:** Added test directory and first test file ([05390c2](https://github.com/FTX-Aseca/libra-ui/commit/05390c22a5ee725d9a3436a103d8e78e499d3d30))
* **ci:** Fixed CI workflow Flutter Version ([0773cd6](https://github.com/FTX-Aseca/libra-ui/commit/0773cd65713a3893d740e4bd3b0fe6afc6d1b089))
* **format:** Fixed formatting issues ([1f30d28](https://github.com/FTX-Aseca/libra-ui/commit/1f30d28c59daca46a3a756140e97881ffb1bad3b))
* **format:** formatted files ([56dd2f5](https://github.com/FTX-Aseca/libra-ui/commit/56dd2f56370b2e071932d458621e8672f17c487f))
* **icon:** Fixed icon ([1d5d820](https://github.com/FTX-Aseca/libra-ui/commit/1d5d820209ac5d1ce227019008722b6a3fb36928))
* **router:** Delete unnecessary commet ([a06bc87](https://github.com/FTX-Aseca/libra-ui/commit/a06bc87fd92b75dae4a97ce530effd840c6b6fe1))
* **router:** Fixed routing issues ([d1e48c7](https://github.com/FTX-Aseca/libra-ui/commit/d1e48c73ba247246c52ca2698efad83e7d95265c))
* **transactions:** Updated response at createExternalTransfer ([0c724a1](https://github.com/FTX-Aseca/libra-ui/commit/0c724a1f2fdf56e7f81ea362dcea6381dfa11192))
* **UI:** Added several fixes ([dce9e64](https://github.com/FTX-Aseca/libra-ui/commit/dce9e649f588b9c5e4d31585fe6b82cdbc215858)), closes [#6](https://github.com/FTX-Aseca/libra-ui/issues/6)


### Code Refactoring

* **ui:** Refactored login and register screens ([5ed0570](https://github.com/FTX-Aseca/libra-ui/commit/5ed0570dc5c63a3ea2ba0afded99b0dc871edcb4))


### Features

* **balance:** Can now view current account balance in home screen. ([d0e5c1c](https://github.com/FTX-Aseca/libra-ui/commit/d0e5c1cf26771e5aab7ea1c03f65f5160ea10bfb))
* **CI:** Added .gitmessage and git hooks ([0254f45](https://github.com/FTX-Aseca/libra-ui/commit/0254f452d83f65a7271bac0ce7913bff00296ea5))
* **config:** Init project using clean architecture ([379e18d](https://github.com/FTX-Aseca/libra-ui/commit/379e18db3aba92f986b791c8a03a9d12141b5943))
* **icon:** Added custom icon ([28ed61e](https://github.com/FTX-Aseca/libra-ui/commit/28ed61ed6f9b0ae164fe463b3c90df469159680b))
* **integrations:** Can now perform and visualize debin and top up requests ([63b1672](https://github.com/FTX-Aseca/libra-ui/commit/63b167207e42dd88bd39ca0d89903fdce82ce69f))
* **login:** Implemented login providers and infrastructure classes ([4c01500](https://github.com/FTX-Aseca/libra-ui/commit/4c01500c51e2d22521ae4c41fcfdffdceaf577d5))
* **navigation:** Customized Navbar, added routes for settings and transfer ([eae94e2](https://github.com/FTX-Aseca/libra-ui/commit/eae94e2e3ce4947ace57cc14554f135ad591f152))
* **presentation:** Added home screen ([8158197](https://github.com/FTX-Aseca/libra-ui/commit/81581977794a55acf4948b14fa2d8bfe01fd8f46))
* **presentation:** Added home screen with hardcoded data ([0790b44](https://github.com/FTX-Aseca/libra-ui/commit/0790b44e7f40de65d98218cc709701253de972a4))
* **presentation:** Added settings screen ([4ac62e1](https://github.com/FTX-Aseca/libra-ui/commit/4ac62e107fac6ae98997c7afbc30fe8259e22e8f))
* **settings:** Implemented account details retrieval ([172058b](https://github.com/FTX-Aseca/libra-ui/commit/172058bf2ed75f9216c11d4a424cb48a60da7af5))
* **transaction:** Can now visualize transaction history ([89892fd](https://github.com/FTX-Aseca/libra-ui/commit/89892fd52eb60f541c058132166e69ae14635040))
* **transaction:** Improved date formatting, added swipe to refresh ([f0bac2e](https://github.com/FTX-Aseca/libra-ui/commit/f0bac2ec520bc67a35b97ebf3372dcbc0821b491))
* **transactions:** Added transaction history screen ([1c5c7bd](https://github.com/FTX-Aseca/libra-ui/commit/1c5c7bdc4abac9455451b0e2c83d8485f1b5f6c6))
* **transfer:** Added whole transfer flow, and required screens ([9e6fa62](https://github.com/FTX-Aseca/libra-ui/commit/9e6fa62b9dffed720c0d07f0e1939732a739b40a))


### BREAKING CHANGES

* **icon:** Added flutter_launcher_icons dependency
* **transaction:** Added intl package for date formatting
* **ui:** Fixes:
* **format:** none
Fixes: none
* **presentation:** none
Fixes: none
* **presentation:** Now project won't start if you don't have a .env file with an API_URL variable set at the root of your project
Fixes: none
* **CI:** now commit messages must keep the same format as the one set in `libra-wallet` (our API)
Fixes: none
