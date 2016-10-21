# 1に戻ることを前提とするならば、1になってからは 1=>4=>2=>1 を辿るため、元の数になることはない。
evens = (1..10_000).select(&:even?)
returns = []

evens.each do |even|
  target = even * 3 + 1

  (1..Float::INFINITY).each do |_|
    case target % 2
    when 0
      target /= 2
    when 1
      target = target * 3 + 1
    end

    if target == even
      returns << even
      break
    elsif target == 1
      break
    end
  end
end

puts returns.count
p returns

=begin
ヒントもあったし、コードに落とすのは難しくない。
case 文で書いてあるところは、下記のように三項演算子で書いてもよかった。
target = target.even? ? target / 2 : target * 3 + 1
=end
