import path from 'path';
import dotenv from 'dotenv';

dotenv.config({ path: path.resolve(__dirname, '../../.env') });

export const config: any = { // Changed type to any for diagnostics
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
          'appium:automationName': 'UiAutomator2',
          'appium:autoGrantPermissions': true,
          'appium:newCommandTimeout': parseInt(process.env.APPIUM_NEW_COMMAND_TIMEOUT || '300', 10),
          'appium:noReset': false,
        }
    ],
    // Ensure you have at least one capability uncommented and correctly configured to run tests.

    logLevel: 'info', // Can be 'trace', 'debug', 'info', 'warn', 'error', 'silent'
    bail: 0, // 0 - don't bail, 1 - bail after 1st failure
    waitforTimeout: 15000, // Default timeout for all waitFor commands
    connectionRetryTimeout: 120000,
    connectionRetryCount: 3,
    services: [['appium', {
        // Appium server arguments
        args: {
            address: process.env.APPIUM_HOST || 'localhost',
            port: parseInt(process.env.APPIUM_PORT || '4723', 10),
            // relaxedSecurity: true, // Enable if needed for certain commands
            // log: './appium.log' // Path to store Appium server logs
        },
        // command : 'appium' // Default is fine if Appium is in PATH
    }]],
    framework: 'mocha',
    reporters: ['spec'],
    mochaOpts: {
        ui: 'bdd',
        timeout: 90000 // Test case timeout (increased for E2E)
    },
    // Hooks
    // beforeSession: function (config, capabilities, specs) { },
    // before: async function (capabilities, specs) { },
    // afterTest: async function(test, context, { error, result, duration, passed, retries }) { },
    // afterSession: function (config, capabilities, specs) { },
}; 