import { browser } from '@wdio/globals';
import { find } from '../utils/flutter_finder';
import { ElementReference } from '@wdio/protocols';

class LoginPage {
    private getElementId(elementRef: ElementReference): string {
        return elementRef['element-6066-11e4-a52e-4f735466cecf'] || (elementRef as any).ELEMENT;
    }

    async emailField() {
        const elementId = await browser.findElement('-flutter', find.byValueKey('email'));
        return $(`id=${elementId}`);
    }

    async passwordField() {
        const elementId = await browser.findElement('-flutter', find.byValueKey('password'));
        return $(`id=${elementId}`);
    }

    async loginButton() {
        const elementId = await browser.findElement('-flutter', find.byValueKey('login_button'));
        return $(`id=${elementId}`);
    }

    async snackbarError() {
        const elementId = await browser.findElement('-flutter', find.byValueKey('snackbar_error'));
        return $(`id=${elementId}`);
    }

    async navigateToSignUpButton() {
        const elementId = await browser.findElement('-flutter', find.byValueKey('alternate_auth_button'));
        return $(`id=${elementId}`);
    }

    async login(email: string, password: string) {
        const emailFieldRef = await browser.execute('flutter:findElement', find.byValueKey('email')) as ElementReference;
        await browser.elementSendKeys(this.getElementId(emailFieldRef), email);

        const passwordFieldRef = await browser.execute('flutter:findElement', find.byValueKey('password')) as ElementReference;
        await browser.elementSendKeys(this.getElementId(passwordFieldRef), password);

        const loginButtonRef = await browser.execute('flutter:findElement', find.byValueKey('login_button')) as ElementReference;
        await browser.elementClick(this.getElementId(loginButtonRef));
    }

    async navigateToSignUp() {
        const navButtonRef = await browser.execute('flutter:findElement', find.byValueKey('alternate_auth_button')) as ElementReference;
        await browser.elementClick(this.getElementId(navButtonRef));
    }

    async isSnackbarErrorDisplayed(): Promise<boolean> {
        const errorSnackbarRef = await browser.execute('flutter:findElement', find.byValueKey('snackbar_error')) as ElementReference;
        return browser.isElementDisplayed(this.getElementId(errorSnackbarRef));
    }

    async isEmailFieldDisplayed(): Promise<boolean> {
        const emailFieldRef = await browser.execute('flutter:findElement', find.byValueKey('email')) as ElementReference;
        return browser.isElementDisplayed(this.getElementId(emailFieldRef));
    }
}

export default new LoginPage(); 