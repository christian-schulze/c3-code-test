require 'spec_helper'

require 'rules/state_exists'

module Rules
  describe StateExists do

    describe '.valid?(row)' do
      subject { StateExists.new('column2', default_path: File.join(FIXTURE_PATH, 'states.csv')) }

      let(:blank)         { { 'column2' => '' } }
      let(:doesnt_exist)  { { 'column2' => '10' } }
      let(:exists)        { { 'column2' => '1' } }

      it 'returns false when column does not exist' do
        expect( subject.valid?( Hash.new ) ).to be_false
      end

      it 'returns false when column is blank' do
        expect( subject.valid?( blank ) ).to be_false
      end

      it 'returns false when the state index does not exist' do
        expect( subject.valid?( doesnt_exist ) ).to be_false
      end

      it 'returns true when the state index exists' do
        expect( subject.valid?( exists ) ).to be_true
      end
    end

  end
end
