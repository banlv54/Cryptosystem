class KeyTriple < ActiveRecord::Base
  include KeyImport
  before_create :create_key

  class << self
    def key_type
      3
    end
  end
end
