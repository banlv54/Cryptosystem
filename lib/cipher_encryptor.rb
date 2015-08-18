class CipherEncryptor
  KEYS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "ă", "â", "b", "c", "d", "đ", "e", "ê", "g", "h", "i", "k", "l", "m", "n", "o", "ô", "ơ", "p", "q", "r", "s", "t", "u", "ư", "v", "x", "y", "A", "Ă", "Â", "B", "C", "D", "Đ", "E", "Ê", "G", "H", "I", "K", "L", "M", "N", "O", "Ô", "Ơ", "P", "Q", "R", "S", "T", "U", "Ư", "V", "X", "Y", "á", "à", "ả", "ã", "ạ", "ắ", "ặ", "ằ", "ẳ", "ẵ", "ấ", "ầ", "ẩ", "ẫ", "ậ", "đ", "é", "è", "ẻ", "ẽ", "ẹ", "ế", "ề", "ể", "ễ", "ệ", "í", "ì", "ỉ", "ĩ", "ị", "ó", "ò", "ỏ", "õ", "ọ", "ố", "ồ", "ổ", "ỗ", "ộ", "ớ", "ờ", "ở", "ỡ", "ợ", "ú", "ù", "ủ", "ũ", "ụ", "ứ", "ừ", "ử", "ữ", "ự", "ý", "ỳ", "ỷ", "ỹ", "ỵ", "Á", "À", "Ả", "Ã", "Ạ", "Ắ", "Ặ", "Ằ", "Ẳ", "Ẵ", "Ấ", "Ầ", "Ẩ", "Ẫ", "Ậ", "Đ", "É", "È", "Ẻ", "Ẽ", "Ẹ", "Ế", "Ề", "Ể", "Ễ", "Ệ", "Í", "Ì", "Ỉ", "Ĩ", "Ị", "Ó", "Ò", "Ỏ", "Õ", "Ọ", "Ố", "Ồ", "Ổ", "Ỗ", "Ộ", "Ớ", "Ờ", "Ở", "Ỡ", "Ợ", "Ú", "Ù", "Ủ", "Ũ", "Ụ", "Ứ", "Ừ", "Ử", "Ữ", "Ự", "Ý", "Ỳ", "Ỷ", "Ỹ", "Ỵ", "!", "#", "$", "%", "&", '"', "(", ")", "*", "+", ",", "-", ".", "/", ":", ";", "<", "=", ">", "?", "@", "[", "]", "^", "_", "`", "{", "|", "}", "~", "'", "\\", "\n", "\r", " ", "f", "F", "j", "J", "w", "W", "z", "Z"]

  def initialize password, document, type = nil #pair
    @document = document
    @type = type
    import_databases if password.nil? && is_pair?
    @pwd = password || generate_key
    @hash_map = Hash[get_keys.zip @pwd]
  end

  def max_length
    is_pair? ? KeyPair.count : KEYS.length
  end

  def generate_key
    l = max_length
    (0..l - 1).to_a.shuffle.map{|k| k.to_s.rjust(l.to_s.length, "0")}
  end

  def decode
    res = ""
    i = 0
    l = @document.length
    hash_invert = @hash_map.invert
    jum = max_length.to_s.length
    while(i < l-1)
      res += hash_invert[@document[i..i + jum - 1]] || ""
      i += jum
    end
    @document = res
  end

  def encode
    res = ""
    l = @document.length
    i = 0
    jum = is_pair? ? 2 : 1
    while i < l
      res += @hash_map[@document[i..i + jum - 1]] || @document[i..i + jum - 1]
      i += jum
    end
    @document = res
  end

  def document
    @document
  end

  def pwd
    @pwd.join(",")
  end

  private
  def import_databases
    KeyPair.import_databases @document
  end

  def get_keys
    is_pair? ? KeyPair.pluck(:key) : KEYS
  end

  def is_pair?
    @type == "pair"
  end
end
