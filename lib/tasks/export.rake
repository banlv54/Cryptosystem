namespace :export do
  desc "Export model"
  task model: :environment do
    puts "begin #{be = Time.now}"
    model = ENV["MODEL"].constantize
    attributes = ["id", "key", "created_at", "updated_at", "tanso", "tansuat", "value"]
    quoted_column_names = attributes.map{|k| "`#{k}`"}.join(", ")

    File.open("/home/itachi/#{model.table_name}.sql", "w") do |file|
      file.puts "Drop tables  if exists `#{model.table_name}`;"
      file.puts "CREATE TABLE `#{model.table_name}` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
        `created_at` datetime NOT NULL,
        `updated_at` datetime NOT NULL,
        `tanso` integer,
        `tansuat` decimal(12,10),
        `value` varchar(255),
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;"

      file.puts "CREATE INDEX `index_#{model.table_name}_on_key` ON `key_singles` (`key`);"

      model.all.each_slice(9000) do |keys|
        values = keys.map do |key|
          "(#{key.id}, #{quote escapte key.key}, '#{key.created_at.strftime "%Y-%m-%d %H:%M:%S"}',
            '#{key.updated_at.strftime "%Y-%m-%d %H:%M:%S"}', #{key.tanso.to_f}, #{key.tansuat.to_f}, '#{key.value}')"
        end.join(",")
        file.puts "INSERT INTO `#{model.table_name}` (#{quoted_column_names}) VALUES #{values};"
      end
    end
    puts "END #{Time.now-be}"
  end

  desc "model_slice"
  task :model_slice => :environment do
    file_size = 360000
    puts "begin #{be = Time.now}"
    model = ENV["MODEL"].constantize
    attributes = ["id", "key", "created_at", "updated_at", "tanso", "tansuat", "value"]
    quoted_column_names = attributes.map{|k| "`#{k}`"}.join(", ")

    last_id = model.last.id
    file_count = 0
    start_id = model.first.id
    next_id = start_id + file_size
    while start_id < last_id
      file_count += 1
      File.open("/home/itachi/group/#{model.table_name}_#{file_count}.sql", "w") do |file|
        file.puts "CREATE TABLE IF NOT EXISTS `#{model.table_name}` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
          `created_at` datetime NOT NULL,
          `updated_at` datetime NOT NULL,
          `tanso` integer,
          `tansuat` decimal(12,10),
          `value` varchar(255),
          PRIMARY KEY (`id`)
          ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;"

        file.puts "CREATE INDEX `index_#{model.table_name}_on_key` ON `key_singles` (`key`);"

        model.where(id: (start_id..next_id)).each_slice(9000) do |keys|
          values = keys.map do |key|
            "(#{key.id}, #{quote escapte key.key}, '#{key.created_at.strftime "%Y-%m-%d %H:%M:%S"}',
              '#{key.updated_at.strftime "%Y-%m-%d %H:%M:%S"}', #{key.tanso.to_f}, #{key.tansuat.to_f}, '#{key.value}')"
          end.join(",")
          file.puts "INSERT INTO `#{model.table_name}` (#{quoted_column_names}) VALUES #{values};"
        end
      end
      start_id = next_id + 1
      next_id = next_id + file_size
      puts "End file #{model.table_name}_#{file_count} #{be = Time.now - be}"
    end

    puts "END #{model.table_name} #{Time.now-be}"
  end

  def escapte string
    return string unless string.is_a? String
    string.gsub("\\", "\\\\\\")
  end

  def quote value
    ActiveRecord::Base.connection.quote value
  end
end