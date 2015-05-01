class Estimate < ActiveRecord::Base

  def self.latest_dem_chart
    Pollster::Chart.where(:topic => '2016-president-dem-primary').first.estimates
  end

  def self.latest_gop_chart
    Pollster::Chart.where(:topic => '2016-president-gop-primary').first.estimates
  end

  def self.load_iowa
    Pollster::Chart.where(:topic => '2016-president-dem-primary')[1]
  end

  #Add all poll dates to hash
  def self.populate_date_hash(state_estimate, candidate1, candidate2)
  return_hash = {}
   self.load_iowa.estimates_by_date.each do |estimate|
      return_hash[estimate[:date]] = {candidate1.to_sym => nil, candidate2.to_sym => nil}
    end
    return_hash
  end

  def self.one_on_one_matchup(candidate1,candidate2)
    state = self.load_iowa
    return_hash = self.populate_date_hash(state, candidate1, candidate2)

    #add polls numbers for the 2 candidates to the hash
    state.estimates_by_date.each do |estimate|
      return_hash.each do |k,v|

        if k == estimate[:date]
           return_hash[estimate[:date]][candidate1.to_sym] = estimate[:estimates].find do |hash|
            hash[:choice] == candidate1
          end[:value]

           estimate[:estimates].each do |hash|
            if hash[:choice] == candidate2
              return_hash[estimate[:date]][candidate2.to_sym] = hash[:value]
            end
          end
        end
      end
    end
    return_hash
  end
end

