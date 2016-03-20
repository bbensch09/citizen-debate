json.array!(@topic_votes) do |topic_vote|
  json.extract! topic_vote, :id, :value
  json.url topic_vote_url(topic_vote, format: :json)
end
