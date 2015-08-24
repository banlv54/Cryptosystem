class KeyPair < ActiveRecord::Base
  class << self
    def import_databases keys, doc
      l = doc.length
      i = 0
      ActiveRecord::Base.transaction do
        while(i < l)
          key = doc[i..i+1]
          if keys.exclude?(key)
            KeyPair.create key: key
            keys << key
          end
          i += 2
        end
      end
    end
  end
end
