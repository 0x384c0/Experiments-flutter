# Run UI Tests
* `melos run ui_test:android`
* `melos run ui_test:ios`
* or see [scripts](scripts)

# Add new feature UI test seps
* Add feature to [features](features)
* Add actions to [appium_tests/actions](appium_tests/actions)
* Add fixture for actions in [actions_fixtures.py](appium_tests/actions/actions_fixtures.py)
* Add step definitions as `test_{number}_{feature_name}.py` to [appium_tests](appium_tests)

# View XPath for UI components
* Install [Appium Inspector](https://github.com/appium/appium-inspector)
* Add Android capability sets:
```
{
"appium:automationName": "uiautomator2",
"appium:platformName": "Android"
}
```
* Add ios capability sets
```
{
"appium:automationName": "iOS",
"appium:platformName": "XCUITest"
}
```
* install app on device/emulator with Appium Appium Inspector
  * it can be done by running UI tests and stopping them after app installed
* `sh apps/app_main/ui_tests/scripts/start_appium_server.sh`
* start session in Appium Inspector
