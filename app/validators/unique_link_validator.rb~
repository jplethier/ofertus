class UniqueLinkValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    deal = Deal.active.where(link:value).first
    if (!deal.blank? && deal != record)
        record.errors.add(attribute,:unique_link,options)
    end
  end
end
