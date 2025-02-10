# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :author_first_name, String, null: false
    field :author_last_name, String, null: false
    field :description, String, null: true
  end
end
