class KeyQuadruple < ActiveRecord::Base
  include KeyImport
  # before_create :create_key

  class << self
    def key_type
      4
    end
  end
end
