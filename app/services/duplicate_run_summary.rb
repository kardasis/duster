# used to duplicate an existing run at the current time in the case the
# iot device is fritzing
class DuplicateRunSummary
  def self.call(run_summary_id)
    @old_rs = RunSummary.find run_summary_id
    @run = Run.create_with_start_time Time.now.utc

    new_rs = dup_summary
    @old_rs.distance_records.each { |dr| new_rs.distance_records.create dr.attributes.except('id') }
    new_rs
  end

  def self.dup_summary
    RunSummary.create({ run: @run,
                        total_time: @old_rs.total_time,
                        total_distance: @old_rs.total_distance,
                        calories: @old_rs.calories,
                        start_time: Time.now.utc })
  end
end
