class Estimate < ActiveRecord::Base

  def self.latest_dem_chart
    Pollster::Chart.where(:topic => '2016-president-dem-primary').first.estimates
  end

  def self.latest_gop_chart
    Pollster::Chart.where(:topic => '2016-president-gop-primary').first.estimates
  end

  def self.biden_clinton_hash
    iw = Pollster::Chart.where(:topic => '2016-president-dem-primary')[1]
   return_hash = {}
    #Add all Iowa poll dates to hash
    iw.estimates_by_date.each do |estimate|
      return_hash[estimate[:date]] = {:biden => nil, :clinton => nil}
      # estimate[:estimates].select {|cand_hash| cand_hash[:choice] == "Biden"}
      # return_hash[estimate[:date]] = estimate[:estimates].select {|cand_hash| cand_hash[:choice] == "Clinton"}
    end

    iw.estimates_by_date.each do |estimate|
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
                binding.pry
    return_hash

  end

end

