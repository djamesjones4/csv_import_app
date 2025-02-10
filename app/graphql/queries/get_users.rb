# frozen_string_literal: true

module Queries
  class GetUsers < Queries::BaseQuery
    description "Get all users"
    type [ Types::UserType ], null: true

    def resolve
      begin
        User.all
      rescue StandardError => e
        Rails.logger.error e.message
      end
    end
  end
end
