class Book < ApplicationRecord
  validates_presence_of :title, :author_first_name, :author_last_name
end
