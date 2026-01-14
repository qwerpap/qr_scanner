# Анализ логики Splash Screen

## 📊 Общая оценка: 7.5/10

---

## ✅ Сильные стороны

### 1. Clean Architecture
- **Правильная структура слоев**: Data → Domain → Presentation
- **Разделение ответственности**: DataSource → Repository → UseCase → Bloc
- **Domain слой независим от Flutter**: Использует только чистый Dart
- **Dependency Injection**: GetIt используется корректно

### 2. State Management
- **Bloc паттерн**: Правильное использование BLoC для бизнес-логики
- **События и состояния**: Четкое разделение событий и состояний
- **App-level scope**: `OnboardingBloc` предоставлен на уровне приложения

### 3. Навигация
- **GoRouter**: Используется `context.go()` вместо `push/pop`
- **Initial location**: Правильно установлен `/splash` как стартовая точка
- **Нет лишних PageRouteBuilder**: Используется только для transitions

### 4. Логирование
- **Talker Flutter**: Все действия логируются корректно
- **Уровни логирования**: info, error с stackTrace

### 5. Обработка ошибок в Data слое
- **Try-catch блоки**: Есть обработка ошибок в DataSource
- **Rethrow**: Ошибки пробрасываются наверх для обработки в Bloc

---

## ⚠️ Слабые стороны и проблемы

### 1. КРИТИЧНО: Несоответствие маршрутов навигации

**Проблема:**
```dart
// splash_screen.dart:40
if (state is OnboardingCompleted) {
  context.go('/scan-qr');  // ❌ Идет на /scan-qr
}

// onboarding_screen.dart:38
if (state is OnboardingCompleted) {
  context.go('/home');  // ❌ Идет на /home
}
```

**Последствия:**
- После завершения onboarding пользователь попадает на `/home`
- При следующем запуске (если onboarding completed) идет на `/scan-qr`
- Несогласованное поведение

**Рекомендация:**
Унифицировать маршрут. Либо везде `/scan-qr`, либо везде `/home`.

**Место в коде:**
- `lib/features/splash/presentation/view/splash_screen.dart:40`
- `lib/features/onboarding/presentation/view/onboarding_screen.dart:38`

---

### 2. КРИТИЧНО: Отсутствие обработки ошибок в SplashScreen

**Проблема:**
```dart
// splash_screen.dart:36-44
BlocListener<OnboardingBloc, OnboardingState>(
  listener: (context, state) {
    if (!_canNavigate) return;
    if (state is OnboardingCompleted) {
      context.go('/scan-qr');
    } else if (state is OnboardingNotCompleted) {
      context.go('/onboarding');
    }
    // ❌ Нет обработки OnboardingError
  },
)
```

**Последствия:**
- При ошибке чтения SharedPreferences пользователь остается на SplashScreen
- Нет fallback механизма
- Нет индикации ошибки пользователю

**Рекомендация:**
Добавить обработку `OnboardingError` с fallback на onboarding или retry механизм.

**Место в коде:**
- `lib/features/splash/presentation/view/splash_screen.dart:36-44`

---

### 3. Потенциальная блокировка UI при первом вызове SharedPreferences

**Проблема:**
```dart
// onboarding_local_datasource.dart:13
final prefs = await SharedPreferences.getInstance();
```

**Анализ:**
- `SharedPreferences.getInstance()` при первом вызове может быть медленным (особенно на Android)
- Хотя метод async, первый вызов может занять 50-200ms
- В текущей реализации это происходит в `initState` после 2-секундной задержки, что смягчает проблему

**Рекомендация:**
- Рассмотреть предзагрузку SharedPreferences в `main()` или при инициализации приложения
- Или добавить индикатор загрузки в SplashScreen

**Место в коде:**
- `lib/features/onboarding/data/datasources/onboarding_local_datasource.dart:13,26`

---

### 4. Отсутствие индикатора загрузки в SplashScreen

**Проблема:**
- Нет визуальной индикации процесса проверки onboarding
- Пользователь не видит, что происходит после 2-секундной задержки

**Рекомендация:**
Показывать индикатор загрузки при состоянии `OnboardingChecking`.

**Место в коде:**
- `lib/features/splash/presentation/view/splash_screen.dart:36-44`

---

### 5. Дублирование получения SharedPreferences

**Проблема:**
```dart
// В каждом методе вызывается getInstance()
final prefs = await SharedPreferences.getInstance();
```

**Анализ:**
- `SharedPreferences.getInstance()` кэшируется внутри пакета, но лучше явно кэшировать
- Не критично, но можно оптимизировать

**Рекомендация:**
Рассмотреть кэширование экземпляра SharedPreferences в DataSource.

**Место в коде:**
- `lib/features/onboarding/data/datasources/onboarding_local_datasource.dart`

---

### 6. Использование setState для флага навигации

**Проблема:**
```dart
// splash_screen.dart:19,26-28
bool _canNavigate = false;

setState(() {
  _canNavigate = true;
});
```

**Анализ:**
- Использование `setState` для бизнес-логики (хотя минимальное)
- Можно было бы использовать состояние Bloc

**Рекомендация:**
Не критично, но можно вынести в состояние Bloc для консистентности.

**Место в коде:**
- `lib/features/splash/presentation/view/splash_screen.dart:19,26-28`

---

### 7. Отсутствие таймаута для операции чтения

