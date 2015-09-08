require "#{Rails.root}/lib/cipher_encryptor.rb"
namespace :import do
  task master: :environment do
    ActiveRecord::Base.transaction do
      CipherEncryptor::KEYS.each do |key|
        KeyPair.find_or_create_by key: key
      end
    end
  end

  task tanso_tansuat1: :environment do
    all_content = PageContent.pluck(:content).join("")
    length = all_content.length
    ActiveRecord::Base.transaction do
      KeySingle.all.each do |key_single|
        tanso = all_content.count key_single.key
        key_single.update_attributes tanso: tanso, tansuat: tanso.to_f/length
      end
    end
  end

  task tanso_tansuat2: :environment do
    puts "Tinh tan so bo 2"
    start = Time.now
    keys = KeyPair.pluck(:key)
    hash_pair = Hash[keys.zip([0] * keys.size)]

    PageContent.pluck(:content).each do |content|
      content.scan(/.{2}/).each{|k| hash_pair[k] += 1}
    end

    ActiveRecord::Base.transaction do
      KeyPair.all.each do |key_pair|
        key_pair.update_attributes tanso: hash_pair[key_pair.key]
      end
    end
    puts "----END: #{Time.now - start}---"
    puts "Tinh tan suat bo 2"
    start = Time.now
    sum = KeyPair.sum(:tanso)
    ActiveRecord::Base.transaction do
      KeyPair.all.each do |key_pair|
        key_pair.update_attributes tansuat: key_pair.tanso.to_f/sum
      end
    end
    puts "----END: #{Time.now - start}---"
  end

  task tanso_tansuat3: :environment do
    puts "Tinh tan so bo 3"
    start = Time.now
    keys = KeyTriple.pluck(:key)
    hash_pair = Hash[keys.zip([0] * keys.size)]
    count = 0
    PageContent.pluck(:content).each do |content|
      content.scan(/.{3}/).each do |k|
        if hash_pair[k]
          hash_pair[k] += 1
        else
          count += 1
          puts "#{k}---#{count}"
        end
      end
    end

    ActiveRecord::Base.transaction do
      KeyTriple.all.each do |key_triple|
        key_triple.update_attributes tanso: hash_pair[key_triple.key]
      end
    end
    puts "----END: #{Time.now - start}---"

    puts "Tinh tan suat bo 3"
    start = Time.now
    sum = KeyTriple.sum(:tanso)
    ActiveRecord::Base.transaction do
      KeyTriple.all.each do |key_triple|
        key_triple.update_attributes tansuat: key_triple.tanso.to_f/sum
      end
    end
    puts "----END: #{Time.now - start}---"
  end

  desc "Import key map for 1,2,3"
  task key_map123: :environment do
    [KeySingle, KeyPair, KeyTriple].each do |key_model|
      puts "Import key map #{key_model.name}"
      start = Time.now
      count = key_model.count
      values = ("A".."Z").to_a.repeated_permutation(key_model.key_type + 1
        ).map{|k| k.join("")}.sample(count)
      ActiveRecord::Base.transaction do
        key_model.all.each_with_index do |key, index|
          key.update_attributes value: values[index]
        end
      end
      puts "----END: #{Time.now - start}---"
    end
  end

  desc "import key 4,5"
  task key4: :environment do
    KeyQuadruple.delete_all
    puts "Import 4 #{Time.now}"
    start_time = Time.now
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map{|k| k.scan(/.{4}/)}.flatten.uniq.each do |key|
        KeyQuadruple.create key: key
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  task key5: :environment do
    KeyPentum.delete_all
    puts "Import 5 #{Time.now}"
    start_time = Time.now
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map{|k| k.scan(/.{5}/)}.flatten.uniq.each do |key|
        KeyPentum.create key: key
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  task tanso_tansuat4: :environment do
    puts "Tinh tan so bo 4"
    start = Time.now
    keys = KeyQuadruple.pluck(:key)
    hash_pair = Hash[keys.zip([0] * keys.size)]
    count = 0
    PageContent.pluck(:content).each do |content|
      content.scan(/.{4}/).each do |k|
        if hash_pair[k]
          hash_pair[k] += 1
        else
          count += 1
          puts "#{k}---#{count}"
        end
      end
    end
    puts "END: #{Time.now - start}"
    puts "Tan so"
    start_time = Time.now
    ActiveRecord::Base.transaction do
      KeyQuadruple.all.each do |key|
        key.update_attributes tanso: hash_pair[key.key]
      end
    end
    puts "END: #{Time.now - start_time}"
    hash_pair = nil
  end

  task tanso_tansuat5: :environment do
    puts "Tinh tan so bo 5"
    start = Time.now
    start_time = Time.now
    keys = KeyPentum.pluck(:key)
    hash_pair = Hash[keys.zip([0] * keys.size)]
    count = 0
    PageContent.pluck(:content).each do |content|
      content.scan(/.{5}/).each do |k|
        if hash_pair[k]
          hash_pair[k] += 1
        else
          count += 1
          puts "#{k}---#{count}"
        end
      end
    end
    puts "END: #{Time.now - start}"
    puts "Tan so"
    start = Time.now
    jum = 297108
    sid = 39889
    eid = 39889 + 297108
    ActiveRecord::Base.transaction do
      KeyPentum.where(id: sid..eid).each do |key|
        key.update_attributes tanso: hash_pair[key.key]
      end
    end
    puts "END: #{Time.now - start}"
    puts "j2"
    start = Time.now
    sid = eid + 1
    eid += jum

    ActiveRecord::Base.transaction do
      KeyPentum.where(id: sid..eid).each do |key|
        key.update_attributes tanso: hash_pair[key.key]
      end
    end
    puts "END: #{Time.now - start}"
    puts "j3"
    start = Time.now
    sid = eid + 1
    eid = 931212
    ActiveRecord::Base.transaction do
      KeyPentum.where(id: sid..eid).each do |key|
        key.update_attributes tanso: hash_pair[key.key]
      end
    end
    puts "END: #{Time.now - start}"


    puts "END: #{Time.now - start_time}"
    hash_pair = nil
  end

  task tansuat4: :environment do
    puts "tan suat 4 #{Time.now}"
    start = Time.now
    sum = KeyQuadruple.sum(:tanso)
    ActiveRecord::Base.transaction do
      KeyQuadruple.all.each do |key_triple|
        key_triple.update_attributes tansuat: key_triple.tanso.to_f/sum
      end
    end
    puts "END: #{Time.now - start}"
  end

  desc "Task description"
  task tansuat5: :environment do
    puts "Tan so"
    sum = KeyPentum.sum(:tanso)
    start = Time.now
    start_time = Time.now
    jum = 297108
    sid = 39889
    eid = 39889 + 297108
    ActiveRecord::Base.transaction do
      KeyPentum.where(id: sid..eid).each do |key_triple|
        key_triple.update_attributes tansuat: key_triple.tanso.to_f/sum
      end
    end
    puts "END: #{Time.now - start}"
    puts "j2"
    start = Time.now
    sid = eid + 1
    eid += jum

    ActiveRecord::Base.transaction do
      KeyPentum.where(id: sid..eid).each do |key_triple|
        key_triple.update_attributes tansuat: key_triple.tanso.to_f/sum
      end
    end
    puts "END: #{Time.now - start}"
    puts "j3"
    start = Time.now
    sid = eid + 1
    eid = 931212
    ActiveRecord::Base.transaction do
      KeyPentum.where(id: sid..eid).each do |key_triple|
        key_triple.update_attributes tansuat: key_triple.tanso.to_f/sum
      end
    end
    puts "END: #{Time.now - start}"

    puts "END: #{Time.now - start_time}"
  end
end
