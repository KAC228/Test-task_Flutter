# Flutter Order Creation Test Task

Тестовое задание на Flutter: экран создания заказа для мобильного приложения с REST API.

## Что реализовано

- модель `Order` с `fromJson`
- кастомное исключение `ApiException`
- HTTP-метод `createOrder(...)` с:
  - `async/await`
  - обработкой `200`
  - обработкой `400+`
  - обработкой отсутствия интернета
  - `timeout` 10 секунд
  - выбросом `ApiException` при ошибке
- `OrderController` со состояниями:
  - `initial`
  - `loading`
  - `success`
  - `error`
- экран, который:
  - отображает кнопку `Создать заказ`
  - показывает индикатор загрузки
  - выводит текст ошибки
  - блокирует кнопку во время запроса
  - позволяет повторить попытку после ошибки

## Архитектура

Проект разделен на простые слои:

- `data` — модель и источники данных
- `presentation` — контроллер состояния и UI
- `core` — общие ошибки

Так как в задании не был предоставлен реальный backend endpoint, в проект добавлены две реализации API:

- `HttpOrderApi` — реальный HTTP-клиент под контракт задания
- `MockOrderApi` — демонстрационная реализация для локального запуска и показа UI без backend

По умолчанию приложение использует `MockOrderApi`, чтобы проект можно было запустить и показать без внешнего сервера.

## Стек

- Flutter
- Dart
- http
- ChangeNotifier

## Структура проекта

```text
lib/
├─ app.dart
├─ main.dart
├─ core/
│  └─ errors/
│     └─ api_exception.dart
└─ features/
   └─ order/
      ├─ data/
      │  ├─ models/
      │  │  └─ order.dart
      │  └─ services/
      │     ├─ http_order_api.dart
      │     ├─ mock_order_api.dart
      │     └─ order_api.dart
      └─ presentation/
         ├─ controllers/
         │  └─ order_controller.dart
         ├─ screens/
         │  └─ order_screen.dart
         └─ widgets/
            └─ order_result_card.dart
```

## Запуск

1. Создать Flutter-проект в этой папке, если платформенные директории еще не созданы:

```bash
flutter create .
```

2. Установить зависимости:

```bash
flutter pub get
```

3. Запустить приложение:

```bash
flutter run
```

## Как переключиться на реальный API

В файле `lib/app.dart`:

- переключить `useMockApi` на `false`
- указать реальный `baseUrl` для `HttpOrderApi`

## Как быстро показать ошибку в демо-режиме

В файле `lib/app.dart`:

- оставить `useMockApi = true`
- выставить `simulateMockFailure = true`

## Тесты

Запуск тестов:

```bash
flutter test
```

Покрыты:

- `Order.fromJson`
- успешный и ошибочный сценарий `OrderController`

## Что можно улучшить

- добавить dependency injection
- вынести конфигурацию API через `--dart-define`
- добавить интеграционные тесты HTTP-слоя
- подключить state management уровня `Bloc` или `Riverpod`, если проект станет больше
