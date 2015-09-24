class KeyNona < ActiveRecord::Base
  include KeyImport
  # before_create :create_key

  class << self
    def key_type
      9
    end
  end
end
