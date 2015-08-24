class KeyQuadruple < ActiveRecord::Base
  include KeyImport

  class << self
    def key_type
      4
    end
  end
end
