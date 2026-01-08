# 🧠 LearnCard AI - iOS Study App

**LearnCard AI** es una aplicación nativa para iOS que utiliza Inteligencia Artificial para transformar cualquier tema de estudio en tarjetas interactivas (flashcards) al instante.



---

## ✨ Características Principales

* **Generación con IA Open-Source:** Integración directa con **Pollinations.ai**. Genera cuestionarios educativos sin necesidad de API Keys ni registros.
* **Persistencia Local con SwiftData:** Almacenamiento eficiente y moderno de tus temas y tarjetas en la base de datos local del iPhone.
* **Edición Proactiva:** Interfaz de validación para revisar y corregir las preguntas generadas por la IA antes de guardarlas definitivamente.
* **Estudio Interactivo:** Sistema de tarjetas con **efecto Flip (rotación 3D)** y navegación gestual mediante carrusel.
* **Privacidad y Rendimiento:** Una vez generadas las tarjetas, el estudio es 100% offline y privado.

---

## 🛠️ Stack Tecnológico

| Tecnología | Propósito |
| :--- | :--- |
| **Swift 6.0** | Lenguaje de programación principal. |
| **SwiftUI** | Framework de interfaz de usuario declarativa. |
| **SwiftData** | Gestión de persistencia y modelos de datos. |
| **Pollinations.ai** | Motor de IA remoto (modelos Mistral/Llama). |
| **URLSession** | Comunicación de red asíncrona (Concurrency/Async-Await). |

---

## 🏗️ Arquitectura del Proyecto

La aplicación sigue un patrón de diseño que separa la comunicación externa de la persistencia interna:

1.  **PollinationsService:** Gestiona las peticiones HTTP. Utiliza el modelo de respuesta de OpenAI para obtener JSON estructurado.
2.  **DTO (Data Transfer Objects):** Estructuras `Codable` y `Sendable` que reciben la información de la IA sin interferir con la base de datos.
3.  **SwiftData Models:** Clases `@Model` que representan la estructura final de los datos en disco (`StudySet` y `Flashcard`).
4.  **Views:** Componentes SwiftUI reactivos que observan la base de datos mediante `@Query`.

---

## 🚀 Instalación y Uso

1.  **Requisitos:** Xcode 15+ e iOS 17+.
2.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/tu-usuario/learncard-ai.git](https://github.com/tu-usuario/learncard-ai.git)
    ```
3.  **Crea un proyecto y utiliza las clases de este repositorio. Cambia por el nombre de tu app donde está llamando a ContentView**.

---

## 📝 Notas de Implementación (Timeout Handling)

La aplicación incluye un control de errores avanzado para la API de Pollinations:
* **Timeout extendido:** Configuración de 90 segundos para permitir que la IA procese temas complejos.
* **JSON Strict Mode:** Forzado mediante parámetros de URL para garantizar que la decodificación sea exitosa.
* **MainActor Threading:** Todas las actualizaciones de la interfaz tras la llamada a la IA se ejecutan en el hilo principal para evitar bloqueos.
