# coding: utf-8
from time import sleep

from selenium.common.exceptions import (
    NoSuchElementException,
    WebDriverException,
)
from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.keys import Keys

WAIT_SECONDS = 30
IMPLICITLY_WAIT_SECONDS = 20
attempt_count = 30


def wait_element_and_click(driver, xpath):
    wait = WebDriverWait(driver, WAIT_SECONDS)
    try:
        element = wait.until(EC.element_to_be_clickable((AppiumBy.XPATH, xpath)))
        element.click()
    except WebDriverException:
        print("Cannot find element {}".format(xpath))


def wait_find_element(driver, xpath):
    found = False
    for _ in range(attempt_count):
        try:
            find_element_by_xpath(driver, xpath)
            found = True
            break
        except WebDriverException:
            print("Failed to find, will try again after 1 second {}".format(xpath))
            sleep(1)

    if not found:
        print("Failed to find after {} tries on {}".format(attempt_count, xpath))


def wait_for_visible(driver, xpath):
    wait = WebDriverWait(driver, WAIT_SECONDS)
    element = wait.until(EC.visibility_of_element_located((AppiumBy.XPATH, xpath)))
    return element


def refresh_page(driver, page):
    driver.refresh(page)


def wait_time(driver, time):
    driver.implicitly_wait(time)


def fill_field_by_accessibility_id(driver, accessibility_id, value):
    field = find_element_by_accessibility_id(driver, accessibility_id)
    field.send_keys(value)


def fill_field(driver, xpath, value):
    field = wait_for_visible(driver, xpath)
    field.send_keys(value)


def fill_and_select(driver, xpath, value, element):
    field = wait_for_visible(driver, xpath)
    field.send_keys(value)
    select_from_list(driver, element)


def click_button(driver, xpath):
    button = find_element_by_xpath(driver, xpath)
    button.click()


def click_button_id(driver, accessibility_id):
    button = find_element_by_accessibility_id(driver, accessibility_id)
    button.click()


def select_from_list(driver, xpath):
    item = find_element_by_xpath(driver, xpath)
    item.click()


def find_element_by_id(driver, id):
    return driver.find_element(AppiumBy.ID, id)


def find_element_by_class_name(driver, name):
    return driver.find_element(AppiumBy.CLASS_NAME, name)


def find_element_by_xpath(driver, xpath):
    return driver.find_element(AppiumBy.XPATH ,xpath)


def find_element_by_accessibility_id(driver, accessibility_id):
    return driver.find_element(AppiumBy.ACCESSIBILITY_ID, accessibility_id)


def check_absence_element(driver, xpath):
    driver.implicitly_wait(5)
    count = len(driver.find_elements_by_xpath(xpath))
    driver.implicitly_wait(IMPLICITLY_WAIT_SECONDS)
    if count == 0:
        return True


def back(driver):
    return driver.back()


def clear_and_fill_field(driver, field_xpath, value):
    find_element_by_xpath(driver, field_xpath).clear()
    fill_field(driver, field_xpath, value)


def clear_field(driver, xpath):
    elelement = find_element_by_xpath(driver, xpath)
    for i in range(4):
        elelement.send_keys(Keys.BACK_SPACE)


def check_exists_by_id(driver, id):
    """

    Returns:
        True - if element exist
        False - if element not exist
    """
    try:
        find_element_by_id(driver, id)
    except NoSuchElementException:
        return False
    return True


def check_exists_by_xpath(driver, xpath):
    """

    Returns:
        True - if element exist
        False - if element not exist
    """
    try:
        find_element_by_xpath(driver, xpath)
    except NoSuchElementException:
        return False
    return True
