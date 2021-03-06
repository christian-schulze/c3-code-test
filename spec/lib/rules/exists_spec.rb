require 'spec_helper'

require 'rules/exists'

module Rules
  describe Exists do
    subject { Exists.new('column2') }

    let(:blank)     { { 'column2' => '' } }
    let(:null)      { { 'column2' => nil } }
    let(:not_blank) { { 'column2' => '12345' } }

    describe '.valid?(row)' do
      it 'returns false when column does not exist' do
        expect( subject.valid?( Hash.new ) ).to be_false
      end

      it 'returns false when column is blank' do
        expect( subject.valid?( blank ) ).to be_false
      end

      it 'returns false when column is nil' do
        expect( subject.valid?( null ) ).to be_false
      end

      it 'returns true when column is not blank' do
        expect( subject.valid?( not_blank ) ).to be_true
      end
    end

    describe '.failure_message(row)' do
      it 'returns a specific failure message' do
        expect( subject.failure_message( blank ) ).to eq 'column2 does not exist.'
      end
    end

  end
end
