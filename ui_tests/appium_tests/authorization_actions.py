from .common_functions import (
    wait_for_visible,
    fill_field,
)


class AuthorizationActions(object):

    @staticmethod
    def authorization_screen(driver):
        wait_for_visible(driver, '//*[contains(@label, "Autentification")]')

    @staticmethod
    def enter_text_to_field(driver, label, text):
        fill_field(driver, f'//XCUIElementTypeTextField[contains(@label, "{label}")]', text)

    @staticmethod
    def authorize(driver):
        wait_for_visible(driver, f'//*[contains(@label, "Autentificate")]').click()

    @staticmethod
    def home(driver):
        wait_for_visible(driver, f'//*[contains(@label, "Home")]').click()

    @staticmethod
    def open_side_menu(driver):
        wait_for_visible(driver, f'//*[contains(@label, "Menu")]').click()

    @staticmethod
    def logout(driver):
        wait_for_visible(driver, f'//*[contains(@label, "Logout")]').click()
