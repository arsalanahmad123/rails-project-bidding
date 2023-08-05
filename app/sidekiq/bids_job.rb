class BidsJob
  include Sidekiq::Worker

  def perform(projects_ids)
    projects_ids.each do |project_id|
      project = Project.find_by(id: project_id)
      project.destroy if project&.bid_time.present? && project.bid_time < DateTime.now
      puts "Project #{project_id} deleted"
    end
  end
end
