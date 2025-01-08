from time import sleep


class PostsActionsMobileImpl:
    def __init__(self, driver_wrapper):
        self.driver_wrapper = driver_wrapper

    def is_button_visible(self, button_text):
        # return driver_wrapper.is_visible( f'//*[contains(@label, "{button_text}")]')
        return self.driver_wrapper.is_visible(f'//*[contains(@content-desc, "{button_text}")]')

    def tap_button(self, button_text):
        # self.driver_wrapper.wait_for_visible( f'//*[contains(@label, "{button_text}")]').click()
        self.driver_wrapper.wait_for_visible(
            f'//*[contains(@content-desc, "{button_text}")]').click()

    def wait_for_loading_finish(self):
        sleep(0.5)
        self.driver_wrapper.wait_for_disappear('//XCUIElementTypeStaticText[@name="loading"]')
