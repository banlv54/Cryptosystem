class KeyPair < ActiveRecord::Base
  class << self
    def import_databases doc
      l = doc.length
      i = 0
      ActiveRecord::Base.transaction do
        while(i < l)
          KeyPair.find_or_create_by key: doc[i..i+1]
          i += 2
        end
      end
    end
  end
end
