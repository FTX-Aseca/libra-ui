// test/e2e/specs/login.e2e.ts
import { driver } from '@wdio/globals'
import LoginPage from '../pageobjects/login.page';
import SignUpPage from '../pageobjects/signup.page';
import HomePage from '../pageobjects/home.page';

describe('Authentication Flow', () => {

    // beforeEach(async () => {
    //     await driver.executeScript('flutter:reset', []);
    // });

    it('should allow a user to sign up, log out, and log back in', async () => {
        // Create unique credentials for the new user
        const email = `testuser-${Date.now()}@example.com`;
        const password = 'password123';

        // Navigate to the signup page
        await LoginPage.navigateToSignUp();

        // Sign up and verify we are on the home screen
        await SignUpPage.signup(email, password);
        await expect(await HomePage.isHomeScreenDisplayed()).toBe(true);

        // Log out and verify we are back on the login screen
        await HomePage.logout();
        await expect(await LoginPage.isEmailFieldDisplayed()).toBe(true);

        // Log in with the new credentials and verify we are on the home screen again
        await LoginPage.login(email, password);
        await expect(await HomePage.isHomeScreenDisplayed()).toBe(true);
    });

    it('should show an error with invalid credentials', async () => {
        await LoginPage.login('wronguser@example.com', 'wrongpassword');

        // Assert error message is shown
        await expect(await LoginPage.isSnackbarErrorDisplayed()).toBe(true);
    });
}); 