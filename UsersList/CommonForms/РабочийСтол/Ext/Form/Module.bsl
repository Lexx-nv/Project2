﻿
&НаКлиенте
Процедура КомандаЗаполнитьПользователей(Команда)
	ЗаполнитьПользователей();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПользователей()
	Если ЗначениеЗаполнено(ИнформационнаяБаза) Тогда
		ТекстОшибки = "";
		
		//Получим из регистра уже исключенных пользователей
		ТблИскл = ОбщегоНазначения.ПолучитьИсключенныхПользователей(ИнформационнаяБаза);
		
		//Получим таблицу работающих сотрудников
		Тбл = ОбщегоНазначения.ПолучитьРаботающих(ИнформационнаяБаза,ТекстОшибки);
		Если Тбл = 1 Тогда //Какой-то  косяк с получением данных из ЗУП
			Сообщить(ТекстОшибки);
			Возврат;
		КонецЕсли;	
		ТЗРаботающие.Загрузить(Тбл);
		Для Каждого ХХХ Из Тбл Цикл
			ХХХ.ФИО = ВРег(СтрЗаменить(ХХХ.ФИО," ","")); 
		КонецЦикла;	
		
		//Получим массив пользователей информационной базы
		СписокПользователей.Очистить();
		Мас = ОбщегоНазначения.ПолучитьПользователейИБ(ИнформационнаяБаза,ТекстОшибки);
		Если ТипЗнч(Мас) <> Тип("Массив") Тогда //Какой-то  косяк с получением списка пользователей
			Сообщить("Не удалось получить массив пользователей. " + ТекстОшибки);
			Возврат;
		КонецЕсли;	
		
		//Ну и начнем обработку данных
		Для каждого ХХХ Из Мас Цикл
			ПользовательКлючПоиска = ВРег(СтрЗаменить(ХХХ.ПолноеИмя," ","")); 
			
			нСтр = СписокПользователей.Добавить();
			ЗаполнитьЗначенияСвойств(нСтр,ХХХ);
			
			СтруктураПоиска = Новый Структура("ФИО", ПользовательКлючПоиска); 
			МассивНайденныхСтрок = ТБл.НайтиСтроки(СтруктураПоиска); 	
			нСтр.фРаботник = (МассивНайденныхСтрок.Количество() <> 0);
			
			СтруктураПоиска = Новый Структура("ПользовательКлючПоиска", ПользовательКлючПоиска); 
			МассивНайденныхСтрок = ТблИскл.НайтиСтроки(СтруктураПоиска); 	
			нСтр.фИсключаемый = (МассивНайденныхСтрок.Количество() <> 0);
		КонецЦикла;	
	КонецЕсли;	
КонецПроцедуры
