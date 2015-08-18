class Document < ActiveRecord::Base
  DEFAULT_ATTRIBUTES = [:content, :title]

  belongs_to :cipher
end
