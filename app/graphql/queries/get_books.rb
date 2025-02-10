# frozen_string_literal: true

module Queries
  class GetBooks < Queries::BaseQuery
    description "Get all books"
    type [ Types::BookType ], null: false
    argument [id: ID], null: false

    def resolve(args)
      begin
        Book.find(id: args.id)
      rescue StandardError => e
        Rails.logger.error(e.message)
      end
    end
  end
end
