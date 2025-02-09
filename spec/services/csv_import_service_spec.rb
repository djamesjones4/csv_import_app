# frozen_string_literal: true

require "rails_helper"

describe CsvImportService do
  describe "#import" do
    context "when csv file is valid" do
      let(:filepath) { Rails.root.join("spec", "fixtures", "files", "user_import.csv") }
      it "imports CSV files" do
        result = described_class.new(filepath).import

        expect(result[:number_of_failed_imports]).to eq 0

      end
    end
  end
end
