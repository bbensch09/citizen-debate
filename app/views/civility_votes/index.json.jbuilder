json.array!(@civility_votes) do |civility_vote|
  json.extract! civility_vote, :id, :voter_id, :debate_id, :debater_id, :rating
  json.url civility_vote_url(civility_vote, format: :json)
end
