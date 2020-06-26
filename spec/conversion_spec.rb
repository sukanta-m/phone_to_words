require_relative '../lib/conversion.rb'

describe Conversion do
  let(:phone1) { '6686787825' }
  let(:result1) { 'MOTORTRUCK' }

  let(:phone2) { '! 2255.63' }
  let(:result2) { '! CALL-ME' }

  context 'Testing conversion of 10 digits phone number' do
    it 'should output with meanigful word' do
      object = Conversion.new(phone1)
      expect(object.process).to eq(result1)
    end
  end

  context 'Testing conversion of phone number with special characters' do
    it 'should output with meanigful word with all special characters' do
      object = Conversion.new(phone2)
      expect(object.process).to eq(result2)
    end
  end
end