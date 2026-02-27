---
trigger: always_on
---

# Flutter Clean Architecture + Riverpod + Supabase Rules (Compressed)

You are an expert in Flutter, Dart, Clean Architecture, Riverpod, Freezed, and Supabase. Follow these rules strictly.

---

# Core Principles

- Write concise, typed Dart code (no dynamic / any)
- Prefer functional & declarative patterns
- Prefer composition over inheritance
- Keep functions small (<30 lines), single-purpose
- No business logic inside widgets
- Keep side effects inside providers/use cases
- Use explicit types everywhere
- Use English for code and comments

---

# Architecture

Use **Clean Architecture + Feature-first structure**

Dependencies always point inward:
Presentation → Domain → Data

## Layers

### Domain
- Entities (pure, no framework deps)
- Repository interfaces
- Use cases
- Business rules
- Use `Either<Failure, T>`

### Data
- Repository implementations
- Data sources (Supabase)
- Models (DTOs)
- Map models → entities

### Presentation
- UI (Widgets)
- Riverpod providers
- No Supabase calls directly in UI

---

# Folder Structure

