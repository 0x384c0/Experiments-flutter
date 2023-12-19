from pytest_bdd import scenarios, given, when, then

scenarios('../features/authorization.feature')

from .authorization_actions import AuthorizationActions


@given('User sees authorization screen')
def user_sees_authorization_screen(appium_service, ios_driver):
    AuthorizationActions.authorization_screen(ios_driver)


@when('User enters email')
def user_enters_email(appium_service, ios_driver):
    AuthorizationActions.enter_text_to_field(ios_driver, "email", "email@example.com")


@when('User enters password')
def user_enters_password(appium_service, ios_driver):
    AuthorizationActions.enter_text_to_field(ios_driver, "password", "password")


@when('User taps Authorize')
def user_taps_authorize(appium_service, ios_driver):
    AuthorizationActions.authorize(ios_driver)


@then('User see Home screen')
def user_see_home_screen(appium_service, ios_driver):
    AuthorizationActions.home(ios_driver)


@given('User see Home screen')
def given_user_see_home_screen(appium_service, ios_driver):
    user_see_home_screen(appium_service, ios_driver)


@when('User opens side menu')
def user_enters_password(appium_service, ios_driver):
    AuthorizationActions.open_side_menu(ios_driver)


@when('User taps Logout')
def user_taps_authorize(appium_service, ios_driver):
    AuthorizationActions.logout(ios_driver)


@then('User sees authorization screen')
def then_user_sees_authorization_screen(appium_service, ios_driver):
    user_sees_authorization_screen(appium_service, ios_driver)
