import pytest

from appium import webdriver
from appium.options.ios import XCUITestOptions
from appium.webdriver.appium_service import AppiumService

APPIUM_PORT = 4723
APPIUM_HOST = '127.0.0.1'


@pytest.fixture(scope='session')
def appium_service():
    service = AppiumService()
    service.start(
        args=['--address', APPIUM_HOST, '-p', str(APPIUM_PORT)],
        timeout_ms=20000,
    )
    yield service
    service.stop()


def create_ios_driver(custom_opts=None):
    options = XCUITestOptions()
    options.platformVersion = '16.4'
    if custom_opts is not None:
        options.load_capabilities(custom_opts)
    return webdriver.Remote(f'http://{APPIUM_HOST}:{APPIUM_PORT}', options=options)


@pytest.fixture(scope='session')
def ios_driver():
    driver = create_ios_driver({
        'appium:app': '../build/ios/iphonesimulator/Runner.app',
        'appium:fullReset': True,
    })
    yield driver
    driver.quit()
