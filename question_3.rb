cards = Array.new(100, 0)
(2..99).each do |num|
  (num..100).select { |k| k % num == 0 }.each { |j| cards[j-1] += 1 }
end
cards.each.with_index(1) { |card, idx| puts idx if card.even? }

=begin
Ruby - question_3.rb:6
1
4
9
16
25
36
49
64
81
[Finished in 0.418s]

正解したが、これも数学的な考え方を使えば、下記のように解ける。
「最終的に裏返し = 偶数回裏返し = 1以外の約数が偶数個ある」という命題に置き換えられる。
12 の約数: 1, 2, 3, 4, 6, 12 => 1 * 12 = 2 * 6 = 3 * 4 といったように2個ずつセットが作れるが、
16 の約数: 1, 2, 4, 8, 16 => 1 * 16 = 2 * 8 = 4 * 4 ということで、1個中央に平方根が残って奇数になる。
よって今回の答えが平方数になる、というのは数学的にわかる、というお話。

ちなみに解答例では、最初の Array に false を N 個入れてた、今思えばそれを toggle するのでもよかったかも。
今回の自分の解答では 1 以外の約数の数をカウントしていたため、index と 中身の数、という2種類の数が出てきたので混乱しやすそう。
=end
