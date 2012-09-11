module PagesHelper

  def truncate_name(name, length = 21)
    truncate(name, :length => length)
  end
end
