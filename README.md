# An Example of web testing with Robot Framework and SeleniumLibrary
Robot Framework is a generic open source test automation framework and SeleniumLibrary is one of the many test libraries that can be used with it. In addition to showing how they can be used together for web testing, this demo introduces the basic Robot Framework test data syntax, how tests are executed, and how logs and reports look like.

Some highlight from this example:
- Can run on latest Chrome, Firefox, IE, Chrome headless, Firefox headless
- Include all kind of web elements and actions: buttons, input fields, checkboxes, menus, frames, windows, alerts, radio buttons, dropdown lists, ,javascript,...
- Use CSS selectors and XPath as locators
- Capture screen-shot on failure
- Python custom lib to assist the test (get text from gmail/yahoo)

**Test Cases**

vsee.robot

    A simple test suite for simple work flow on vsee.com such as sign up an account or reset password for an existing account
the_internet.robot

    A test suite for interacting with most of web elements on https://the-internet.herokuapp.com
**Generated Results**
After running tests you will get report and log in HTML format. Example files are also visible online in case you are not interested in running the demo yourself:

- report.html
- log.html

**Run Test**