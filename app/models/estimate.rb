class Estimate < ActiveRecord::Base
  belongs_to :candidate

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
  def self.populate_date_hash(state_estimate, candidates)
  return_hash = {}
   self.load_iowa.estimates_by_date.each do |estimate|
      return_hash[estimate[:date]] = candidates.collect {|candidate| {candidate.to_sym => nil}}
      return_hash[estimate[:date]]
    end
    self.convert_to_hash(return_hash)
  end

  #Takes a hash with values that are an array of hashes and converts to one hash
  def self.convert_to_hash(input_hash)
     return_hash = {}
     input_hash.each do |date, can_array|
      return_hash[date] = can_array.reduce Hash.new, :merge
    end
    return_hash
  end

  #candidates is an array
  def self.custom_matchup(candidates)
    state = self.load_iowa
    return_hash = self.populate_date_hash(state, candidates)

    #add polls numbers for the candidates to the hash
    candidates.each do |candidate|
      state.estimates_by_date.each do |estimate|
        return_hash.each do |k,v|
          if k == estimate[:date]
             estimate[:estimates].each do |hash|
              if hash[:choice] == candidate
                return_hash[estimate[:date]][candidate.to_sym] = hash[:value]
              end
            end
          end
        end
      end
    end
    return_hash
  end

  #must be uppercase
  def self.make_chart_array(candidate, custom_matchup)
    holder = []
    custom_matchup.each do |date,can_hash|
      can_hash.each do |k,v|
        if k == candidate.to_sym
          holder << v.to_i
        end
      end
    end
    holder.push(candidate).reverse
  end

end

