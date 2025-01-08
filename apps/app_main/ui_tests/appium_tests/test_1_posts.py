from pytest_bdd import scenarios, given, when, then, parsers

# Load the scenarios from the feature file
scenarios('../features/posts.feature')


@given(parsers.parse('User sees "{button_text}" button'))
def user_sees_button(appium_service, posts_actions, button_text):
    """
    Check if a button with the given text is visible.
    """
    assert posts_actions.is_button_visible(button_text), f"Button '{button_text}' not visible."


@when(parsers.parse('User taps "{button_text}" button'))
def user_taps_button(appium_service, posts_actions, button_text):
    """
    Tap a button with the given text.
    """
    posts_actions.tap_button(button_text)


@then('User sees data is loaded')
def user_sees_data_loaded(appium_service, posts_actions):
    """
    Verify that the data has been loaded successfully.
    """
    posts_actions.wait_for_loading_finish()
