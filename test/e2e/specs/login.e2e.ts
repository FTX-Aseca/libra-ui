// test/e2e/specs/login.e2e.ts
import { driver } from '@wdio/globals'
import LoginPage from '../pageobjects/login.page';
import SignUpPage from '../pageobjects/signup.page';
import HomePage from '../pageobjects/home.page';

describe('Authentication Flow', () => {

    beforeEach(async () => {
        // The `driver.reset()` command is a good way to reset the app to its initial state.
        // It's equivalent to closing and reopening the app.
        // Note: `noReset` capability in your wdio.conf.ts should be `false` for this to work as expected.
        await (driver as any).reset();
    });

    it('should allow a user to sign up, log out, and log back in', async () => {
        // Create unique credentials for the new user
        const email = `testuser-${Date.now()}@example.com`;
        const password = 'password123';

        // Navigate to the signup page
        await LoginPage.navigateToSignUp();

        // Sign up and verify we are on the home screen
        await SignUpPage.signup(email, password);
        await expect(HomePage.homeScreenIndicator).toBeDisplayed();

        // Log out and verify we are back on the login screen
        await HomePage.logout();
        await expect(LoginPage.emailField).toBeDisplayed();

        // Log in with the new credentials and verify we are on the home screen again
        await LoginPage.login(email, password);
        await expect(HomePage.homeScreenIndicator).toBeDisplayed();
    });

    it('should show an error with invalid credentials', async () => {
        await LoginPage.login('wronguser@example.com', 'wrongpassword');

        // Assert error message is shown
        await expect(LoginPage.snackbarError).toBeDisplayed();
    });
}); 