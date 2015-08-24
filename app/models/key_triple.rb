class KeyTriple < ActiveRecord::Base
  include KeyImport

  class << self
    def key_type
      3
    end
  end
end
