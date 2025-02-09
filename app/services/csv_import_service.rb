# frozen_string_literal: true

class CsvImportService
require "csv"

  def initialize(csv_file)
    @csv_file_path = csv_file
    @imported_users = []
    @failed_imports = []
  end

  def import
    # parse csv
    @csv = CSV.parse(File.read(@csv_file_path), headers: true, skip_blanks: true)
    puts("@csv: #{@csv}")

    validate_and_save

    {
      number_of_imported_users: @imported_users.length,
      number_of_failed_imports: @failed_imports.length,
      imported_subscribers: @imported_users,
      failed_imports: @failed_imports
    }
  end

  private

  def validate_and_save
    @csv.each_with_index do |row, i|
      # headers were skipped in import
      user = User.find_or_initialize_by(email: row[2])
      user.email = row[2]
      user.first_name = row[0]
      user.last_name = row[1]

      if user.valid?
        begin
          user.save!
          @imported_users << { first_name: user.first_name, last_name: user.last_name, email: user.email }
        rescue StandardError => e
          rails.logger.error(e, "failed to save user: #{e.message}")
          @failed_imports << { first_name: user.first_name, last_name: user.last_name, email: user.email }
        end
      else
        @failed_imports << { first_name: user.first_name, last_name: user.last_name, email: user.email }
        rails.logger.info("Invalid user data for row #{i + 1}: #{row}")
      end

    end
  end
end
