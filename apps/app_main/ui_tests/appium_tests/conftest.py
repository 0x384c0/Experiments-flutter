import pytest
import subprocess
import os
from appium import webdriver
from appium.options.ios import XCUITestOptions
from appium.options.android import UiAutomator2Options
from appium.webdriver.appium_service import AppiumService

APPIUM_PORT = 4723
APPIUM_HOST = '127.0.0.1'

def pytest_addoption(parser):
    parser.addoption("--app-path", action="store", required=True, help="Path to the app file (.app for iOS, .apk for Android)")

@pytest.fixture(scope='session', autouse=True)
def app_path(request):
    return request.config.getoption("--app-path")

@pytest.fixture(scope='session')
def appium_service():
    service = AppiumService()
    service.start(
        args=['--address', APPIUM_HOST, '-p', str(APPIUM_PORT)],
        timeout_ms=20000,
    )
    yield service
    service.stop()

def create_ios_driver(app_path):
    options = XCUITestOptions()
    options.platformVersion = '18.1'
    options.app = app_path
    options.load_capabilities({
        'appium:fullReset': True, # https://appium.github.io/appium-xcuitest-driver/4.24/capabilities/
    })
    return webdriver.Remote(f'http://{APPIUM_HOST}:{APPIUM_PORT}', options=options)

def create_android_driver(app_path):
    options = UiAutomator2Options()
    options.app = app_path
    return webdriver.Remote(f'http://{APPIUM_HOST}:{APPIUM_PORT}', options=options)

@pytest.fixture(scope='session')
def driver(request, app_path):
    if not os.path.exists(app_path):
        raise FileNotFoundError(f"App path {app_path} does not exist")

    if app_path.endswith('.app'):
        return create_ios_driver(app_path)
    elif app_path.endswith('.apk'):
        return create_android_driver(app_path)
    else:
        raise Exception(f"Unsupported app: {app_path}")