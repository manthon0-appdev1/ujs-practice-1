class Task < ApplicationRecord
  enum status: {not_yet_started: 0, in_progress: 1, completed: 2}

  belongs_to :owner, class_name: "User"
end
