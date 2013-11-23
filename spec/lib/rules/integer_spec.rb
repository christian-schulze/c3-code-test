require 'spec_helper'

require 'rules/integer'

module Rules
  describe Integer do

    describe '.valid?(row)' do
      subject { Integer.new('column2') }

      let(:blank)   { { 'column2' => '' } }
      let(:float)   { { 'column2' => '12345.70' } }
      let(:string)  { { 'column2' => 'asdf' } }
      let(:integer) { { 'column2' => '12345' } }

      it 'returns false when column does not exist' do
        expect( subject.valid?( Hash.new ) ).to be_false
      end

      it 'returns false when column is blank' do
        expect( subject.valid?( blank ) ).to be_false
      end

      it 'returns false when column is a float' do
        expect( subject.valid?( float ) ).to be_false
      end

      it 'returns false when column is a string' do
        expect( subject.valid?( string ) ).to be_false
      end

      it 'returns true when column is an integer' do
        expect( subject.valid?( integer ) ).to be_true
      end
    end

  end
end
