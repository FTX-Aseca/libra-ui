const path = require('path');

exports.config = { // Changed type to any for diagnostics
    runner: 'local',
    specs: [
        './specs/**/*.e2e.ts' // Path to your test files
    ],
    exclude: [
        // 'path/to/excluded/files'
    ],
    maxInstances: 1, // Adjust for parallel runs later
    capabilities: [
        {
          platformName: process.env.APPIUM_PLATFORM_NAME || 'Android',
          'appium:platformVersion': process.env.APPIUM_PLATFORM_VERSION || '15.0',
          'appium:deviceName': process.env.APPIUM_DEVICE_NAME || 'Pixel 9 Pro API 35',
          'appium:app': path.join(__dirname, '../..', 'build/app/outputs/apk/debug/app-debug.apk'),
          'appium:automationName': 'Flutter',
          'appium:autoGrantPermissions': true,
          'appium:newCommandTimeout': parseInt(process.env.APPIUM_NEW_COMMAND_TIMEOUT || '300', 10),
          'appium:flutterAttachTimeout': 120000,
          'appium:fullReset': true,
          'appium:noReset': false,
        }
    ],
    // Ensure you have at least one capability uncommented and correctly configured to run tests.

    logLevel: 'info',
    bail: 0,
    waitforTimeout: 15000,
    connectionRetryTimeout: 120000,
    connectionRetryCount: 3,
    services: [['appium', {
        env: {
            ANDROID_HOME: process.env.ANDROID_HOME || 'C:\\Users\\tomas\\AppData\\Local\\Android\\sdk',
            IS_TEST: 'true'
        }
    }]],
    framework: 'mocha',
    reporters: ['spec'],
    mochaOpts: {
        ui: 'bdd',
        timeout: 90000
    },
}; 