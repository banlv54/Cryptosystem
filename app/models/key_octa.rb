class KeyOcta < ActiveRecord::Base
  include KeyImport
  # before_create :create_key

  class << self
    def key_type
      8
    end
  end
end
