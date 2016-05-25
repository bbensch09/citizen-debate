json.array!(@topic_tags) do |topic_tag|
  json.extract! topic_tag, :id, :debate_id, :topic_id
  json.url topic_tag_url(topic_tag, format: :json)
end
