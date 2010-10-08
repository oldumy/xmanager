Factory.define(:sprint_backlog, :class => SprintBacklog) do |b|
  b.sprint do |sprint|
    sprint = Sprint.find_by_name("Sprint 1") || Factory(:sprint_1)
  end
  b.product_backlog do |product_backlog|
    product_backlog = ProductBacklog.find_by_name("Create product backlogs") || Factory(:create_product_backlogs)
  end
end
