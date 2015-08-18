require "#{Rails.root}/lib/cipher_encryptor.rb"
namespace :import do
  task master: :environment do
    ActiveRecord::Base.transaction do
      CipherEncryptor::KEYS.each do |key|
        KeyPair.find_or_create_by key: key
      end
    end
  end
end
