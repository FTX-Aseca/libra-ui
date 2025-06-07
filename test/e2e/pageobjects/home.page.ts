import { $ } from '@wdio/globals'

class HomePage {
    get homeScreenIndicator() {
        return $("~home_screen_key");
    }

    get logoutButton() {
        return $('~logout_button');
    }

    async logout() {
        await this.logoutButton.click();
    }
}

export default new HomePage(); 