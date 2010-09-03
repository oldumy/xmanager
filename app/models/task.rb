class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint
  belongs_to :user
  has_many :task_histories, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => {:scope => :project_id}
  validates :workload, :numericality => {:greater_than => 0}, :allow_nil => true
  validates :surplus_workload, :numericality => true, :allow_nil => true

  def update_task_progress(attr_list)
    if self.workload < attr_list[:surplus_workload].to_f
      self.errors[:surplus_workload] << 'cannot greater than workload'
    else
      begin
        if self.update_attributes(attr_list)
          update_history(Time.now.to_date);
          return true
        end
      rescue Exception
      end
    end
    return false
  end

  private

  def update_history(date)
    histories = self.task_histories
    history = histories.detect { |h| h.date == date }
    surplus_workload = self.surplus_workload
    if history.nil?
      TaskHistory.create(:date => date, :task => self, :surplus_workload => surplus_workload)
    else
      history.update_attribute(:surplus_workload, surplus_workload)
    end
  end
end
