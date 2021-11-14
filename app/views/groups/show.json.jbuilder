json.array!(@plans) do |plan|
  json.extract! plan, :id, :title, :body
  json.color plan.user.color
  json.url plan_url(plan, format: :html)
  if plan.ifrepeat == 1
    json.dow [plan.dow]
    json.start plan.start_time_dow
    json.end plan.finish_time_dow
    json.title plan.title + '(定期)'
  else
    json.start plan.start_time
    json.end plan.finish_time
  end
end

json.array!(@grplans) do |plan|
  json.extract! plan, :id, :title, :body
  json.color "gray"
  json.url grplan_url(plan, format: :html)
  if plan.ifrepeat == 1
    json.dow [plan.dow]
    json.start plan.start_time_dow
    json.end plan.finish_time_dow
    json.title '(グループ)' + plan.title + '(定期)'
  else
    json.title '(グループ)' + plan.title
    json.start plan.start_time
    json.end plan.finish_time
  end
end