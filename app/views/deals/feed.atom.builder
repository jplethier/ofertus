atom_feed :language => 'en-US' do |feed|
  feed.title @title
  # feed.updated @updated

  @deals.each do |deal|
    feed.entry( deal ) do |entry|
      entry.url deal_url(deal)
      entry.title deal.title
      entry.content deal.description, :type => 'html'
    end
  end
end