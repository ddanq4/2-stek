def main_func(input)
  input_array = input.split
  output_array = []
  symbol_array = []
  for i in input_array
    if i.length != 1
      double_trouble = i.split("")
      for j in double_trouble
        if j !~ /\d/
          puts "Помилка! Подвійний символ"
          return
        end
      end
      output_array.push(i)
    elsif i =~ /\w/
      output_array.push(i)
    elsif i == "*" || i == "/"
      if !symbol_array.empty? && (symbol_array.last == "*" || symbol_array.last == "/")
        output_array.push(symbol_array.pop)
      end
      symbol_array.push(i)
    elsif i == "+" || i == "-"
      while !symbol_array.empty?
        output_array.push(symbol_array.pop)
      end
      symbol_array.push(i)
    else
      puts "Помилка! Неправильний символ"
      return
    end
  end
  while !symbol_array.empty?
    output_array.push(symbol_array.pop)
  end
  puts output_array.join(" ")
end

loop do
  puts "Введіть вираз з пробілами або exit для виходу"
  input = gets.chomp
  if input == "exit"
    break
  else
    main_func(input)
  end
end