# frozen_string_literal: true

require "rails_helper"

describe Queries::GetBooks, type: :request do
  def graphql_query
    <<~GRAPHQL
      query {
        getBooks {
          id
          title
          authorFirstName
          authorLastName
          description
        }
      }
    GRAPHQL
  end

  before do
    Book.create!(title: "Book1", author_first_name: "Author", author_last_name: "1", description: "description")
  end

  it "fetches books" do
    post "/graphql", params: { query: graphql_query }
    result = JSON.parse(response.body)
    expect(result["data"]["getBooks"].count).to eq 1
  end
end
