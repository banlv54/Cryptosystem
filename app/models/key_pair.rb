class KeyPair < ActiveRecord::Base
  include KeyImport

  class << self
    def key_type
      2
    end
  end
end
