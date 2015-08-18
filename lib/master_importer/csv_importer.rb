require "csv"
module MasterImporter
  class MasterImporter::CSVImporter

    def initialize model
      @model = model
    end

    def execute
      puts "== Load #{@model}"
      csv_table = CSV.parse(File.read(csv_file_path), headers: true)
      csv_table.each do |row|
        instance = @model.find_by id: row["id"]
        next if instance
        instance = @model.new row.to_hash
        instance.save validate: false
      end
    end

    private
    def destroy_all
      puts "== Destroy All of #{@model}"
      @model.destroy_all
    end

    def csv_file_path
      Rails.root.join "db", "masters", "#{@model.name.underscore.pluralize}.csv"
    end

  end
end

