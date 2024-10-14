def spiral(n)
  n = n.to_i
  area = n*n
  spiral = Array.new(n) { Array.new(n, 0) }
  if n % 2 != 0
    x = n/2
    y = n/2
  else
    x = n/2-1
    y = n/2-1
  end

  spiral[y][x] = 1
  i = 2
  step = 1
  while i <= area
                                   #right
    for k in 1..step
      x = x+1
      if x >= n
        x = n-1
        break
      end
      if spiral[y][x] == 0
        spiral[y][x] = i
        i = i+1
      end
    end
                                       #down
    for k in 1..step
      y = y+1
      if y >= n
        y = n-1
        break
      end
      if spiral[y][x] == 0
        spiral[y][x] = i
        i = i+1
      end
    end
    step = step + 1
                                         #left
    for k in 1..step
      x = x-1
      if x < 0
        x = 0
        break
      end
      if spiral[y][x] == 0
        spiral[y][x] = i
        i = i+1
      end
    end

                                   #up
    for k in 1..step
      y = y-1
      if y < 0
        y = 0
        break
      end
      if spiral[y][x] == 0
        spiral[y][x] = i
        i = i+1
      end
    end
    step = step + 1
  end

  # Выводим матрицу
  for row in spiral
    puts row.join(" ")
  end
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
