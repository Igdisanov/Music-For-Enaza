# Music-For-Enaza
1) Почему то ссылки cover не работают. https://static-cdn.enazadev.ru/ добавлял. Рабочие только coverUrl. Их и использовал, но они у свех треков и у Альбома одинаковые.
2) Чтобы музыка играла в фоновом режиме, необходимо в Info.plist добавить ключь Required background modes и в Item 0 прописать App plays audio or streams audio/video using AirPlay. Далее необходимо создать сессию AVAudioSession с помощью которой настраиваем воспроизведение музыки в фоновом режиме.
