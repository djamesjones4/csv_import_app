# frozen_string_literal: true

require "rails_helper"

describe CsvImportService do
  describe "#import" do
    context "when csv file is valid" do
      let(:filepath) { Rails.root.join("spec", "fixtures", "files", "user_import.csv") }

      it "imports CSV files" do
        result = described_class.new(filepath).import

        expect(result[:number_of_failed_imports]).to eq 0
        expect(result[:number_of_imported_users]).to eq 3
        expect(result[:imported_users]).to include(
                                             { first_name: "Sue", last_name: "Johnson", email: "sue@example.com" },
                                             { first_name: "John", last_name: "Doe", email: "john@example.com" },
                                             { first_name: "Steve", last_name: "Jobs", email: "steve@apple.com" }
                                           )

      end
    end
    context "when csv file is invalid" do
      let(:filepath) { Rails.root.join("spec", "fixtures", "files", "invalid_user_import.csv") }

      before do
        allow(Rails.logger).to receive(:info)
        allow(Rails.logger).to receive(:error)
      end
      it "returns the invalid users as 'failed_imports' while still returning the valid users" do
        result = described_class.new(filepath).import

        expect(result[:number_of_failed_imports]).to eq 1
        expect(result[:failed_imports]).to eq([ { first_name: "Sue", last_name: "Johnson", email: "sueexample.com" } ])
        expect(result[:number_of_imported_users]).to eq 2
        expect(result[:imported_users]).to include({ first_name: "John", last_name: "Doe", email: "john@example.com" }, { first_name: "Steve", last_name: "Jobs", email: "steve@apple.com" })
        expect(Rails.logger).to have_received(:info)
      end
    end
  end
end
