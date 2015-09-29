namespace :import_data do
  task cryptor: :environment do
    # YAML::load_file(File.join(Rails.root, 'db/data.yml'))
    puts "begin #{be = Time.now}"
    io = File.new(Rails.root + "db/data.yml")
    File.open("/home/itachi/data.sql", "w") do |file|
      YAML.load_documents(io) do |ydoc|
        ydoc.keys.each do |table_name|
          # ActiveRecord::Base.transaction do
            next if ydoc[table_name].nil?
            next if table_name != "key_pairs"
            puts "Start #{start = Time.now}"
            puts "table_name"
            table_name.classify.constantize.delete_all
            records = ydoc[table_name]["records"]
            columns = ydoc[table_name]["columns"]
            count = -1
            # slq = ""
            # records.each_slice(1000) do |record|
              columns = column_names.map{|cn| ActiveRecord::Base.connection.columns(table_name).detect{|c| c.name == cn}}
              quoted_column_names = column_names.map { |column| ActiveRecord::Base.connection.quote_column_name(column) }.join(',')
              quoted_table_name = SerializationHelper::Utils.quote_table(table)
              quoted_values = records.map{|v| v.zip(columns).map{|c| "(#{ActiveRecord::Base.connection.quote(c.first, c.last)}.join(',')})"}}.join(",")
              # ActiveRecord::Base.connection.execute("INSERT INTO #{quoted_table_name} (#{quoted_column_names}) VALUES #{quoted_values}")
              file.puts "INSERT INTO #{quoted_table_name} (#{quoted_column_names}) VALUES #{quoted_values};"
              # table_name.classify.constantize.create Hash[columns.zip(record)]
              # if count % 1000 == 0
              #   sql = "INSERT INTO #{table_name} (key, created_at, updated_at) VALUES (#{ActiveRecord::Base.connection.quote 'key'}, '#{date}', '#{date}')"
              # else
              # end
            # end
            puts "End #{Time.now - start}"
          # end
        end
      end
    end
    puts "END #{Time-be}"
  end

  task key6: :environment do
    KeyHexa.delete_all
    puts "Import 6 #{Time.now}"
    arr = KeySingle.pluck(:key)
    start_time = Time.now
    date = "2015-09-24 16:00:00"
    sql = "INSERT INTO key_hexas (key, created_at, updated_at) VALUES (#{ActiveRecord::Base.connection.quote 'key'}, '#{date}', '#{date}')"
    count = 0
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map{|k| k.scan(/.{6}/)}.flatten.uniq.each do |key|
        next if not_in_check(key, arr)
        sql += ", (#{ActiveRecord::Base.connection.quote key}, '#{date}', '#{date}')"
        count += 1
        if (count % 400 == 0)
          ActiveRecord::Base.connection.execute(sql)
          sql = "INSERT INTO key_hexas (key, created_at, updated_at) VALUES (#{ActiveRecord::Base.connection.quote 'key'}, '#{date}', '#{date}')"
        end
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  task key7: :environment do
    arr = KeySingle.pluck(:key)
    KeyHepta.delete_all
    puts "Import 7 #{Time.now}"
    start_time = Time.now
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map{|k| k.scan(/.{7}/)}.flatten.uniq.each do |key|
        next if not_in_check(key, arr)
        KeyHepta.create key: key
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  task key8: :environment do
    arr = KeySingle.pluck(:key)
    KeyOcta.delete_all
    puts "Import 8 #{Time.now}"
    start_time = Time.now
    date = "2015-09-24 16:00:00"
    sql = ""
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map{|k| k.scan(/.{8}/)}.flatten.uniq.each do |key|
        next if not_in_check(key, arr)
        sql = "INSERT INTO key_octa (key, created_at, updated_at) VALUES (#{ActiveRecord::Base.connection.quote key}, '#{date}', '#{date}');"
        ActiveRecord::Base.connection.execute(sql)
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  task key9: :environment do
    arr = KeySingle.pluck(:key)
    KeyNona.delete_all
    puts "Import 9 #{Time.now}"
    start_time = Time.now
    date = "2015-09-24 16:00:00"
    sql = "INSERT INTO key_nonas (key, created_at, updated_at) VALUES (#{ActiveRecord::Base.connection.quote 'key'}, '#{date}', '#{date}')"
    count = 0
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map{|k| k.scan(/.{9}/)}.flatten.uniq.each do |key|
        next if not_in_check(key, arr)
        sql += ", (#{ActiveRecord::Base.connection.quote key}, '#{date}', '#{date}')"
        count += 1
        if (count % 400 == 0)
          ActiveRecord::Base.connection.execute(sql)
          sql = "INSERT INTO key_nonas (key, created_at, updated_at) VALUES (#{ActiveRecord::Base.connection.quote 'key'}, '#{date}', '#{date}')"
        end
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  task key10: :environment do
    arr = KeySingle.pluck(:key)
    KeyDeca.delete_all
    puts "Import 10 #{Time.now}"
    start_time = Time.now
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map{|k| k.scan(/.{10}/)}.flatten.uniq.each do |key|
        next if not_in_check(key, arr)
        KeyDeca.create key: key
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  task key_model: :environment do
    arr = KeySingle.pluck(:key)
    model = ENV["MODEL"].constantize
    model.delete_all
    puts "Import #{model} #{Time.now}"
    start_time = Time.now
    date = "2015-09-25 16:00:00"
    sql = "INSERT INTO #{model.table_name} (key, created_at, updated_at) VALUES "
    count = 0
    ActiveRecord::Base.transaction do
      PageContent.pluck(:content).map{|k| k.scan(/.{#{model.key_type}}/)}.flatten.uniq.each do |key|
        next if not_in_check(key, arr)
        count += 1
        if (count % 1000 == 0)
          ActiveRecord::Base.connection.execute(sql + " (#{ActiveRecord::Base.connection.quote key}, '#{date}', '#{date}')")
          sql = "INSERT INTO #{model.table_name} (key, created_at, updated_at) VALUES "
        else
          sql += " (#{ActiveRecord::Base.connection.quote key}, '#{date}', '#{date}'),"
        end
      end
      if count % 1000 != 0
        ActiveRecord::Base.connection.execute(sql + " ('key', '#{date}', '#{date}')")
      end
    end
    puts "END: #{Time.now - start_time}"
  end

  def not_in_check key, arr
    key.each_char do |cstr|
      return true if arr.exclude?(cstr)
    end
    false
  end
end
