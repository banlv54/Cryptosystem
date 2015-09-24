class KeyHexa < ActiveRecord::Base
  include KeyImport
  # before_create :create_key

  class << self
    def key_type
      6
    end
  end
end
