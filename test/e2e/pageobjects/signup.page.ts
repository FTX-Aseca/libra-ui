import { $ } from '@wdio/globals'

class SignUpPage {
    get emailField() {
        return $('~signup_email_field');
    }

    get passwordField() {
        return $('~signup_password_field');
    }

    get signUpButton() {
        return $('~signup_button');
    }

    async signup(email: string, password: string) {
        await this.emailField.setValue(email);
        await this.passwordField.setValue(password);
        await this.signUpButton.click();
    }
}

export default new SignUpPage(); 