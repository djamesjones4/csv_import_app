# frozen_string_literal: true

require "rails_helper"

describe Queries::GetUsers, type: :request do

  def graphql_query
    <<~GRAPHQL
      query {
        getUsers {
          id
          firstName
          lastName
          email
        }
      }
    GRAPHQL
  end

  context "when users exist" do
    before do
      # seed user
      User.create!(first_name: "John", last_name: "Doe", email: "john@doe.com")
      post "/graphql", params: { query: graphql_query }
    end

    it "returns all users" do
      result = JSON.parse(response.body)
      expect(result["data"]["getUsers"].count).to eq(1)
    end
  end

end
