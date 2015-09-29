namespace :calculate do
  task n_tropy: :environment do
    puts "N tropy bo #{ENV['model']}"
    hp = 0
    ENV['model'].constantize.all.each do |key_single|
      pi = key_single.tansuat
      next if pi == 0
      hp += pi.to_f * (Math.log2(1.to_f/pi.to_f))
    end
    puts "ntropy = #{hp}"
  end

  task key_model: :environment do
    model = ENV["MODEL"].constantize
    puts "Tinh tan so , suat bo #{model} #{start = Time.now}"
    keys = model.pluck(:key, :id)
    hash_pair = Hash[keys.map(&:first).zip([0] * keys.size)]
    total = 0
    puts "count #{Time.now - start}"
    # PageContent.pluck(:content).map{|k| k.scan(/.{#{model.key_type}}/)}.flatten.each do |key|
    #   hash_pair[key] = count_key
    #   total += 1
    # end
    # all_keys.each do 
    # keys.each do |key, _|
    #   count_key = all_keys.count(key)
    #   hash_pair[key] = count_key
    #   total += count_key
    # end
    # total = hash_pair.inject(0){|sum, v| sum += v.value}
    count = 0
    PageContent.pluck(:content).map{|k| k.scan(/.{#{model.key_type}}/)}.flatten.each do |k|
      if hash_pair[k]
        hash_pair[k] += 1
        total += 1
      else
        count += 1
        puts "#{k}---#{count}"
      end
    end
    puts "insert #{Time.now - start}"
    ActiveRecord::Base.transaction do
      keys.each do |key, id|
        tanso = hash_pair[key]
        ActiveRecord::Base.connection.execute(
          "UPDATE #{model.table_name} SET tanso = #{tanso}, tansuat = #{tanso.to_f/total} WHERE ID = #{id}"
        )
      end
    end
    # puts "----END: #{Time.now - start}---"

    # puts "Tinh tan suat bo #{model} - #{start = Time.now}"
    # sum = model.sum(:tanso)
    # ActiveRecord::Base.transaction do
    #   model.all.each do |key|
    #     ActiveRecord::Base.connection.execute(
    #       "UPDATE #{model.table_name} SET tansuat = #{key.tanso.to_f/sum} WHERE ID = #{key.id}"
    #     )
    #   end
    # end
    puts "----END: #{Time.now - start}---"
  end
end

def logarit n
  total = 0
  n.times do |num|
    total += Math.log2(num + 1)
  end
  puts total
end