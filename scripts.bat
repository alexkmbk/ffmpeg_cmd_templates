//  Конвертация DVD файлов в один видео файл в h.264 формате видео и mp3 формате звука, контейнер mp4 
ffmpeg -i concat:"D:\VIDEO_TS\VTS_01_0.VOB|D:\VIDEO_TS\VTS_01_1.VOB|D:\VIDEO_TS\VTS_01_2.VOB|D:\VIDEO_TS\VTS_01_3.VOB|D:\VIDEO_TS\VTS_01_4.VOB|D:\VIDEO_TS\VTS_01_5.VOB" -loglevel panic -vcodec libx264 -threads 0 -b 2000k -acodec libmp3lame -ab 320k "D:\VIDEO_TS\compressed\out.mp4"

// Конвертация любых видео-файлов с расширением .MOV  в файл в h.264 формате видео и mp3 формате звука, контейнер mp4 
// обрабатываются все файлы в текущей директории а также во всех вложенных
// если для файла с расширением .mov уже существует соответствующий файл с расширением mp4, то он пропускается и не обрабатывается 
for /R %%G in (*.MOV) do IF NOT EXIST "D:\bin\ffmpeg\bin\%%~nG.mp4" ffmpeg -i "%%G" -loglevel panic -vcodec libx264 -threads 0 -b 2000k -acodec libmp3lame -ab 320k "D:\bin\ffmpeg\bin\%%~nG.mp4"


// Извлечение из любых файлов с расширением *.m4a аудиодорожек и сохранение в mp3 формате с битрейтом 256k. 
// обрабатываются все файлы в текущей директории, а также во всех вложенных
// если для файла с расширением .mov уже существует соответствующий файл с расширением mp4, то он пропускается и не обрабатывается 
for /R %%G in (*.m4a) do IF NOT EXIST "D:\bin\ffmpeg\bin\%%~nG.mp3" ffmpeg -i "%%G" -loglevel panic -acodec libmp3lame -ab 256k "D:\bin\ffmpeg\bin\%%~nG.mp3"

// Преобразование аудиофалов в видео с добавлением картинки
for /R %%G in (*.wav) do IF NOT EXIST "D:\bin\ffmpeg\bin\%%~nG.mkv" ffmpeg -loop 1 -r 2 -i "%%~nG.jpg" -i "%%~nG.wav" -vf scale=-1:380 -c:v libx264 -preset slow -tune stillimage -crf 18 -c:a copy -shortest -pix_fmt yuv420p -threads 0 "%%~nG.mkv"
