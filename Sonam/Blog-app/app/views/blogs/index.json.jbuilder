json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :content, :date
  json.url blog_url(blog, format: :json)
end
