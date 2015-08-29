module KeyImport
  extend ActiveSupport::Concern

  included do
    class << self
      def import_databases keys, doc
        l = doc.length
        i = 0
        doc.scan(/.{#{key_type}}|.{1}/).each do |key|
          if keys.exclude?(key)
            create key: key
            keys << key
          end
        end
      end

      def key_type
        1
      end
    end
  end
end
