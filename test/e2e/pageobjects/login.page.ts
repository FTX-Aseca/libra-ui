import { $ } from '@wdio/globals'

class LoginPage {
    get emailField() {
        return $('~email_text_field');
    }

    get passwordField() {
        return $('~password_text_field');
    }

    get loginButton() {
        return $('~login_button');
    }

    get snackbarError() {
        return $('~snackbar_error');
    }

    get navigateToSignUpButton() {
        return $('~signup_navigation_button');
    }

    async login(email: string, password: string) {
        await this.emailField.setValue(email);
        await this.passwordField.setValue(password);
        await this.loginButton.click();
    }

    async navigateToSignUp() {
        await this.navigateToSignUpButton.click();
    }
}

export default new LoginPage(); 