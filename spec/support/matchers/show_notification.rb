RSpec::Matchers.define :show_notification do |expected|
  match do |actual|
    expect(actual).to have_css('.notification', text: expected)
  end
end
