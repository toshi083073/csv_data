class User < ApplicationRecord
  def self.import(path)
    list = []
    CSV.foreach(path, headers: true) do |row|
     list << {
          name: row["name"],
          age: row["age"],
          address: row["address"]
      }
    end
    puts "インポート開始"
    User.create！（list）
    puts "インポートに成功しました"
  rescue ActiveModel::UnknownAttributeError => invalid

    puts "インポートに失敗しました : #{invalid}"
  end
end
