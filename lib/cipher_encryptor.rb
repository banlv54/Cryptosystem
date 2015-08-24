class CipherEncryptor
  KEYS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "ă", "â", "b", "c", "d", "đ", "e", "ê", "g", "h", "i", "k", "l", "m", "n", "o", "ô", "ơ", "p", "q", "r", "s", "t", "u", "ư", "v", "x", "y", "A", "Ă", "Â", "B", "C", "D", "Đ", "E", "Ê", "G", "H", "I", "K", "L", "M", "N", "O", "Ô", "Ơ", "P", "Q", "R", "S", "T", "U", "Ư", "V", "X", "Y", "á", "à", "ả", "ã", "ạ", "ắ", "ặ", "ằ", "ẳ", "ẵ", "ấ", "ầ", "ẩ", "ẫ", "ậ", "đ", "é", "è", "ẻ", "ẽ", "ẹ", "ế", "ề", "ể", "ễ", "ệ", "í", "ì", "ỉ", "ĩ", "ị", "ó", "ò", "ỏ", "õ", "ọ", "ố", "ồ", "ổ", "ỗ", "ộ", "ớ", "ờ", "ở", "ỡ", "ợ", "ú", "ù", "ủ", "ũ", "ụ", "ứ", "ừ", "ử", "ữ", "ự", "ý", "ỳ", "ỷ", "ỹ", "ỵ", "Á", "À", "Ả", "Ã", "Ạ", "Ắ", "Ặ", "Ằ", "Ẳ", "Ẵ", "Ấ", "Ầ", "Ẩ", "Ẫ", "Ậ", "Đ", "É", "È", "Ẻ", "Ẽ", "Ẹ", "Ế", "Ề", "Ể", "Ễ", "Ệ", "Í", "Ì", "Ỉ", "Ĩ", "Ị", "Ó", "Ò", "Ỏ", "Õ", "Ọ", "Ố", "Ồ", "Ổ", "Ỗ", "Ộ", "Ớ", "Ờ", "Ở", "Ỡ", "Ợ", "Ú", "Ù", "Ủ", "Ũ", "Ụ", "Ứ", "Ừ", "Ử", "Ữ", "Ự", "Ý", "Ỳ", "Ỷ", "Ỹ", "Ỵ", "!", "#", "$", "%", "&", '"', "(", ")", "*", "+", ",", "-", ".", "/", ":", ";", "<", "=", ">", "?", "@", "[", "]", "^", "_", "`", "{", "|", "}", "~", "'", "\\", "\n", "\r", " ", "f", "F", "j", "J", "w", "W", "z", "Z"]
  MODELS = {
    1 => "KeySingle",
    2 => "KeyPair",
    3 => "KeyTriple",
    4 => "KeyQuadruple",
    5 => "KeyPentum"
  }

  def initialize password, document, type = nil #pair
    @document = document
    @type = (type || 1).to_i
    import_databases if password.nil?
    @pwd = password || generate_key
    @hash_map = Hash[get_keys.zip @pwd]
  end

  def max_length
    model.count
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
    @document.scan(/.{#{jum}}|.{1}/).each do |key|
      res += hash_invert[key]
    end
    @document = res
  end

  def encode
    res = ""
    l = @document.length
    i = 0
    jum = @type
    @document.scan(/.{#{@type}}|.{1}/).each do |key|
      res += @hash_map[key]
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
    keys = model.pluck(:key)
    model.import_databases keys, @document
  end

  def get_keys
    model.pluck(:key)
  end

  def model
    MODELS[@type].constantize
  end
end
