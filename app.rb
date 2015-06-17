require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/task')
require('./lib/list')
also_reload('/lib/**/*.rb')
require('pg')
require('pry')



get('/') do
  @lists = List.all()
  erb(:index)
end

post('/') do
  name = params.fetch('name')
  list = List.new({:name => name, :id => nil})
  list.save()
  redirect back
end

get('/lists/:id') do
  @tasks = Task.all
  @list = List.find(params.fetch('id').to_i())
  @lists = List.all
  erb(:list)
end

post('/lists/:id') do

  list_id = params.fetch('list_id').to_i()
  description = params.fetch('description')
  @tasks = Task.all
  @list = List.find(list_id)
  description = params.fetch("description")
  @task = Task.new({:description => description, :list_id => list_id, :done => false})
    if @task.save()
      redirect back
    else
      erb(:errors)
    end
  end





get('/lists/:id') do

  @list = List.find(params.fetch("id").to_i)

  erb(:list)
end

patch('/lists/:id') do


  name = params.fetch('name')
  @list = List.find(params.fetch('id').to_i)
  @list.update({:name => name})
  @lists = List.all
  redirect back
end


delete('/') do
  @list = List.find(params.fetch("id").to_i)
  @list.delete
  @lists = List.all
  erb(:index)
end



get('/tasks/:id') do

  @task = Task.find(params.fetch("id").to_i)
  x = @task.list_id
  @list = List.find(x)

  erb(:edit_task)
end

patch("/tasks/:id") do
  @task = Task.find(params.fetch("id").to_i())
  description = params.fetch("description")
  @task.update({:description => description})
  redirect back
end

delete('/tasks/:id') do
  @task = Task.find(params.fetch("id").to_i)
  x = @task.list_id.to_i
  @list = List.find(x)
  @task.delete

  erb(:list)
end
