from time import sleep


class PostsActionsMobileImpl:
    def __init__(self, driver_wrapper, xpath_builder):
        self.driver_wrapper = driver_wrapper
        self.xpath_builder = xpath_builder

    def is_button_visible(self, button_text):
        return self.driver_wrapper.is_visible(self.xpath_builder.text(button_text))

    def tap_button(self, button_text):
        self.driver_wrapper.wait_for_visible(
            self.xpath_builder.text(button_text)
        ).click()

    def wait_for_loading_finish(self):
        sleep(0.5)
        self.driver_wrapper.wait_for_disappear(self.xpath_builder.loading())
