class KeyDeca < ActiveRecord::Base
  include KeyImport
  # before_create :create_key

  class << self
    def key_type
      10
    end
  end
end