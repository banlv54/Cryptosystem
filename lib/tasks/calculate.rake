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
end
def logarit n
  total = 0
  n.times do |num|
    total += Math.log2(num + 1)
  end
  puts total
end