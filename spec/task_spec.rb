require("spec_helper")

describe(Task) do

  it("converts the name to lowercase") do
    task = Task.create({:description => "FINAGLE THE BUFFALO"})
    expect(task.description()).to(eq("finagle the buffalo"))
  end

  describe(".not_done") do
    it("returns the not done tasks") do
      not_done_task1 = Task.create({:description => "gotta do it", :done => false})
      not_done_task2 = Task.create({:description => "gotta do it too", :done => false})
      not_done_tasks = [not_done_task1, not_done_task2]
      done_task = Task.create({:description => "done task", :done => true})
      expect(Task.not_done()).to(eq(not_done_tasks))
    end
  end

  it("ensures the length of description is at most 50 characters") do
    task = Task.new({:description => "a".*(51)})
    expect(task.save()).to(eq(false))
  end

  it("validates presence of description") do
    task = Task.new({:description => ""})
    expect(task.save()).to(eq(false))
  end

  describe("#list") do
    it("tells which list it belongs to") do
      test_list = List.create({:name => "list"})
      test_task = Task.create({:description => "task", :list_id => test_list.id})
      expect(test_task.list()).to(eq(test_list))
    end
  end
end
