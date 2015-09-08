class KeyPair < ActiveRecord::Base
  include KeyImport
  before_create :create_key

  class << self
    def key_type
      2
    end
  end
end
