# Test_assignment
Тестовое задание для iOS разработчика 

Использованные библиотеки: Charts, RealmSwift, AnimatableReload
<h4>Задание для iOS разработчика<h4>
Получение и отображение курса биткойна по отношению к валютам (USD, EUR, KZT)
API: https://www.coindesk.com/api/ - Получение курса и истории изменения биткойна
https://www.bitstamp.net/api/ - Список последних транзакций для биткоина. При старте будет отображаться экран с TabBarController:

1) Первый экран отображает информацию о текущем курсе биткойна к выбранной
валюте. Валют будет 3 - Американский доллар (USD), Евро (EUR) и Тенге (KZT) . Ниже текущего курса валют будет отображаться график с переключением периода отображаемых данных: неделя, месяц и год. Особенность: При отображение информации за неделю данные выводятся на
каждый день. За месяц - отображается усредненный курс по неделям. При выборе отображения за год - отображается усредненное значение на каждый месяц. При смене Валюты график тоже должен меняться. 

2) Второй экран - список последних транзакций по покупке и продаже биткоинов. Необходимо отобразить список транзакций по биткоинам - выводимое количество ограничить 500 шт. Необходимо отобразить количество купленных или проданных биткоинов, дату и время транзакции, тип транзакции (покупка/продажа). При нажатии на транзакции - вывести подробную информацию о транзакции (количество, по какому курсу к доллару была покупка/продажа, дата и время транзакции, ID и на какую сумму проходила операция.). 3) Допик, конвертор валюты по курсу к биткоину. В зависимости от введенной суммы - отобразить сколько биткоинов можно купить или на какую сумму можно продать
биткоинов. Так же используется 3 валюты, описаные выше.

Приветствуется хороший UX.
