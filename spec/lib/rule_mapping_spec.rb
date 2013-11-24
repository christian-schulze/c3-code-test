require 'spec_helper'

require 'rule_mapping'

describe RuleMapping do

  subject { RuleMapping }

  let(:states_fixture_path) { File.join(FIXTURE_PATH, 'states.csv') }

  describe '.map_column_to_rule(severity, column_name, rule_klass, options = {})' do
    it 'instantiates the Exists rule' do
      expect( subject.new(:warning, 'column1', 'Exists').rule.class.name ).to eq 'Rules::Exists'
    end

    it 'instantiates the Integer rule' do
      expect( subject.new(:error, 'column1', 'Integer').rule.class.name ).to eq 'Rules::Integer'
    end

    it 'instantiates the MinimumLength rule' do
      expect( subject.new(:warning, 'column1', 'MinimumLength', minimum_length: 10).rule.class.name ).to eq 'Rules::MinimumLength'
    end

    it 'instantiates the StateExists rule' do
      expect( subject.new(:warning, 'column1', 'StateExists', default_path: states_fixture_path).rule.class.name ).to eq 'Rules::StateExists'
    end
  end

  describe '#string_to_klass(klass_string)' do
    it 'returns a matching rule constant' do
      expect( subject.string_to_klass('Exists').name ).to eq 'Rules::Exists'
    end
  end

end
