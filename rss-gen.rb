require 'date'
require 'digest/sha1'

GUID_FORMAT = '%s' * 8 + '-' + ('%s' * 4 + '-') * 3 + '%s' * 12
Article = Struct.new(:date, :name, :title) do
  def guid
    hash = Digest::SHA1.hexdigest(title)
    format(GUID_FORMAT, *hash.chars)
  end
end

articles = Dir['*.html'] - ['index.html']

articles.map! do |name|
  article = File.read(name).lines
  head = article[article.index { |line| line =~ /@═╦╣/ } + 2]
  title = 
    if head =~ /<meta/
      head.match(/content=\"(.*)\"/)[1]
    else
      head.match(/>(.*)</)[1]
    end
  date = Date.parse title
  Article.new(date, name, title)
end

articles.sort_by!(&:date).reverse!

File.write('feed.xml', <<~RSS)
  <?xml version="1.0" encoding="UTF-8" ?>
  <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>A mazing engineer</title>
    <description>Adventures and challenges, as written down by Phil Pirozhkov</description>
    <link>https://fili.pp.ru/</link>
    <language>en-us</language>
    <pubDate>#{articles.first.date.rfc2822}</pubDate>
    <lastBuildDate>#{Time.now.utc.to_date.rfc2822} </lastBuildDate>
    <atom:link href="https://fili.pp.ru/feed.xml" rel="self" type="application/rss+xml"/>
    #{
    articles.map do |article|
      <<~ITEM
        <item>
          <title>#{article.title}</title>
          <link>https://fili.pp.ru/#{article.name}</link>
          <pubDate>#{article.date.rfc2822}</pubDate>
          <guid isPermaLink="false">#{article.guid}</guid>
        </item>
      ITEM
    end.join
    }
  </channel>
  </rss>
RSS
