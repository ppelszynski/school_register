module CapybaraHelper
  def accept_alert
    page.driver.browser.switch_to.alert.accept
  end
end
