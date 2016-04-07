json.array!(@closing_statements) do |closing_statement|
  json.extract! closing_statement, :id, :author_id, :content, :round_id, :debate_id, :unread
  json.url closing_statement_url(closing_statement, format: :json)
end
