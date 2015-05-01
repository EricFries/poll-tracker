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
      return_hash.find do |k,v|
        return_hash[k] == estimate[:date]
        puts return_hash[k]
      end

    end
    return_hash
  end

end

