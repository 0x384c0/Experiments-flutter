import pytest

from .posts_actions_mobile_impl import PostsActionsMobileImpl


@pytest.fixture(scope='session')
def posts_actions(driver_wrapper, xpath_builder):
    return PostsActionsMobileImpl(driver_wrapper, xpath_builder)
