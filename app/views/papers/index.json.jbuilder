json.array!(@papers) do |paper|
  json.extract! paper, :id, :title, :venue, :year
  json.url paper_url(paper, format: :json)
end
