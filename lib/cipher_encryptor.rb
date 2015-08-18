class CipherEncryptor
  KEYS = ["0","1","2","3","4","5","6","7","8","9","a", "ă","â","b","c","d","đ","e","ê","g","h","i","k","l","m","n","o","ô","ơ","p","q","r","s","t","u","ư","v","x","y","A","Ă","Â","B","C","D","Đ","E","Ê","G","H","I","K","L","M","N","O","Ô","Ơ","P","Q","R","S","T","U","Ư","V","X","Y","á","à","ả","ã","ạ","ắ","ặ","ằ","ẳ","ẵ","ấ","ầ","ẩ","ẫ","ậ","đ","é","è","ẻ","ẽ","ẹ","ế","ề","ể","ễ","ệ","í","ì","ỉ","ĩ","ị","ó","ò","ỏ","õ","ọ","ố","ồ","ổ","ỗ","ộ","ớ","ờ","ở","ỡ","ợ","ú","ù","ủ","ũ","ụ","ứ","ừ","ử","ữ","ự","ý","ỳ","ỷ","ỹ","ỵ","Á","À","Ả","Ã","Ạ","Ắ","Ặ","Ằ","Ẳ","Ẵ","Ấ","Ầ","Ẩ","Ẫ","Ậ","Đ","É","È","Ẻ","Ẽ","Ẹ","Ế","Ề","Ể","Ễ","Ệ","Í","Ì","Ỉ","Ĩ","Ị","Ó","Ò","Ỏ","Õ","Ọ","Ố","Ồ","Ổ","Ỗ","Ộ","Ớ","Ờ","Ở","Ỡ","Ợ","Ú","Ù","Ủ","Ũ","Ụ","Ứ","Ừ","Ử","Ữ","Ự","Ý","Ỳ","Ỷ","Ỹ","Ỵ","!","#","$","%","&",'"',"(",")","*","+",",","-",".","/",":",";","<","=",">","?","@","[","]","^","_","`","{","|","}","~","'", "\\", "\n", "\r", " ", "f", "F", "j", "J", "w", "W", "z", "Z"]

  def initialize password, document
    @pwd = password || generate_key
    @document = document
    @hash_map = Hash[KEYS.zip @pwd]
  end

  def max_length
    KEYS.length
  end

  def generate_key
    (0..max_length - 1).to_a.shuffle.map{|k| k.to_s.rjust(max_length.to_s.length, "0")}
  end

  def decode
#    KEYS.each_with_index do |key, index|
#      @document.gsub! @pwd[index] + ".", key
#    end
    res = ""
    i = 0
    l = @document.length
    hash_invert = @hash_map.invert
    while(i < l-1)
#     binding.pry
      res += hash_invert[@document[i..i+2]] || ""
      i += 3
    end
    @document = res
  end

  def encode
#    @pwd = generate_key.map{|k| k.to_s.rjust(max_length.to_s.length, "0")}
#    KEYS.each_with_index do |key, index|
#      @document.gsub! key, @pwd[index] + "."
#    end
    res = ""
    @document.length.times do |i|
      res += @hash_map[@document[i]] || @document[i]
    end
    @document = res
  end

  def document
    @document
  end

  def pwd
    @pwd.join(",")
  end
end
