﻿
Процедура ПередЗаписью(Отказ)
	ПроверитьИспользуетсяЛиВПредметахСогласования(Отказ);
	ПроверитьУникальностьТипаОбъекта(Отказ);
КонецПроцедуры

Процедура ПроверитьИспользуетсяЛиВПредметахСогласования(Отказ)
	Если Отказ Тогда
		Возврат;
	Конецесли;
	Если ЭтоНовый() Тогда
		Возврат;
	Конецесли;
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	бпсПредметыСогласований.Ссылка
		|ИЗ
		|	Справочник.бпсПредметыСогласований КАК бпсПредметыСогласований
		|ГДЕ
		|	бпсПредметыСогласований.ТипОбъектаБД = &ТипОбъектаБД
		|	И НЕ бпсПредметыСогласований.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("ТипОбъектаБД", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Отказ = Истина;
		Сообщить("Ошибка! нельзя изменять тип объекта, т.к. он уже используется в предметах согласования");
	Конецесли;
КонецПроцедуры 

Процедура ПроверитьУникальностьТипаОбъекта(Отказ)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	бпсТипыОбъектовБД.ОбъектБДИмяМетаданных
	|ИЗ
	|	Справочник.бпсТипыОбъектовБД КАК бпсТипыОбъектовБД
	|ГДЕ
	|	ПОДСТРОКА(бпсТипыОбъектовБД.ОбъектБДИмяМетаданных, 1, 500) = &ОбъектБДИмяМетаданных
	|	И бпсТипыОбъектовБД.МенеджерОбъекта = &МенеджерОбъекта
	|	И бпсТипыОбъектовБД.Ссылка <> &Ссылка";
	
	Запрос.УстановитьПараметр("МенеджерОбъекта", МенеджерОбъекта);
	Запрос.УстановитьПараметр("ОбъектБДИмяМетаданных", ОбъектБДИмяМетаданных);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Отказ = Истина;
		Сообщить("Ошибка! уже есть такой тип объекта, два одинаковых быть не может");
	Конецесли;
КонецПроцедуры 
