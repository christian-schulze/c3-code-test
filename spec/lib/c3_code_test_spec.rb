require 'spec_helper'

require 'c3_code_test'

describe C3CodeTest do

  before :each do
    stub_const('::DATA_PATH', FIXTURE_PATH)
  end

  describe '.process_file(file_path)' do
    let(:test_file_1_record)  { File.join(FIXTURE_PATH, 'test-1-record.csv') }
    let(:test_file_2_records) { File.join(FIXTURE_PATH, 'test-2-records.csv') }

    it 'reads each line of an input file' do
      subject.should_receive(:process_row).twice

      subject.process_file(test_file_2_records)
    end

    it 'converts each line into an CSV::Row object' do
      subject.stub(:process_row) do |row|
        expect( row ).to be_an_instance_of(CSV::Row)
      end

      subject.process_file(test_file_1_record)
    end

    it 'parses the csv header row' do
      subject.stub(:process_row) do |row|
        expect( row.headers ).to eq %w(column1 column2 column3)
      end

      subject.process_file(test_file_1_record)
    end
  end

  let(:data_path) { File.join(FIXTURE_PATH, 'data.csv') }

  it 'correctly detects warnings and errors' do
    expect( subject.process_file(data_path) ).to eq [
      '0: Error: Postcode does not exist.',
      '3: Warning: State: 0 is not contained in the states list.',
      '3: Error: Postcode does not exist.',
      '4: Warning: Salary: 26000.86 is not an integer.',
      '5: Warning: Name: Tom is below the minimum length of 4.',
      '5: Warning: State: 0 is not contained in the states list.'
    ]
  end

end
