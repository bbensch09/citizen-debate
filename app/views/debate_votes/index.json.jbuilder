json.array!(@debate_votes) do |debate_vote|
  json.extract! debate_vote, :id, :user_id, :vote_for, :debate_id
  json.url debate_vote_url(debate_vote, format: :json)
end
