class KeySingle < ActiveRecord::Base
  include KeyImport
  before_create :create_key

  class << self
    def key_type
      1
    end
  end
end
