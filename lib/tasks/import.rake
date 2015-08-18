namespace :import do
  task master: :environment do
    MasterImport::CSVImporter.new(Cipher).execute
  end
end
