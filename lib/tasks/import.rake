require "#{Rails.root}/lib/cipher_encryptor.rb"
namespace :import do
  task master: :environment do
    ActiveRecord::Base.transaction do
      CipherEncryptor::KEYS.each do |key|
        KeyPair.find_or_create_by key: key
      end
    end
  end

  desc "import key 4,5"
  task key4: :environment do
    KeyQuadruple.delete_all
    puts "Import 4"
    start_time = Time.now
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map do |content|
        content.scan(/.{4}/).uniq
      end.flatten.uniq.each do |key|
        KeyQuadruple.create key: key
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  task key5: :environment do
    KeyPentum.delete_all
    puts "Import 5"
    start_time = Time.now
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map do |content|
        content.scan(/.{5}/).uniq
      end.flatten.uniq.each do |key|
        KeyPentum.create key: key
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  task count_4: :environment do
    length = KeyQuadruple.length
    count_hash = Hash[KeyQuadruple.pluck(:key).zip [0]*length]
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).each do |content|
        content.scan(/.{4}/).each do |key|
          count_hash[key] += 1
        end
      end
    end
  end
end
