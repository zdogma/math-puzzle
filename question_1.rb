MIN_NUM = 10
MAX_NUM = 100_000

# (MIN_NUM..MAX_NUM).each do |num|
(MIN_NUM..MAX_NUM).select(&:odd?).each do |num|
  puts num if [num.to_s(10), num.to_s(2), num.to_s(8)].all? { |str| str == str.reverse }
end

=begin
# 改善ポイント
2進数において最大桁は0にはならないため、1桁目も必ず1 => 必ず奇数になる
っていうのをロジックに組み込めば、処理量は半分で済む

(MIN_NUM..MAX_NUM).select(&:odd?).each do |num|
  puts num if [num.to_s(10), num.to_s(2), num.to_s(8)].all? { |str| str == str.reverse }
end

# 奇数偶数両方を対象にした場合
Ruby - question_1.rb:5
585
[Finished in 0.214s]

# 奇数のみ対象にした場合
Ruby - question_1.rb:14
585
[Finished in 0.169s]
=end
