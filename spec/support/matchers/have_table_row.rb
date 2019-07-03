RSpec::Matchers.define :have_table_row do |expected|
  if expected.is_a?(Array)
    expected.each do |exp|
      match do |actual|
        expect(actual).to have_css('tr', text: exp)
      end
    end
  else
    match do |actual|
      expect(actual).to have_css('tr', text: expected)
    end
  end
end
