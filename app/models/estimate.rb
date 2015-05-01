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
  def self.populate_date_hash(estimate)
  return_hash = {}
   self.load_iowa.estimates_by_date.each do |estimate|
      return_hash[estimate[:date]] = {:biden => nil, :clinton => nil}
    end
    return_hash
  end

  def self.populate_hash_with_polls
    state = self.load_iowa
    return_hash = self.populate_date_hash(state)

    state.estimates_by_date.each do |estimate|
      return_hash.each do |k,v|

        if k == estimate[:date]
           return_hash[estimate[:date]][:clinton] = estimate[:estimates].find do |hash|
            hash[:choice] == "Clinton"
          end[:value]

          return_hash[estimate[:date]][:biden] = estimate[:estimates].find do |hash|
            hash[:choice] == "Biden"
          end

        end
      end
    end
    return_hash
    binding.pry
  end
end

