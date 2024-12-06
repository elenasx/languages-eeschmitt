# regex_spec.rb
RSpec.describe 'Regular Expression for decimal literal' do
  let(:nonzero_decimal_digit) { /[1-9]/ }
  let(:decimal_digit) { /[0-9]/ }
  let(:octal_digit) {  /[0-7]/ }
  let(:hex_digit) {  /[0-9]|[A-F]|[a-f]/ }
  let(:binary_digit) {  /[0-1]/ }
  let(:decimal) { /#{nonzero_decimal_digit}('?#{decimal_digit}+)*/ }
  # Add octal, hex, and binary
  let(:octal) { /0#{octal_digit}+/ } # base 8
  let(:hex) { /0[xX]#{hex_digit}+/ } # base 16, letters a through f
  let(:binary) { /0[bB]#{binary_digit}+/ } # base 2
  let(:size) { /[uU]?[lL]{0,2}/ }

  let(:pattern) { /^-?(#{decimal}|#{octal}|#{hex}|#{binary})#{size}$/ }

  let(:should_pass) { [ "1", "-33'000", "4525235", "10'080", "123'456'789", "1ul", "1u", "1ll", "0b10011", "0x5f", "023", "9'999" ] }
  let(:should_fail) { ["'1'", "1'''3", "afed", "+33", "0", "ul", "lll", "3lll", "3uuull", "0b832", "0xH1", "088", "3'''234" ] }

  describe 'should pass' do
    it 'matches all expected strings' do
      should_pass.each do |str|
        expect(str).to match(pattern)
      end
    end
  end

  describe 'should fail' do
    it 'does not match any of the strings' do
      should_fail.each do |str|
        expect(str).not_to match(pattern)
      end
    end
  end
end