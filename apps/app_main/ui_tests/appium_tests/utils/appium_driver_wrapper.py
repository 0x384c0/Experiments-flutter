# coding: utf-8
from time import sleep, time

from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.keys import Keys

WAIT_SECONDS_SHORT = 1
WAIT_SECONDS = 30


class AppiumDriverWrapper:
    def __init__(self, driver):
        self.driver = driver

    def wait_for_visible(self, xpath):
        wait = WebDriverWait(self.driver, WAIT_SECONDS)
        element = wait.until(EC.visibility_of_element_located((AppiumBy.XPATH, xpath)))
        return element

    def wait_for_disappear(self, xpath):
        wait = WebDriverWait(self.driver, WAIT_SECONDS)
        wait.until(EC.invisibility_of_element_located((AppiumBy.XPATH, xpath)))

    def scroll_for_visible(self, xpath):
        start_time = time()
        end_time = start_time + WAIT_SECONDS

        while time() < end_time:
            try:
                wait = WebDriverWait(self.driver, WAIT_SECONDS_SHORT)
                element = wait.until(EC.visibility_of_element_located((AppiumBy.XPATH, xpath)))
                if element.is_displayed():
                    return element
            except:
                size = self.driver.get_window_size()
                start_x = size['width'] // 2
                start_y = size['height'] // 2
                end_y = size['height'] // 4
                self.driver.swipe(start_x, start_y, start_x, end_y, 2 * 1000)
                sleep(1)

        raise TimeoutError(f"Element {xpath} not found within {WAIT_SECONDS} seconds")

    def is_visible(self, xpath):
        try:
            wait = WebDriverWait(self.driver, WAIT_SECONDS_SHORT)
            wait.until(EC.visibility_of_element_located((AppiumBy.XPATH, xpath)))
        except:
            return False
        return True

    def fill_field(self, xpath, value):
        self.wait_for_visible(xpath).click()
        sleep(0.6)
        self.wait_for_visible(xpath).send_keys(value)
        sleep(0.1)

    def clear_field(self, xpath, value):
        self.wait_for_visible(xpath).click()
        sleep(0.6)
        for iter in range(value):
            sleep(0.05)
            self.wait_for_visible(xpath).send_keys(Keys.BACKSPACE)
