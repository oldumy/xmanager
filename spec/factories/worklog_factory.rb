Factory.define(:worklog, :class => Worklog) do |l|
  l.remaining_hours 2
  l.description "Description of the worklog"
end
