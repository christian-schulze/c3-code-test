require 'spec_helper'

require 'validator'

describe Validator do

  let(:states_fixture_path) { File.join(FIXTURE_PATH, 'states.csv') }

  describe '.map_column_to_rule(severity, column_name, rule_klass, options = {})' do
    it 'instantiates a rule mapping object when mapping a column to a valid rule' do
      expect( subject.map_column_to_rule(:warning, 'column1', 'Exists').first.class.name ).to eq 'RuleMapping'
    end

    it 'raises an exception if the specified rule does not exist' do
      expect{ subject.map_column_to_rule(:error, 'column1', 'Asdf') }.to raise_error
    end
  end

  describe '.validate(row)' do
    let(:row) {
      {
        'column1' => '',
        'column2' => 'asdf',
        'column3' => '1234',
        'column4' => '1'
      }
    }

    let(:expected_result) { [ false, true, false, true, false, true, false, true ] }

    before do
      subject.map_column_to_rule(:warning,  'column1', 'Exists')
      subject.map_column_to_rule(:warning,  'column2', 'Exists')
      subject.map_column_to_rule(:error,    'column1', 'Integer')
      subject.map_column_to_rule(:error,    'column3', 'Integer')
      subject.map_column_to_rule(:warning,  'column1', 'MinimumLength', minimum_length: 4)
      subject.map_column_to_rule(:warning,  'column2', 'MinimumLength', minimum_length: 4)
      subject.map_column_to_rule(:warning,  'column1', 'StateExists',   default_path: states_fixture_path)
      subject.map_column_to_rule(:warning,  'column4', 'StateExists',   default_path: states_fixture_path)
    end

    it 'correctly validates a row' do
      expect( subject.validate(row) ).to eq expected_result
    end
  end
end
