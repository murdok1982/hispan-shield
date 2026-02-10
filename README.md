# 🛡️ HispanShield - Mobile Threat Defense Platform

<div align="center">

![Python](https://img.shields.io/badge/Python-3.9+-blue.svg)
![FastAPI](https://img.shields.io/badge/FastAPI-0.104+-green.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Kotlin](https://img.shields.io/badge/Kotlin-1.9+-purple.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)
![Status](https://img.shields.io/badge/Status-Active-success.svg)

**Solución completa de seguridad móvil para Android con esteroides** 💪

[Características](#-características-principales) • [Instalación](#-instalación) • [Arquitectura](#-arquitectura) • [Donar](#-apoya-este-proyecto)

</div>

---

## 🎯 Visión General

HispanShield es una plataforma MTD (Mobile Threat Defense) de código abierto que combina análisis en dispositivo, inteligencia de amenazas y machine learning para proteger dispositivos Android contra amenazas avanzadas.

### ⚡ Características Principales

#### 🔍 Detección Avanzada
- **Análisis de SMS y Llamadas**: Detección de phishing y fraude en tiempo real
- **Escaneo de Aplicaciones**: Verificación de apps instaladas contra bases de datos de malware
- **Machine Learning**: Modelos ML con reentrenamiento automatizado
- **Threat Intelligence**: Integración con URLhaus, PhishTank y VirusTotal

#### 🛡️ Seguridad Reforzada
- **Anti-Tampering**: Detección de root, emuladores y debuggers
- **Privacy by Design**: Cifrado extremo a extremo y minimización de datos
- **MITRE ATT&CK Coverage**: Mapeo con framework ATT&CK for Mobile
- **Verificación de Integridad**: Validación de firma digital de aplicaciones

#### 📊 Monitoreo y Gestión
- **Dashboard Web**: Interface moderna con estadísticas en tiempo real
- **Base de Datos PostgreSQL**: Almacenamiento persistente de eventos y alertas
- **API RESTful**: Endpoints completos para integración
- **Auto-refresh**: Actualización automática de feeds cada hora

#### 🤖 Machine Learning Pipeline
- **Recolección Automatizada**: Datos etiquetados para entrenamiento
- **Versionado de Modelos**: Control de versiones y métricas de rendimiento
- **Reentrenamiento Programado**: Celery para tareas asíncronas
- **Activación Controlada**: Deployment seguro de nuevos modelos

---

## 📁 Estructura del Proyecto

```
hispan-shield/
├── backend/               # Backend Python con FastAPI
│   ├── app/
│   │   ├── api/          # REST API endpoints
│   │   ├── core/         # Configuración y seguridad
│   │   ├── ml/           # Modelos de Machine Learning
│   │   ├── models/       # Modelos SQLAlchemy
│   │   ├── schemas/      # Pydantic schemas
│   │   └── services/     # Lógica de negocio
│   │       └── threat_intel/  # CTI y MITRE ATT&CK
│   ├── dashboard/        # Dashboard web
│   ├── alembic/          # Migraciones de base de datos
│   └── requirements.txt
│
└── mobile_app/           # App móvil Flutter + Kotlin
    ├── android/          # Código nativo Android (Kotlin)
    │   └── app/src/main/
    │       ├── kotlin/   # BroadcastReceivers, MainActivity
    │       └── AndroidManifest.xml
    └── lib/
        ├── core/         # Servicios compartidos
        └── features/     # Módulos por funcionalidad
```

---

## 🚀 Instalación

### Requisitos Previos

- Python 3.9+
- PostgreSQL 15+
- Flutter 3.0+
- Android SDK
- Git

### Backend (Python FastAPI)

```bash
# Clonar el repositorio
git clone https://github.com/murdok1982/hispan-shield.git
cd hispan-shield/backend

# Crear entorno virtual
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Instalar dependencias
pip install -r requirements.txt

# Configurar base de datos PostgreSQL
# Editar variables de entorno en .env

# Ejecutar migraciones
alembic upgrade head

# Iniciar servidor
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

**Documentación API**: http://localhost:8000/docs

### Mobile App (Flutter + Kotlin)

```bash
cd mobile_app

# Instalar dependencias
flutter pub get

# Generar archivos nativos (si es necesario)
flutter create .

# Ejecutar en dispositivo/emulador
flutter run

# Build APK de producción
flutter build apk --release
```

---

## 🔐 Arquitectura de Seguridad

### Flujo de Datos

```
[Dispositivo Android]
       ↓ (HTTPS + TLS 1.3)
  [Backend FastAPI]
       ↓
  ┌────┴────┐
  ↓         ↓
[CTI Feeds] [ML Models]
  ↓         ↓
[PostgreSQL Database]
  ↓
[Dashboard Web]
```

### Componentes de Seguridad

1. **Hash de Datos Sensibles**: Números de teléfono hasheados con SHA-256
2. **Rules Engine**: Detección basada en reglas predefinidas
3. **MITRE Mapper**: Correlación con técnicas ATT&CK Mobile
4. **IOC Storage**: Base de indicadores de compromiso
5. **Correlation Engine**: Fusión de señales de múltiples fuentes

### 📊 Cobertura MITRE ATT&CK

| Técnica ID | Descripción | Estado |
|-----------|-------------|--------|
| T1476 | Deliver Malicious App via Other Means | ✅ Implementado |
| T1478 | Install Insecure or Malicious Configuration | ✅ Implementado |
| T1412 | Capture SMS Messages | ✅ Implementado |
| T1430 | Location Tracking | ✅ Implementado |
| T1533 | Data from Local System | ✅ Implementado |

---

## 📖 API Endpoints

### Autenticación
- `POST /api/v1/auth/device/register` - Registrar nuevo dispositivo
- `POST /api/v1/auth/device/token` - Obtener token de acceso

### Eventos
- `POST /api/v1/events/sms` - Ingestar evento SMS
- `POST /api/v1/events/call` - Ingestar evento de llamada
- `POST /api/v1/events/apps` - Batch de aplicaciones instaladas
- `GET /api/v1/events/stats` - Estadísticas de eventos

### Threat Intelligence
- `GET /api/v1/threat-intel/iocs` - Obtener IOCs actuales
- `POST /api/v1/threat-intel/lookup` - Buscar IOC específico

### Dashboard
- `GET /dashboard` - Dashboard web con métricas en tiempo real

### Health Check
- `GET /health` - Estado del servicio

---

## 🛡️ Privacidad y Protección de Datos

- ✅ **Sin almacenamiento de contenido completo**: Nunca guardamos texto íntegro de SMS
- ✅ **Hashing de PII**: Números de teléfono siempre hasheados
- ✅ **ML on-device**: Clasificación inicial en el dispositivo
- ✅ **Minimización de datos**: Solo metadata crítica al backend
- ✅ **Cifrado E2E**: Comunicaciones cifradas con TLS 1.3
- ✅ **GDPR Compliant**: Diseño conforme a regulaciones de privacidad

---

## 🧪 Testing

### Backend
```bash
cd backend
pytest tests/ -v --cov=app
```

### Mobile App
```bash
cd mobile_app
flutter test
flutter test integration_test/
```

---

## 🗺️ Roadmap

- [x] Backend FastAPI con PostgreSQL
- [x] Dashboard web en tiempo real
- [x] Integración CTI feeds (URLhaus, PhishTank, VirusTotal)
- [x] ML retraining pipeline
- [x] Anti-tampering detection
- [ ] JWT authentication completo
- [ ] Redis para caché distribuido
- [ ] TensorFlow Lite on-device
- [ ] CI/CD pipeline
- [ ] Soporte para iOS
- [ ] Dashboard móvil nativo

---

## 💰 Apoya Este Proyecto

¡Tu apoyo me ayuda a dedicar más tiempo al desarrollo de código abierto! 🙏

### Bitcoin (BTC)

![Bitcoin](https://img.shields.io/badge/Bitcoin-000000?style=for-the-badge&logo=bitcoin&logoColor=white)

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  ₿  Bitcoin Donation Address  ₿   ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                    ┃
┃   bc1qqphwht25vjzlptwzjyjt3sex    ┃
┃   7e3p8twn390fkw                   ┃
┃                                    ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

**Red**: Bitcoin (BTC)  
**Dirección**: `bc1qqphwht25vjzlptwzjyjt3sex7e3p8twn390fkw`

<div align="center">

![QR Code](https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=bitcoin:bc1qqphwht25vjzlptwzjyjt3sex7e3p8twn390fkw)

**Escanea el código QR para donar** 📱

</div>

---

## 📄 Licencia

Este proyecto está licenciado bajo la **Licencia MIT** - ver el archivo [LICENSE](LICENSE) para más detalles.

```
MIT License

Copyright (c) 2026 Gustavo Lobato Clara

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 👨‍💻 Autor

**Gustavo Lobato Clara**

- 🌐 LinkedIn: [gustavo-lobato-clara1982](https://www.linkedin.com/in/gustavo-lobato-clara1982/)
- 📧 Email: gustavolobatoclara@gmail.com
- 🐙 GitHub: [@murdok1982](https://github.com/murdok1982)
- 📍 Ubicación: Valencia, España
- 💼 Apasionado por la ciberseguridad y Python

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 🙏 Agradecimientos

- MITRE ATT&CK for Mobile framework
- URLhaus (abuse.ch)
- PhishTank (OpenDNS)
- VirusTotal API
- FastAPI community
- Flutter/Kotlin developers

---

<div align="center">

**⭐ Si este proyecto te resulta útil, considera darle una estrella en GitHub ⭐**

Hecho con ❤️ y ☕ en Valencia, España

</div>