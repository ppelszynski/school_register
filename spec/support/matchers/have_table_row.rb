RSpec::Matchers.define :have_table_row do |expected|
  if expected.is_a?(Array)
    expected.each do |row|
      match do |actual|
        expect(actual).to have_css('tr', text: row)
      end
    end
  else
    match do |actual|
      expect(actual).to have_css('tr', text: expected)
    end
  end
end
