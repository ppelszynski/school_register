RSpec::Matchers.define :show_field_error do |expected|
  match do |actual|
    expect(actual).to have_css('.invalid-feedback', text: expected)
  end
end
