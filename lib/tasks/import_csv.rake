require 'csv'

namespace :import_csv do
  #rake import_csv:users
  desc "User CSVデータのインポート"

  task users: :environment do
    path = File.join Rails.root, "db/csv_data/user_data.csv"
    list = []
   # CSVファイルからインポートするデータを取得し配列に格納
   CSV.foreach(path, headers: true) do |row|
     list << {
         name: row["name"],
         age: row["age"],
         address: row["address"]
     }
  end
   puts "インポート処理を開始".red
   # インポートができなかった場合の例外処理
   begin
      User.transaction do
        # 例外が発生する可能性のある処理
        User.create!(list)
      end
      # 正常に動作した場合の処理
      puts "インポート完了!!".green
    # 例外処理
    rescue ActiveModel::UnknownAttributeError => invalid
      # 例外が発生した場合の処理
      # インポートができなかった場合の例外処理
      puts "インポートに失敗：UnknownAttributeError".red
    end
  end
end
