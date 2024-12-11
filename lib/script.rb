# I provided 2 versions for each problem where one is Slightly more efficient
# while the other solution is more concise or more typical ruby code.
# The exercise didn't specify how much performance we want from this script 
# so I tried to have a bit of regards towards that :D
class Script
  class << self
    # There are prettier ways to do this, however the other methods
    # like running `.select` and them `.map` with `.uniq` are much slower
    # since we're iterating over the same array multiple times
    def find_reactivations(array)
      array
        .each_with_object({}) do |current, result|
          next unless current[:event] == 'reactivation'

          result[current[:account]] = true
        end
        .keys
    end

    # This is a more "ruby-like" solution but I'm not sure it's more performant
    def find_reactivations_v2(array)
      array
        .filter_map do |current|
          current[:account] if current[:event] == 'reactivation'
        end
        .uniq
    end

    # Slightly more efficient version as we're reducing the number of passes
    def find_more_than_one_cancellation(array)
      array
        .each_with_object(Hash.new(0)) do |current, result|
          next unless current[:event] == 'cancellation'

          result[current[:account]] += 1
        end
        .select { |_key, value| value > 1 }
        .keys
    end

    # More "ruby-like" solution
    def find_more_than_one_cancellation_v2(array)
      array
        .filter_map do |current|
          next unless current[:event] == 'cancellation'

          current[:account]
        end
        .tally
        .select { |_key, value| value > 1 }
        .keys
    end
  end
end
