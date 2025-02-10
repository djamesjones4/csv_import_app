
class BookCsvImportService
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @imported_files = []
    @failed_imports = []
  end

  def import
    @csv = CSV.parse(File.read(@csv_file_path), headers: true)

    import_and_save

    {
      imported_files: @imported_files,
      failed_imports: @failed_imports,
      number_of_imports: @imported_files.length,
      number_of_failed_imports: @failed_imports.length
    }
  end

  private

  def import_and_save
    # iterate over csv
    @csv.each_with_index do |row, i|
      book = Book.find_or_initialize_by(title: row[:title])
      book.title = row[0]
      book.author_first_name = row[1]
      book.author_last_name = row[2]
      book.description = row[3]

      # validate
      if book.valid?
        begin
          book.save!
          @imported_files << book
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error("error: #{e.message}")
          @failed_imports << book
        end

      else
        @failed_imports << book
      end

    end
  end
end
