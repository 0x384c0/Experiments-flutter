class XPathBuilder:
    def text(self, button_text):
        raise NotImplementedError()

    def loading(self):
        raise NotImplementedError()

    def button(self, text):
        raise NotImplementedError()

    def input(self, hint):
        raise NotImplementedError()

    def back(self):
        raise NotImplementedError()

    def nav_menu(self):
        raise NotImplementedError()


class AndroidXPathBuilder(XPathBuilder):
    def text(self, button_text):
        return f'//*[contains(@content-desc, "{button_text}")]'

    def loading(self):
        return '//XCUIElementTypeStaticText[@name="loading"]'

    def button(self, text):
        return f'//android.widget.Button[@content-desc="{text}"]'

    def input(self, hint):
        return f'//android.widget.EditText[@content-desc="{hint}"]'

    def back(self):
        return f'//android.widget.Button[@content-desc="Back"]'

    def nav_menu(self):
        return f'//android.widget.Button[@content-desc="Open navigation menu"]'


class IOSXPathBuilder(XPathBuilder):
    def text(self, button_text):
        return f'//*[contains(@label, "{button_text}")]'

    def loading(self):
        return '//android.widget.ProgressBar'

    def button(self, text):
        return f'//XCUIElementTypeButton[@name="{text}"]'

    def input(self, hint):
        return f'//XCUIElementTypeTextField[@name="{hint}"]'

    def back(self):
        return f'//XCUIElementTypeButton[@name="Back"]'

    def nav_menu(self):
        return f'//XCUIElementTypeButton[@name="Open navigation menu"]'
