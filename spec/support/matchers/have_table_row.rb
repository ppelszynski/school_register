RSpec::Matchers.define :have_table_row do |expected|
  match do |actual|
    expect(actual).to have_css('tr', text: expected)
  end
end
