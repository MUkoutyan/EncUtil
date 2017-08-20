# 概要
wavからDL頒布用の音声ファイルをエンコードする為の補助ツールです。

マスターを指定のディレクトリに出力して実行するだけで、勝手に他のコーデックにエンコードしてくれます。

# 必須環境
ruby 2.4.0p0 

# 準備するディレクトリ構成
以下の様にディレクトリ構成を構築する必要があります。
```
[Working Directory]
┣ [AlbumTitle]
┃ ┃
┃ ┣━ [wav]        #元となるwavが置かれているディレクトリ
┃ ┃　　┗━ 1.HogeHogeMusic.wav 
┃ ┃
┃ ┗━ [images]
┃ 　　 ┗━ album_artwork.png   #ジャケット画像
┃
┣━ convert.rb   #スクリプトファイル
┣━ lame         #mp3エンコーダー
┗━ qaac         #aacエンコーダー
```

# エンコーダー
mp3エンコードに**lame**, aacエンコードに**qaac**を使用しています。

それぞれの必要なファイルを**convert.rb**と同階層に置いて下さい。

### lame (Windows)
* lame.exe
* lame_enc.dll

### qaac (Windows)
* libsoxconvolver.dll
* libsoxr.dll
* qaac.exe