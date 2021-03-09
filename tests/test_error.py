"""Some tests for error interfaces
"""
import pytest

from majortomo import error


def test_timeout_is_catchable():
    with pytest.raises(TimeoutError):
        raise error.Timeout("The operation has timed out")
