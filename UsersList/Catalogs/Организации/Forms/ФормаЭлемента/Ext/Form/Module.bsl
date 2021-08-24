﻿//&НаКлиенте
//Процедура КомандаПроверитьПодключениеБух(Команда)
//	СткЗапроса = ПолучитьСткЗапроса();
//	СткЗапроса.АдресСервера = Объект.АдресСервераБух;
//	СткЗапроса.НаименованиеБазы = Объект.НаименованиеБазыБух;
//	СткЗапроса.Логин = Объект.ЛогинБух;
//	СткЗапроса.Пароль = Объект.ПарольБух;
//	//СткЗапроса.АПИ = "ksAPI";
//	//СткЗапроса.АПИ = "invAPI";
//	СткЗапроса.АПИ = Объект.АПИБух;
//	СткЗапроса.ИмяМетода = "TEST";
//	ПроверитьПодключение(СткЗапроса);
//КонецПроцедуры

//&НаКлиенте
//Процедура КомандаПроверитьПодключениеЗУП(Команда)
//	ТекДанные = Элементы.ДанныеЗУП.ТекущиеДанные;
//	СткЗапроса = ПолучитьСткЗапроса();
//	СткЗапроса.АдресСервера = ТекДанные.АдресСервераЗУП;
//	СткЗапроса.НаименованиеБазы = ТекДанные.НаименованиеБазыЗУП;
//	СткЗапроса.Логин = ТекДанные.ЛогинЗУП;
//	СткЗапроса.Пароль = ТекДанные.ПарольЗУП;
//	//СткЗапроса.АПИ = "ksAPI";
//	//СткЗапроса.ИмяМетода = "GETFL";
//	СткЗапроса.АПИ = "zupAPI";
//	СткЗапроса.ИмяМетода = "TEST";
//	ПроверитьПодключение(СткЗапроса);
//КонецПроцедуры

//&НаКлиенте
//Процедура КомандаПроверитьПодключениеУАТ(Команда)
//	СткЗапроса = ПолучитьСткЗапроса();
//	СткЗапроса.АдресСервера = Объект.АдресСервераУАТ;
//	СткЗапроса.НаименованиеБазы = Объект.НаименованиеБазыУАТ;
//	СткЗапроса.Логин = Объект.ЛогинУАТ;
//	СткЗапроса.Пароль = Объект.ПарольУАТ;
//	СткЗапроса.АПИ = "entAPI";
//	СткЗапроса.ИмяМетода = "TEST";
//	ПроверитьПодключение(СткЗапроса);
//КонецПроцедуры

//&НаКлиенте
//Процедура ПроверитьПодключение(СткЗапроса)
//	Результат = ОбщегоНазначения.ВыполнитьЗапрос(СткЗапроса);
//	Если Результат <> "Ошибка" Тогда
//		ПоказатьПредупреждение(,"Подключение прошло успешно!",,"ВНИМАНИЕ!!!");
//	Иначе
//		ПоказатьПредупреждение(,"Подключение не удалось!",,"ВНИМАНИЕ!!!");
//	КонецЕсли;	
//КонецПроцедуры

//&НаКлиенте
//Функция ПолучитьСткЗапроса();
//	Возврат Новый Структура("АдресСервера,НаименованиеБазы,Логин,Пароль,АПИ,ИмяМетода");
//КонецФункции

//&НаКлиенте
//Процедура КомандаПолучитьРаботающих(Команда)
//	ТекДанные = Элементы.ДанныеЗУП.ТекущиеДанные;
//	СткЗапроса = ПолучитьСткЗапроса();
//	СткЗапроса.АдресСервера = ТекДанные.АдресСервераЗУП;
//	СткЗапроса.НаименованиеБазы = ТекДанные.НаименованиеБазыЗУП;
//	СткЗапроса.Логин = ТекДанные.ЛогинЗУП;
//	СткЗапроса.Пароль = ТекДанные.ПарольЗУП;
//	СткЗапроса.АПИ = "zupAPI";
//	СткЗапроса.ИмяМетода = "GETRABSOTR";
//	ПолучитьРаботающих(СткЗапроса);
//КонецПроцедуры

//&НаСервере
//Процедура ПолучитьРаботающих(СткЗапроса)
//	ТБл = ПолучитьКадрТбл(СткЗапроса);
//КонецПроцедуры



//&НаСервере
//Функция ПолучитьКадрТбл(СткЗапроса)
//	СтруктураПараметров = Новый Структура; // Все параметры необязательные, но если не задать ИНН организации ==> ответ пустой
//	СтруктураПараметров.Вставить("ИННОрганизации",Объект.ИНН); 
//	
//	// Работавшие за период:
//	СтруктураПараметров.Вставить("НачПериода",ТекущаяДата());
//	СтруктураПараметров.Вставить("КонПериода",ТекущаяДата()); // срез данных всегда ведётся на КонПериода
//	
//	//СтруктураПараметров.Вставить("Категории","Водители и механизаторы");
//	СтруктураПараметров.Вставить("Категории","Руководители, Специалисты"); // можно через запятую
//	
//	Соединение1С82 = Новый HTTPСоединение(СткЗапроса.АдресСервера,80,СткЗапроса.Логин,СткЗапроса.Пароль);
//	
//	Body = XMLСтрока(Новый ХранилищеЗначения(СтруктураПараметров, Новый СжатиеДанных(-1)));
//	
//	Запрос = Новый HTTPЗапрос("/" + СткЗапроса.НаименованиеБазы + "/hs/zupAPI/GETRABSOTR");
//	
//	Запрос.Заголовки.Вставить("Content-Type","text/html; charset=utf-8");
//	Запрос.УстановитьТелоИзСтроки(Body);
//	Ответ = Соединение1С82.ОтправитьДляОбработки(Запрос);
//	КодСостояния = Ответ.КодСостояния;
//	Body = Ответ.ПолучитьТелоКакСтроку();
//	
//	Если КодСостояния = "200" или КодСостояния = 200 Тогда
//		Попытка
//			ХЗ = XMLЗначение(Тип("ХранилищеЗначения"),Body);
//			Результат = ХЗ.Получить();
//		Исключение
//			Результат = Неопределено;
//		КонецПопытки;
//	Иначе
//		Сообщить("Код состояния = " + КодСостояния + " ... " + Body);
//	КонецЕсли;
//	
//	Возврат Результат;
//КонецФункции
