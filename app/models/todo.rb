class Todo < ApplicationRecord
  PRIORITIES = { low: 0, medium: 1, high: 2 }.freeze

  validates :title, presence: true, length: { maximum: 120 }
  validates :priority, inclusion: { in: PRIORITIES.values }

  scope :ordered, -> { order(completed: :asc, priority: :desc, position: :asc, created_at: :desc) }
  scope :active, -> { where(completed: false) }
  scope :done, -> { where(completed: true) }
  scope :filtered, ->(filter) {
    case filter.to_s
    when "active" then active
    when "done" then done
    else all
    end
  }

  before_validation :assign_defaults, on: :create

  def priority_label
    PRIORITIES.key(priority)&.to_s || "medium"
  end

  def toggle!
    update!(completed: !completed)
  end

  def self.progress_percent
    total = count
    return 0 if total.zero?

    ((done.count.to_f / total) * 100).round
  end

  private

  def assign_defaults
    self.completed = false if completed.nil?
    self.priority = PRIORITIES[:medium] if priority.nil?
    self.position = (Todo.maximum(:position) || 0) + 1 if position.nil?
  end
end
