class XPathBuilder:
    def text(self, button_text):
        raise NotImplementedError()

    def loading(self):
        raise NotImplementedError()


class AndroidXPathBuilder(XPathBuilder):
    def text(self, button_text):
        return f'//*[contains(@content-desc, "{button_text}")]'

    def loading(self):
        return  '//XCUIElementTypeStaticText[@name="loading"]'


class IOSXPathBuilder(XPathBuilder):
    def text(self, button_text):
        return f'//*[contains(@label, "{button_text}")]'

    def loading(self):
        return '//android.widget.ProgressBar'
