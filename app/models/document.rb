class Document < ActiveRecord::Base
  DEFAULT_ATTRIBUTES = [:content, :title]

  belongs_to :cipher

  def self.import_database start_id, end_id, last_page_id, end_page_id
    models = []
    loggers = []
    keys = []
    counts = []
    (start_id..end_id).each do |i|
      index = i - start_id
      models[index] = CipherEncryptor::MODELS[i].constantize
      loggers[index] = Logger.new Rails.root + "log/import_#{models[index].name}_#{Time.now.to_s.gsub(' ', '_')}.log"
      keys[index] = models[index].pluck :key
      counts[index] = models[index].count
    end
    transaction do
      PageContent.where("id > ? AND id < ?", last_page_id, end_page_id).pluck(:content)
        .each_with_index do |doc, ind|
        (start_id..end_id).each do |i|
          index = i - start_id
          models[index].import_databases keys[index], doc
          new_count = models[index].count
          loggers[index].info "Import from page_content #{ind + last_page_id}: #{new_count - counts[index]}"
          counts[index] = new_count
        end
      end
    end
    (start_id..end_id).each do |i|
      index = i - start_id
      loggers[index].info "-------------END-------------"
    end
  end
end
