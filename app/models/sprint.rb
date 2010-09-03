# encoding : utf-8
class DateRangeValidtor < ActiveModel::Validator
  def validate(record)
    if record.start_time > record.end_time
       record.errors.add('', I18n.t("activerecord.errors.invalid_date_range"))
    end
  end
end

class Sprint < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :project, :presence => true
  
  validates_with DateRangeValidtor

  belongs_to :project
  has_many :backlogs,:uniq => true
  has_many :tasks, :through => :backlogs
  has_many :tasks

end
