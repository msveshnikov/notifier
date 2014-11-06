json.array!(@resources) do |resource|
  json.extract! resource, :id, :url, :last_updated, :hash_content
  json.url resource_url(resource, format: :json)
end
