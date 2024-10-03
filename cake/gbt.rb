def cake_split(input)
  cake = []

  # Разделяем пирог на строки и символы
  rows = input.split("\n")
  rows.each do |row|
    cols = row.split("")
    cake.push(cols)
  end

  puts("CAKE")
  puts cake.inspect

  # Проверяем количество родзинок и корректность ввода
  rodzynki = input_check(cake)

  # Инициализируем вывод с разделенными кусками
  output_cake = Array.new(cake.size) { Array.new(cake[0].size, "/") }

  # Размечаем родзинки в результирующем пироге
  rodzynki.each do |x, y|
    output_cake[x][y] = "o"
  end

  puts("OUTPUT CAKE INITIAL")
  puts output_cake.inspect

  # Разбиваем пирог на куски
  output = piece_find(cake, rodzynki, output_cake)
  puts("OUTPUT")
  puts output.inspect
end

def input_check(cake)
  rodzynki = []

  # Координаты родзинок и проверка корректности символов
  cake.each_with_index do |row, x|
    row.each_with_index do |cell, y|
      if cell != "o" && cell != "."
        puts("Ошибка! Неверный символ: #{cell} на позиции [#{x}, #{y}]")
        exit
      elsif cell == "o"
        rodzynki.push([x, y])
      end
    end
  end

  if rodzynki.size <= 1 || rodzynki.size > 10
    puts "Количество родзинок не соответствует требованиям!"
    exit
  end

  puts "Количество родзинок: #{rodzynki.size}"
  puts "Координаты родзинок: #{rodzynki.inspect}"
  puts "Площадь пирога: #{cake.size} * #{cake[0].size} = #{cake.size * cake[0].size}"

  if (cake.size * cake[0].size) % rodzynki.size != 0
    puts("Ошибка! Пирог невозможно разделить равномерно :(")
    exit
  end

  rodzynki
end

def piece_find(cake, rodzynki, output_cake)
  output = []

  # Размер каждого куска
  piece_area = (cake.size * cake[0].size) / rodzynki.size

  # Переменная для отслеживания, какие клетки уже распределены
  visited = Array.new(cake.size) { Array.new(cake[0].size, false) }

  # Определяем границы для каждого куска
  rodzynki.each do |start_x, start_y|
    current_piece = []

    # Используем поиск в ширину (BFS), чтобы найти область вокруг родзинки
    queue = [[start_x, start_y]]
    visited[start_x][start_y] = true
    current_piece.push([start_x, start_y])

    until queue.empty? || current_piece.size == piece_area
      x, y = queue.shift

      # Проверяем соседние клетки
      [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].each do |nx, ny|
        if nx >= 0 && nx < cake.size && ny >= 0 && ny < cake[0].size && !visited[nx][ny] && cake[nx][ny] != "o"
          queue.push([nx, ny])
          visited[nx][ny] = true
          current_piece.push([nx, ny])
          break if current_piece.size == piece_area
        end
      end
    end

    if current_piece.size == piece_area
      output.push(current_piece)
    else
      puts("Ошибка! Пирог не удается разделить на равные куски.")
      exit
    end
  end

  # Отмечаем куски в результирующем пироге
  output.each_with_index do |piece, index|
    piece.each do |x, y|
      output_cake[x][y] = (index + 1).to_s
    end
  end

  puts "Разделённый пирог:"
  output_cake.each { |row| puts row.join(" ") }

  output
end

# Основной цикл программы
loop do
  puts("Введите пирог (ввод заканчивается 'END' или 'exitEND')")
  $/ = "END"
  input = STDIN.gets
  $/ = "\n"
  input.chomp!("END")
  input.strip!

  if input == "exit"
    exit
  else
    cake_split(input)
  end
end
