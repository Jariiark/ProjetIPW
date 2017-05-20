class Feed < ApplicationRecord
has_many :entries, dependent: :destroy
 belongs_to :user
 validates :url, :presence => true
  validates :user_id, :presence => true
 default_scope { order('feeds.created_at DESC') }
 def self.update_from_feed(feed_url)
    feed = Feedjira::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
  end
  
  def self.update_from_feed_continuously(feed_url, delay_interval = 15.minutes)
    feed = Feedjira::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
    loop do
      sleep delay_interval
      feed = Feedjira::Feed.update(feed)
      add_entries(feed.new_entries) if feed.updated?
    end
  end
  
  private
  
  def self.add_entries(entries)
    Feed.all.each do |feed|
      content = Feedjira::Feed.fetch_and_parse(feed_url)
      content.entries.each do|entry|
        local_entry = feed.entries.where(title: entry.title).first_or_initialize
        local_entry.update_attributes(content: entry.content, author: entry.author, url: entry.url, published: entry.published)
         p "Synced Entry - #{entry.title}"
      end
      p "Synced Feed - #{feed.title}"
    end
      unless exists? :guid => feed.id
        create!(
          :name         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id
        )
      end
    end
  end

