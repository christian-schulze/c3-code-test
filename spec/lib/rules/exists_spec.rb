require 'spec_helper'

require 'rules/exists'

module Rules
  describe Exists do

    describe '.valid?(row)' do
      subject { Exists.new('column2') }

      let(:blank)     { { 'column2' => '' } }
      let(:not_blank) { { 'column2' => '12345' } }

      it 'returns false when column does not exist' do
        expect( subject.valid?( Hash.new ) ).to be_false
      end

      it 'returns false when column is blank' do
        expect( subject.valid?( blank ) ).to be_false
      end

      it 'returns true when column is not blank' do
        expect( subject.valid?( not_blank ) ).to be_true
      end
    end

  end
end
