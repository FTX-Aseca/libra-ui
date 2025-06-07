import { browser } from '@wdio/globals';
import { find } from '../utils/flutter_finder';
import { ElementReference } from '@wdio/protocols';

class HomePage {
    private getElementId(elementRef: ElementReference): string {
        return elementRef['element-6066-11e4-a52e-4f735466cecf'] || (elementRef as any).ELEMENT;
    }

    async isHomeScreenDisplayed(): Promise<boolean> {
        const homeIndicatorRef = await browser.execute('flutter:findElement', find.byValueKey('home_screen_key')) as ElementReference;
        return browser.isElementDisplayed(this.getElementId(homeIndicatorRef));
    }

    async logout() {
        const logoutButtonRef = await browser.execute('flutter:findElement', find.byValueKey('logout_button')) as ElementReference;
        await browser.elementClick(this.getElementId(logoutButtonRef));
    }
}

export default new HomePage(); 