class KeyPentum < ActiveRecord::Base
  include KeyImport

  class << self
    def key_type
      5
    end
  end
end
