
require "rails_helper"

describe BookCsvImportService do
  context 'when csv is fully valid' do
    let(:valid_csv_path) { Rails.root.join("spec", "fixtures", "files", "valid_book_imports.csv") }

    it "imports the csv and returns expected fields" do
      result = described_class.new(valid_csv_path).import
      expect(result[:number_of_imports]).to eq 3
      expect(result[:number_of_failed_imports]).to eq 0
    end
  end

  context 'when csv is invalid' do
    let(:invalid_csv_path) { Rails.root.join("spec", "fixtures", "files", "invalid_book_imports.csv") }

    it "returns the invalid imports and valid imports" do
      result = described_class.new(invalid_csv_path).import
      expect(result[:number_of_imports]).to eq 2
      expect(result[:number_of_failed_imports]).to eq 1
    end
  end
end
