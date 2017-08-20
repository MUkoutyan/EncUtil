# -*- mode:ruby; coding:utf-8 -*-
require 'fileutils'

p ARGV[0]

# Album Meta Data
###################################################
album  =  ARGV[0] == nil ? "Unknown Album" : ARGV[0]
artist = "Unknown Artist"
year   = "2017"
genre  = "Soundtrack"
artwork_path = album+"\\images\\album_artwork.png"
###################################################

# AAC Settings
###################################################
aac_bitrate = "320"
###################################################

# MP3 Settings
###################################################
mp3_bitrate = "320"
###################################################

wav_path = album+"/wav/"
aac_path = album+"/m4a/"
mp3_path = album+"/mp3/"

files  = Dir.glob(wav_path + "*.wav")
tracks = files.count
files.each{ |file|

    #インデックスがあればトラックNoとして扱う  ex.)1.HogeHogeMusic.wav
    file_name = File.basename(file).gsub(".wav", "")
    track_no  = file_name[/[0-9]+./, 0].gsub(".", "")
    title     = file_name.gsub(/[0-9]+./, "")

    # AAC Encode
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
    puts aac_option
    system("./qaac64.exe #{aac_option}")

    
    # MP3 Encode
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
    puts mp3_option
    system("./lame.exe #{mp3_option}")
}
