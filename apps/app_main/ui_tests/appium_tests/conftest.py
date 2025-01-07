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
    options = XCUITestOptions() # https://appium.github.io/appium-xcuitest-driver/4.24/capabilities/
    options.platformVersion = '18.1' # TODO: automatically find ios simulator
    options.app = app_path
    options.load_capabilities({
        'appium:fullReset': True,
    })
    return webdriver.Remote(f'http://{APPIUM_HOST}:{APPIUM_PORT}', options=options)

def get_android_emulator():
    result = subprocess.run(['emulator', '-list-avds'], capture_output=True, text=True)
    emulators = result.stdout.splitlines()
    if emulators:
        return emulators[0]  # Select the first available emulator or implement further selection logic
    raise Exception("No available Android emulator found")

def create_android_driver(app_path):
    options = UiAutomator2Options() # https://github.com/appium/appium-uiautomator2-driver
    options.avd = get_android_emulator()
    options.avdReadyTimeout = 5 * 60 * 1000
    options.app = app_path
    options.load_capabilities({
        'appium:fullReset': True,
    })
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