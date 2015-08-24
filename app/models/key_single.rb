class KeySingle < ActiveRecord::Base
  include KeyImport

  class << self
    def key_type
      1
    end
  end
end
