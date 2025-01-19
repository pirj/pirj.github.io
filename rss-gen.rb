require 'date'
require 'digest/sha1'

GUID_FORMAT = '%s' * 8 + '-' + ('%s' * 4 + '-') * 3 + '%s' * 12
Article = Struct.new(:date, :name, :title, :headline) do
  def guid
    hash = Digest::SHA1.hexdigest(title)
    format(GUID_FORMAT, *hash.chars)
  end
end

articles = Dir['*.html'] - ['index.html']

articles.map! do |name|
  article = File.read(name).lines
  head = article[article.index { |line| line =~ /@/ } + 2]
  date = Date.parse head
  title = head.match(/>.*</)[0][1...-1]
  headline = article[article.index { |line| line =~ /@/ } + 6].strip
  headline.gsub!(/<[^>]*>/, '')
  Article.new(date, name, title, headline)
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
          <description>#{article.headline}</description>
          <pubDate>#{article.date.rfc2822}</pubDate>
          <guid isPermaLink="false">#{article.guid}</guid>
        </item>
      ITEM
    end.join
    }
  </channel>
  </rss>
RSS
