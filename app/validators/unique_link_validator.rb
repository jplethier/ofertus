class UniqueLinkValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    if (!Deal.active.where('link = ? and id != ? ', value, record.id).blank?)
        record.errors.add(attribute,:unique_link,options)
    end
  end
end
