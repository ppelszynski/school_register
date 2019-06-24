RSpec::Matchers.define :show_notification do |expected|
  match do |actual|
    expect(actual).to have_css('.alert', text: expected)
  end
end
