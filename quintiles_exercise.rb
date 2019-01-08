require 'pp'
require 'pry'

def test_quintilization
  numbers_quintilized = split_into_quintiles(test_data)

  report_numbers_quintilized(numbers_quintilized)
end

def test_counts_per_quintile
  counts = [95, 100, 103, 104, 105, 110]

  report_counts_per_quintile( counts.map{ |x| [x, counts_per_quintile_for_n(x)] } )
end

def test_20th_percentile
  result = item_at_20th_percentile(test_data)

  puts "\n"
  puts "item at 20th percentile: #{result}"
end

def test_nth_percentile_at_20
  result = item_at_nth_percentile(test_data, 20)
  puts "\n"
  puts "test_nth_percentile_at_20"
  puts "result: #{result}"
end

def test_data
  numbers = []

  random = Random.new(1291230)

  103.times do
    numbers.push(random.rand(10000))
  end

  numbers
end

def report_counts_per_quintile(counts_per_quintile)
  counts_per_quintile.each do |item|
    puts "for N #{item[0]}, counts are #{item[1].join(', ')}"
  end
end

def item_at_20th_percentile(numbers)
  result = split_into_quintiles(numbers)[1].last
end

def item_at_nth_percentile(set, n)
  length = set.count
  distance = length * (n / 100.0)
  index = distance.ceil

  set.sort[ index ]
end

def item_at_nth_percentile_alt(set, n)
  result = split_into_bins(set, 100)

  result[20].last
end

def split_into_quintiles(numbers)
  output = {}
  numbers_sorted = numbers.sort

  counts = counts_per_quintile_for_n(numbers.count)

  offset = 0

  5.times.to_a.each_with_index do |i|
    count = counts[i]

    output[i + 1] = numbers_sorted.slice( offset, count )

    offset += count
  end

  output
end

def report_numbers_quintilized(input)
  input.keys.sort.each do |key|
    value = input[key]
    puts "\n"
    puts key
    puts "#{value.count} items"
    puts value.join(', ')
  end
end

def counts_per_quintile_for_n(n)
  remaining = n
  output = []

  while remaining > 0
    bins_left = 5 - output.count

    count = 
      bins_left == 0 ?
        remaining :
        (remaining.to_f / bins_left).ceil

    output.push count
  
    remaining = remaining - count
  end

  output
end

test_counts_per_quintile
test_quintilization
test_20th_percentile
test_nth_percentile_at_20
