json.array!(@opening_statements) do |opening_statement|
  json.extract! opening_statement, :id, :author_id, :content, :round_id, :debate_id, :unread
  json.url opening_statement_url(opening_statement, format: :json)
end
