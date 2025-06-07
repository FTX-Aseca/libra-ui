import { browser } from '@wdio/globals';
import { find } from '../utils/flutter_finder';
import { ElementReference } from '@wdio/protocols';

class SignUpPage {
    private getElementId(elementRef: ElementReference): string {
        return elementRef['element-6066-11e4-a52e-4f735466cecf'] || (elementRef as any).ELEMENT;
    }

    async signup(email: string, password: string) {
        const emailFieldRef = await browser.execute('flutter:findElement', find.byValueKey('email')) as ElementReference;
        await browser.elementSendKeys(this.getElementId(emailFieldRef), email);

        const passwordFieldRef = await browser.execute('flutter:findElement', find.byValueKey('password')) as ElementReference;
        await browser.elementSendKeys(this.getElementId(passwordFieldRef), password);

        const confirmFieldRef = await browser.execute('flutter:findElement', find.byValueKey('confirmPassword')) as ElementReference;
        await browser.elementSendKeys(this.getElementId(confirmFieldRef), password);

        const signupButtonRef = await browser.execute('flutter:findElement', find.byValueKey('sign_up_button')) as ElementReference;
        await browser.elementClick(this.getElementId(signupButtonRef));
    }
}

export default new SignUpPage(); 