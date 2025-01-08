import pytest

from .appium_driver_wrapper import AppiumDriverWrapper
from .xpath_builder import AndroidXPathBuilder, IOSXPathBuilder


@pytest.fixture(scope='session')
def driver_wrapper(driver):
    return AppiumDriverWrapper(driver)


@pytest.fixture(scope='session')
def xpath_builder(driver):
    platform_name = driver.capabilities.get("platformName", "").lower()
    if platform_name == "android":
        return AndroidXPathBuilder()
    elif platform_name == "ios":
        return IOSXPathBuilder()
    else:
        raise ValueError(f"Unsupported platform: {platform_name}")
