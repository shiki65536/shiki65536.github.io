require 'rss'
require 'open-uri'
require 'fileutils'

MEDIUM_RSS = "https://medium.com/feed/@shiki65536"
OUTPUT_DIR = File.expand_path("../_medium", __dir__)  # 根目錄 _medium

FileUtils.mkdir_p(OUTPUT_DIR)

puts "Fetching Medium RSS feed..."
rss = RSS::Parser.parse(URI.open(MEDIUM_RSS).read, false)

rss.items.first(3).each do |item|
  title = item.title || "untitled"
  content = item.respond_to?(:content_encoded) ? item.content_encoded : item.description
  content = content || ""
  content_text = content.gsub(/<[^>]*>/, '').strip  # 去掉 HTML
  excerpt = content_text[0, 30]  # 前30個字
  pub_date = item.pubDate || Time.now
  link = item.link
  title_slug = title.gsub(/[^0-9A-Za-z.\-]/, "_")
  filename = "#{OUTPUT_DIR}/#{title_slug.downcase}.md"
  tags = item.categories ? item.categories.map(&:content) : []
  tags = ["medium"] if tags.empty?

  # 嘗試抓 Medium 預覽圖
  image_url = nil
  if item.respond_to?(:enclosure) && item.enclosure
    image_url = item.enclosure.url
  else
    # 嘗試從 description 找 <img>
    img_match = content.match(/<img.*?src="(.*?)"/)
    image_url = img_match[1] if img_match
  end
  image_url ||= "https://via.placeholder.com/350x200?text=Medium"

  File.open(filename, "w") do |f|
    f.puts "---"
    f.puts "layout: default"
    f.puts "title: \"#{title}\""
    f.puts "date: #{pub_date}"
    f.puts "excerpt: \"#{excerpt}\""
    f.puts "link: \"#{link}\""
    f.puts "image: \"#{image_url}\""
    f.puts "tags: [#{tags.map { |t| "\"#{t}\"" }.join(', ')}]"
    f.puts "---"
    f.puts content_text
  end

  puts "Imported: #{title} (excerpt: #{excerpt})"
end
