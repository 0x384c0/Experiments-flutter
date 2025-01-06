from pytest_bdd import scenarios, given, when, then, parsers
from .posts_actions import PostsActions

# Load the scenarios from the feature file
scenarios('../features/posts.feature')

# Reusable actions class
posts_actions = PostsActions()

@given(parsers.parse('User sees "{button_text}" button'))
def user_sees_button(appium_service, ios_driver, button_text):
    """
    Check if a button with the given text is visible.
    """
    assert posts_actions.is_button_visible(ios_driver, button_text), f"Button '{button_text}' not visible."

@when(parsers.parse('User taps "{button_text}" button'))
def user_taps_button(appium_service, ios_driver, button_text):
    """
    Tap a button with the given text.
    """
    posts_actions.tap_button(ios_driver, button_text)

@then('User sees data is loaded')
def user_sees_data_loaded(appium_service, ios_driver):
    """
    Verify that the data has been loaded successfully.
    """
    posts_actions.wait_for_loading_finish(ios_driver)