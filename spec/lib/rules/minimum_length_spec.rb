require 'spec_helper'

require 'rules/minimum_length'

module Rules
  describe MinimumLength do

    describe '.valid?(row)' do
      subject { MinimumLength.new('column2', minimum_length: 5) }

      let(:less_than_minimum)     { { 'column2' => '1234' } }
      let(:equal_to_minimum)      { { 'column2' => '12345' } }
      let(:greater_than_minimum)  { { 'column2' => '123456' } }

      it 'returns false when column does not exist' do
        expect( subject.valid?( Hash.new ) ).to be_false
      end

      it 'returns false when column is less than minimum length' do
        expect( subject.valid?( less_than_minimum ) ).to be_false
      end

      it 'returns true when column is equal to minimum length' do
        expect( subject.valid?( equal_to_minimum ) ).to be_true
      end

      it 'returns true when column is greater than minimum length' do
        expect( subject.valid?( greater_than_minimum ) ).to be_true
      end
    end

  end
end
