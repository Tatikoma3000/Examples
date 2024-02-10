# code_examples
Разработан Чат-бот на базе Телеграм.
Чат-бот работает в 3х режимах:
	- Режим болталки;
	- Режим медицинской консультации;
	- Рассказывает шутки и анекдоты на заданную тематику.
Выбор режима общения происходит автоматически, на основании запроса пользователя.
Болталка поддерживается предобученной нейросетью TerraSpace.
Медициские ответы на вопросы, а также шутки на заданную тематику реализуются при помощи модели FastText.

Обратите вимание, что для запуска скрипта Вам необходимо получить API - токен для Телеграм.

Структура проекта:
(Для пунктов со * GitHub не дал загрузить-слишком тяжелые файлы. Недостающие файлы можно получить после запуска соответствующих скриптов)

- associations:
	1. Процедура загрузки датасета со словами-ассоциациями (были необходимы для обучения собственной кастомной болталки)
	2. Датасет слов-ассоциаций в формате .csv

- jokes:
	1. Датасет шуток в формате .json
	2. Процедура препроцессинга исходного датасета в формате .csv
	3. Датасет шуток в формате .csv
	4. Процедура обучения модели FastText для подбора наиболее релевантной шутки к заданной теме
	5. Обученная модель FastText *
	6. Датасет с выполненным препроцессингом в формате .dill

- medicine:
	1. Процедура скачивания исходного датасета и сохранения его на диск в формате .csv
	2. Датасет медицинских вопросов-ответов в формате .csv *
	3. Процедура обучения модели FastText для подбора наиболее релевантного ответа к заданному вопросу
	4. Обученная модель FastText *
	5. Датасет с выполненным препроцессингом в формате .dill *

- talker:
	1. Три процедуры скачивания исходных датасетов и сохранения их на диск в формате .csv
	2. Датасеты болталок в форматах .csv *
	3. Процедура обучения модели FastText для кастомной болталки
	4. Обученная модель FastText *
	5. Датасет с выполненным препроцессингом в формате .dill

- TeraSpace chat_bot:
	1. Процедура загрузки предобученной нейросети TerraSpace
	2. Токенайзер в формате .dill
	3. Предобученная нейросеть в формате .dill *

- Chat_bot_logistic_regression.ipynb: Процедура обучения логистической регрессии для выбора модели дальнейшего общения с пользователем: болталка, или медицина.

- logistic_regression_vectorizer.dill - Count-Vectorizer для логистической регрессии в формате .dill

- logistic_regression_med_talker_splitter.dill - Модель логистической регрессии в формате .dill

- Chat_bot_v3.ipynb - процедура запуска Чат-Бота

