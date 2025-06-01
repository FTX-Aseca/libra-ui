// test/e2e/specs/login.e2e.ts
describe('Login Flow', () => {
    it('should login successfully with valid credentials', async () => {
        // Example: Wait for a known element on the initial screen if necessary
        // const appLoadedIndicator = await $('~app_loaded_indicator_semantic_label');
        // await appLoadedIndicator.waitForDisplayed({ timeout: 20000 });

        // Replace with actual semantic labels or keys from your Flutter app
        const emailField = await $('~email_textfield_label'); // Example accessibility ID
        await emailField.setValue('testuser@example.com');

        const passwordField = await $('~password_textfield_label');
        await passwordField.setValue('password123');

        const loginButton = await $('~login_button_label');
        await loginButton.click();

        // Assert successful login (e.g., presence of a dashboard element)
        const dashboardHeader = await $('~dashboard_header_label');
        await expect(dashboardHeader).toBeDisplayed();
        // await expect(dashboardHeader).toHaveText('Welcome!'); // Or other assertion
    });

    it('should show an error with invalid credentials', async () => {
        // Similar to above, but enter wrong credentials
        const emailField = await $('~email_textfield_label');
        await emailField.setValue('wronguser@example.com');

        const passwordField = await $('~password_textfield_label');
        await passwordField.setValue('wrongpassword');

        const loginButton = await $('~login_button_label');
        await loginButton.click();

        // Assert error message is shown
        const errorMessage = await $('~login_error_message_label');
        await expect(errorMessage).toBeDisplayed();
        // await expect(errorMessage).toHaveTextContaining('Invalid credentials');
    });
}); 