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

end
