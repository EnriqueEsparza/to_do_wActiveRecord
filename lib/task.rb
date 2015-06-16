class Task < ActiveRecord::Base
  belongs_to(:list)
  validates(:description, {:presence => true, :length => { :maximum => 50 }})
  before_save(:downcase_description)

  scope(:not_done, -> do
    where({:done => false})
  end)

private

  define_method(:downcase_description) do
    self.description=(description().downcase())
  end
end
