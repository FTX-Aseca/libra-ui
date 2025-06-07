const wdio = require('webdriverio');
const assert = require('assert');
const find = require('appium-flutter-finder');
const path = require('path');

const osSpecificOps = {
  platformName: 'Android',
  'appium:platformVersion': process.env.APPIUM_PLATFORM_VERSION || '15.0',
  'appium:deviceName': process.env.APPIUM_DEVICE_NAME || 'Pixel 9 Pro API 35',
  'appium:app': path.join(__dirname, '../..', 'build/app/outputs/apk/debug/app-debug.apk'),
};

const opts = {
  hostname: 'localhost',
  port: 4723,
  capabilities: {
    ...osSpecificOps,
    'appium:automationName': 'Flutter',
  }
};

(async () => {
  const driver = await wdio.remote(opts);

  assert.strictEqual(await driver.execute('flutter:checkHealth'), 'ok');
  
  const email = `testuser-${Date.now()}@example.com`;
  const password = 'password123';
  
  await driver.execute('flutter:waitFor', find.byValueKey('alternate_auth_button'));
  await driver.elementClick(find.byValueKey('alternate_auth_button'));

  await driver.execute('flutter:waitFor', find.byValueKey('email'));
  await driver.elementSendKeys(find.byValueKey('email'), email);
  await driver.elementSendKeys(find.byValueKey('password'), password);
  await driver.elementSendKeys(find.byValueKey('confirmPassword'), password);
  await driver.elementClick(find.byValueKey('sign_up_button'));

  await driver.execute('flutter:waitFor', find.byValueKey('home_screen_key'));

  console.log('Test passed!');

  await driver.deleteSession();
})(); 