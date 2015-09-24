class KeyHepta < ActiveRecord::Base
  include KeyImport
  # before_create :create_key

  class << self
    def key_type
      7
    end
  end
end
