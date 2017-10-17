# -*- mode:ruby; coding:utf-8 -*-
require 'fileutils'
require 'optparse'

# Album Meta Data
# 曲情報を記入して下さい
###################################################
album  = "Unknown Album"
artist   = "Unknown Artist"
year    = "2017"
genre  = "Soundtrack"
artwork_path = album+"\\images\\album_artwork.png"

track_no_delimiter = "."        #トラック番号を識別するための区切り文字
###################################################

# 文字エンコーディング対応がしんどいので一旦コメントアウト
# option = OptionParser.new
# option.on('--album ITEM', 'specified album name'){ |v| album = v.encode("UTF-8", "Shift_JIS") }
# option.on('--artist ITEM', 'specified artist name'){ |v| artist = v }
# option.on('-y', '--year ITEM', 'composed year'){ |v| year = v }
# option.on('-g', '--genre ITEM', 'specified genre'){ |v| genre = v }

# option.on('-d', '--delim ITEM', 'track number delimitor'){ |v| track_no_delimiter = v }
# option.on('--nameOnly', 'Encoded file name'){ |v| track_no_delimiter = v }
# option.parse(ARGV)


# AAC Settings
###################################################
aac_bitrate = "320"
###################################################

# MP3 Settings
###################################################
mp3_bitrate = "320"
###################################################

wav_path  = album+"/wav/"
aac_path  = album+"/m4a/"
mp3_path = album+"/mp3/"

files  = Dir.glob(wav_path + "*.wav")
tracks = files.count

files.each{ |file|

    #インデックスがあればトラックNoとして扱う  ex.)1.HogeHogeMusic.wav
    file_name = File.basename(file).gsub(".wav", "")

    track_no = 0
    if  file_name[/[0-9]+./, 0] != nil
        track_no =file_name[/[0-9]+./, 0].gsub(track_no_delimiter, "")
    end
    title     = file_name.gsub(/[0-9]+./, "")

    # AAC Encode
    if File.exist?('qaac64.exe')
        Dir.mkdir(aac_path) unless Dir.exist?(aac_path)
        aac_option = [
            "-c",           "\"#{aac_bitrate}\"",
            "--title",      "\"#{title}\"",
            "--artist",     "\"#{artist}\"",
            "--album",      "\"#{album}\"",
            "--band",       "\"#{artist}\"",
            "--composer",   "\"#{artist}\"",
            "--genre",      "\"#{genre}\"",
            "--date",       "\"#{year}\"",
            "--track",      "\"#{track_no}/#{tracks}\"",
            "--disk",       "1/1",
            "--artwork",    "#{artwork_path}",
            "\"#{file}\"",
            "-o",           "\"#{aac_path}#{file_name}.m4a\""
        ].join(" ")

        # 実行
        system("./qaac64.exe #{aac_option}")

        # 並列処理で実行  出力は崩れますがアルバム全体のエンコード時間は爆速
        # 有効にする場合は上の処理をコメントアウト
        # Thread.start {
        #     system("./qaac64.exe #{aac_option}")
        # }
    end

    
    # MP3 Encode

    if File.exist?('lame.exe')
        Dir.mkdir(mp3_path) unless Dir.exist?(mp3_path)
        mp3_option = [
            "-b",           "\"#{mp3_bitrate}\"",
            "--tt",         "\"#{title}\"",
            "--ta",         "\"#{artist}\"",
            "--tl",         "\"#{album}\"",
            "--tg",         "\"#{genre}\"",
            "--ty",         "\"#{year}\"",
            "--tn",         "\"#{track_no}/#{tracks}\"",
            "--ti",         "#{artwork_path}",
            "\"#{file}\"",
            "\"#{mp3_path}#{file_name}.mp3\""
        ].join(" ")

        # 実行
        system("./lame.exe #{mp3_option}")

        # 並列処理で実行  出力は崩れますがアルバム全体のエンコード時間は爆速
        # 有効にする場合は上の処理をコメントアウト
        # Thread.start {
        #     system("./lame.exe #{mp3_option_text}")
        # }
    end
}
