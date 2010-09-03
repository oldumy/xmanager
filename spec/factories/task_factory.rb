Factory.define :task, :class => Task  do |t|
  t.sequence(:name) { |n| "task_#{n+1}" }
  t.workload 3
  t.surplus_workload 3
  t.association :user
  t.description "Create a task correctly when giving valid attributes."
  t.association :project
end
