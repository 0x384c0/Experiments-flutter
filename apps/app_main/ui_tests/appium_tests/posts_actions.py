from .common_functions import (
    wait_for_visible,
    is_visible,
    wait_for_disappear,
)
from time import sleep

class PostsActions():

    def is_button_visible(self, ios_driver, button_text):
        return is_visible(ios_driver, f'//*[contains(@label, "{button_text}")]')

    def tap_button(self, ios_driver, button_text):
        wait_for_visible(ios_driver, f'//*[contains(@label, "{button_text}")]').click()

    def wait_for_loading_finish(self, ios_driver):
        sleep(0.5)
        wait_for_disappear(ios_driver, '//XCUIElementTypeStaticText[@name="loading"]')