**Проблема:**
- Нет таймаута для чтения SharedPreferences
- При проблемах с хранилищем операция может висеть неопределенно долго

**Рекомендация:**
Добавить таймаут с fallback поведением.

**Место в коде:**
- `lib/features/onboarding/presentation/bloc/onboarding_bloc.dart:34`

---

## 🔧 Конкретные рекомендации по улучшению

### Приоритет 1 (Критично)

#### 1.1. Унифицировать маршруты навигации

**Изменение в `splash_screen.dart`:**
```dart
if (state is OnboardingCompleted) {
  context.go('/home');  // Изменить с '/scan-qr' на '/home'
}
```

**Или наоборот в `onboarding_screen.dart`:**
```dart
if (state is OnboardingCompleted) {
  context.go('/scan-qr');  // Изменить с '/home' на '/scan-qr'
}
```

**Рекомендация:** Использовать `/home`, так как это главный экран с навигацией.

---

#### 1.2. Добавить обработку ошибок в SplashScreen

**Изменение в `splash_screen.dart`:**
```dart
BlocListener<OnboardingBloc, OnboardingState>(
  listener: (context, state) {
    if (!_canNavigate) return;
    if (state is OnboardingCompleted) {
      context.go('/home');
    } else if (state is OnboardingNotCompleted) {
      context.go('/onboarding');
    } else if (state is OnboardingError) {
      // Fallback: показываем onboarding при ошибке
      context.go('/onboarding');
      // Или показываем диалог с ошибкой и retry
    }
  },
)
```

---

### Приоритет 2 (Важно)

#### 2.1. Добавить индикатор загрузки

**Изменение в `splash_screen.dart`:**
```dart
BlocBuilder<OnboardingBloc, OnboardingState>(
  builder: (context, state) {
    if (state is OnboardingChecking) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(...);
  },
)
```

---

#### 2.2. Добавить таймаут для чтения SharedPreferences

**Изменение в `onboarding_bloc.dart`:**
```dart
Future<void> _onCheckOnboardingStatus(...) async {
  try {
    emit(const OnboardingChecking());
    _talker.info('Checking onboarding status');

    final isCompleted = await _checkOnboardingCompletedUseCase()
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            _talker.warning('Timeout reading onboarding status');
            return false; // Fallback: считаем onboarding не пройденным
          },
        );

    if (isCompleted) {
      _talker.info('Onboarding already completed, navigating to home');
      emit(const OnboardingCompleted());
    } else {
      _talker.info('Onboarding not completed, navigating to onboarding');
      emit(const OnboardingNotCompleted());
    }
  } catch (e, stackTrace) {
    _talker.error('Error checking onboarding status', e, stackTrace);
    emit(OnboardingError(e.toString()));
  }
}
```

---

### Приоритет 3 (Оптимизация)

#### 3.1. Кэширование SharedPreferences

**Изменение в `onboarding_local_datasource.dart`:**
```dart
class OnboardingLocalDataSource {
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  final Talker _talker;
  SharedPreferences? _prefs;

  OnboardingLocalDataSource({required Talker talker}) : _talker = talker;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<bool> isOnboardingCompleted() async {
    try {
      _talker.info('Checking onboarding status from SharedPreferences');
      final prefs = await _getPrefs();
      final result = prefs.getBool(_keyOnboardingCompleted) ?? false;
      _talker.info('Onboarding status: $result');
      return result;
    } catch (e, stackTrace) {
      _talker.error('Error reading onboarding status', e, stackTrace);
      rethrow;
    }
  }
}
```

---

## 📝 Итоговая оценка по критериям

| Критерий | Оценка | Комментарий |
|----------|--------|-------------|
| Clean Architecture | 9/10 | Отличная структура, небольшие оптимизации возможны |
| Навигация | 7/10 | Правильное использование GoRouter, но несоответствие маршрутов |
| Обработка ошибок | 5/10 | Есть в Data/Bloc, но нет в UI (SplashScreen) |
| Блокировка UI | 8/10 | Минимальная, но можно оптимизировать |
| Логирование | 10/10 | Отлично реализовано |
| Читаемость кода | 9/10 | Чистый, понятный код |
| Повторный показ onboarding | 8/10 | Логика правильная, но нет обработки ошибок |

---

## 🎯 План действий

1. **Немедленно:**
   - Унифицировать маршруты навигации
   - Добавить обработку `OnboardingError` в SplashScreen

2. **В ближайшее время:**
   - Добавить индикатор загрузки
   - Добавить таймаут для чтения SharedPreferences

3. **Оптимизация:**
   - Кэширование SharedPreferences
   - Предзагрузка SharedPreferences в main()

---

## 📍 Конкретные места кода для изменений

1. `lib/features/splash/presentation/view/splash_screen.dart:40` - изменить маршрут
2. `lib/features/splash/presentation/view/splash_screen.dart:36-44` - добавить обработку ошибок
3. `lib/features/onboarding/presentation/view/onboarding_screen.dart:38` - проверить маршрут
4. `lib/features/onboarding/presentation/bloc/onboarding_bloc.dart:34` - добавить таймаут
5. `lib/features/onboarding/data/datasources/onboarding_local_datasource.dart` - кэширование

---

**Вывод:** Реализация в целом хорошая, соблюдена Clean Architecture, но есть критические проблемы с навигацией и обработкой ошибок, которые нужно исправить в первую очередь.
