def spiral(n)
  area = n.to_i * n.to_i
  spiral = Array.new(n.to_i) { Array.new(n.to_i, 0) }

  if n.to_i % 2 != 0
    y = (n.to_i-1)/2
    x = (n.to_i-1)/2
  else
    y = (n.to_i/2)
    x = (n.to_i/2)-1
  end
  i = 1
  spiral[y][x] = 1
  x_max = x
  x_min = x
  y_max = y
  y_min = y
  a = x
  b = y
  puts(spiral.inspect)
  while i <= area
    # top
    for b in y_max.downto(y_min)
      spiral[a][b] = i
      i = i+1
      puts("top")
      puts(spiral.inspect)
      puts(i)
    end
    if y_min != -1
      y_min = y_min - 1
    end
    # right
    for a in x_min..x_max
      spiral[a][b] = i
      i = i+1
      puts("right")
      puts(spiral.inspect)
      puts(i)
    end
    if x_max != n.to_i - 1
      x_max = x_max + 1
    end
    #down
    for b in y_min..y_max
      spiral[a][b] = i
      i = i+1
      puts("down")
      puts(spiral.inspect)
      puts(i)
    end
    if y_max != n.to_i - 1
      y_max = y_max + 1
    end
    #left
    for a in x_max.downto(x_min)
      spiral[a][b] = i
      i = i+1
      puts("left")
      puts(spiral.inspect)
      puts(i)
    end
    if x_min != -1
      x_min = x_min - 1
    end
  end
  puts(spiral.inspect)
end
def main
  loop do
    puts("Введіть розмір спиральної матриці or exit")
    n = gets.chomp
    if n == "exit"
      break
    elsif n !~ /^\d+$/ || n.to_i <= 0
      puts("Помилка! Будь ласка, введіть число більше нуля")
    else
      spiral(n)
    end
  end
end
if __FILE__ == $0
  main
end