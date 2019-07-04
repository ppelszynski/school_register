module CapybaraHelper
  def accept_alert
    page.driver.browser.switch_to.alert.accept
  end

  def visit_email_link(email)
    parts = email.raw.to_s.split('"')
    link = parts[1]
    link.sub!('localhost:3000', '')
    visit link
  end
end
