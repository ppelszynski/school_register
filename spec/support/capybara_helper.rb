module CapybaraHelper
  def accept_dialog_box
    page.driver.browser.switch_to.alert.accept
  end

  def visit_email_link(email)
    parts = email.raw.to_s.split('"')
    link = parts[1]
    link.sub!('localhost:3000', '')
    visit link
  end

  def confirm_candidate
    User.with_role(:candidate).last.confirm
  end
end
