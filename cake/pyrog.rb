def cake_split(input)
  cake = []

  rows = input.split("\n")
  for i in 0...rows.size              # .. для [], ... для [)
    cols = rows[i].split("")
    cake.push(cols)
  end
  puts("CAKE")
  puts cake.inspect
  rodzynki = input_check(cake)
  output_cake = cake
  for x in 0...cake.size
    for y in 0...cake[x].size
      if cake[x][y] == "o"
        output_cake[x][y] = "o"
      else
        output_cake[x][y] = "/"
      end
    end
  end
  puts("OUTPUTCAKE")
  puts output_cake.inspect

  output = piece_find(rodzynki, output_cake)
  puts("OUTPUT")
  puts output.inspect
end
def input_check(cake)
  rodzynki = []
  #координати родзинок і кількість + проверка
  for x in 0...cake.size
    for y in 0...cake[x].size
      puts "Перевіряємо символ: #{cake[x][y]} на позиції [#{x}, #{y}]"
      if cake[x][y] != "o" && cake[x][y] != "."
        puts("Помилка! Невірний символ: #{cake[x][y]} на позиції [#{x}, #{y}]")
        exit!
      elsif cake[x][y] == "o"
        rodzynki.push([x, y])
      end
    end
  end
  if rodzynki.size <= 1 && rodzynki.size > 10
    puts "Кількість родзинок не відповідає вимогам!"
    exit!
  end
  puts "Кількість родзинок: #{rodzynki.size}"
  puts "Координати родзинок: #{rodzynki.inspect}"
  puts "Площа пирога (рядки * стовпчики): #{cake.size} * #{cake[0].size} = #{cake.size * cake[0].size}"
  if cake.size * cake[0].size % rodzynki.size != 0
    puts("Помилка! Цей пиріг неможна поділити рівно :(")
    exit!
  else
  end
  rodzynki
end

def piece_find(rodzynki, output_cake)
  output = []
  for i in 0...rodzynki.size
    puts "Перевіряємо родзинку #{i+1}"
    x, y = rodzynki[i]
    left = y
    right = y
    top = x
    down = x
    cake_piece = find_down(top, down, right, left, output_cake, x, y, rodzynki)
    if !cake_piece.empty?
      output.push(cake_piece)
    else
      puts("\nПомилка! Цей пиріг не ділиться націло\n")
      exit!
    end
  end
  output
end

def find_left(top, down, right, left, output_cake, x, y, rodzynki)
  for left in (y).downto(0)
    puts "Проверяем элемент на позиции [#{x}, #{left}]"
    if left == y
      next
    elsif output_cake[x][left] == "/" && (((right + 1) - left) * ((down+1) - top)) == ((cake.size * cake[0].size) / rodzynki.size)
      puts "Прошел проверку"
      output_cake[x][left] = "."
      else
        puts "Встретили изюминку на позиции [#{x}, #{left}], прекращаем расширение вправо"
        break
    end
    puts("left")
    puts output_cake.inspect
  end
end

def find_right(top, down, right, left, output_cake, x, y, rodzynki)
  for right in (y)...(output_cake[0].size)
    find_left(top, down, right, left, output_cake, x, y, rodzynki)
    puts "Проверяем элемент на позиции [#{x}, #{right}]"
    if right == y
      next
    elsif output_cake[x][right] == "/" && ((right - left) * (down - top)) <= ((output_cake.size * output_cake[0].size) / rodzynki.size)
      puts "Прошел проверку"
      output_cake[x][right] = "."
    else
      puts "Встретили изюминку на позиции [#{x}, #{right}], прекращаем расширение вправо"
      break
    end
    puts("right")
    puts output_cake.inspect
  end
end

def find_top(top, down, right, left, output_cake, x, y, rodzynki)
  for top in (x).downto(0)
    find_right(top, down, right, left, output_cake, x, y, rodzynki)
    puts "Проверяем ряд на позиции [#{top}]"
    for a in 0...(output_cake[top].flatten.size)
      if output_cake.flatten[a] == "/"
        puts "в  елементе #{a} ряда #{top} нет изюма и его территории"
        temp = true
      else
        temp = false
          break
      end
    end
    if temp == true
        for j in left..right
          if (((right + 1) - left) * ((down+1) - top)) == ((cake.size * cake[0].size) / rodzynki.size)
            puts "Прошел проверку"
            output_cake[top][j] = "."
          else
           break
          end
        end
    end
  end
  puts("top")
  puts output_cake.inspect
end

def find_down(top, down, right, left, output_cake, x, y, rodzynki)
  for down in (x)...(output_cake.size)
    find_top(top, down, right, left, output_cake, x, y, rodzynki)
    puts "Проверяем ряд на позиции [#{down}]"
    for a in 0...(output_cake[down].flatten.size)
      if output_cake.flatten[a] == "/"
        puts "в  елементе #{a} ряда #{down} нет изюма и его территории"
        temp = true
      else
        temp = false
        break
      end
    end
    if temp == true
      for j in left..right
        if (((right + 1) - left) * ((down+1) - top)) == ((cake.size * cake[0].size) / rodzynki.size)
          puts "Прошел проверку"
          output_cake[down][j] = "."
        else
          break
        end
      end
    end
    puts("down")
    puts output_cake.inspect

    cake_piece = []
    if (((right + 1) - left) * ((down+1) - top)) == ((cake.size * cake[0].size) / rodzynki.size)
      puts "Условие выполняется: создаем cake_piece"
      for x in 0..(down - top)
        row = []
        for y in 0..(right - left)
          row.push(".")
        end
        cake_piece.push(row)
      end
      cake_piece[x - top][y - left] = "o"
      puts("cake_piece")
      puts cake_piece.inspect
      break
    end
  end
  cake_piece
end

puts("Введіть пирог+END або exitEND")
$/ = "END"
input = STDIN.gets
$/ = "\n"
input.chomp!("END")
input.strip!        #удалить лишнее
puts("\n\n")
puts(input)
puts("\n\n")
if input == "exit"
  exit
else
  cake_split(input)
end