class EstimatesController < ApplicationController

  def index
    @custom_matchup = Estimate.custom_matchup(["Sanders", "Clinton", "Biden"])

    #these need to be made dynamically
    @sanders_array = Estimate.make_chart_array("Sanders", @custom_matchup)
    @clinton_array = Estimate.make_chart_array("Clinton", @custom_matchup)
    @biden_array = Estimate.make_chart_array("Biden", @custom_matchup)
    # binding.pry

    @linechart_dates = @custom_matchup.collect { |date,info| date.to_s}
    #put dates in ascending order
    @linechart_dates.reverse!
    @array_of_polls = nil
    #get count of number of candidates
    # arrays_needed = @custom_matchup.values[0].length


    @dem_estimate = Estimate.latest_dem_chart
    @gop_estimate = Estimate.latest_gop_chart

    @dem_candidates = @dem_estimate.collect {|can_hash| can_hash[:choice]}
    @dem_poll_numbers = @dem_estimate.collect {|can_hash| can_hash[:value]}

    @gop_candidates = @gop_estimate.collect {|can_hash| can_hash[:choice]}
    @gop_poll_numbers = @gop_estimate.collect {|can_hash| can_hash[:value]}
    
    respond_to do |format|
      format.html
      format.js
    end
  end

end
