# Mobile Threat Defense (MTD) Platform

## 🎯 Visión General

Solución completa de seguridad móvil para Android que combina:
- **Detección en Dispositivo**: Análisis de SMS, llamadas y aplicaciones
- **Threat Intelligence**: Correlación con feeds CTI y MITRE ATT&CK for Mobile
- **IA/ML**: Modelos de detección avanzada con reentrenamiento automatizado
- **Privacy by Design**: Minimización de datos y cifrado extremo a extremo
- **Dashboard Web**: Monitoreo en tiempo real y gestión centralizada
- **Base de Datos**: PostgreSQL con modelos relacionales completos
- **CTI Feeds**: Integración real con URLhaus, PhishTank, VirusTotal
- **Anti-Tampering**: Detección de root, emuladores y modificaciones

## ✨ Nuevas Características (Fase 6)

### 🗄️ Base de Datos PostgreSQL
- Modelos SQLAlchemy completos con relaciones
- Migraciones Alembic para control de versiones
- Pool de conexiones optimizado
- Almacenamiento persistente de eventos, alertas e IOCs

### 📊 Dashboard Web
- Interfaz moderna con estadísticas en tiempo real
- Visualización de alertas críticas
- Top threat indicators
- Métricas de modelos ML
- Auto-refresh cada 30 segundos

### 🤖 ML Retraining Pipeline
- Recolección automatizada de datos etiquetados
- Entrenamiento programado (Celery)
- Versionado de modelos
- Métricas de rendimiento (accuracy, precision, recall)
- Activación controlada de modelos

### 🌐 Real CTI Feeds
- URLhaus (malicious URLs feed)
- PhishTank (phishing database)
- VirusTotal API (hash lookup)
- Actualización automática cada hora

### 🛡️ Anti-Tampering
- Detección de root (múltiples métodos)
- Verificación de firma de app
- Detección de emuladores
- Detección de debugger
- Scoring de amenaza integrado


## 📁 Estructura del Proyecto

```
├── backend/               # Python FastAPI backend
│   ├── app/
│   │   ├── api/          # REST API endpoints
│   │   ├── core/         # Config y seguridad
│   │   ├── ml/           # Modelos ML
│   │   ├── schemas/      # Pydantic models
│   │   └── services/     # Lógica de negocio
│   │       └── threat_intel/  # CTI y MITRE
│   └── requirements.txt
│
└── mobile_app/           # Flutter Android app
    ├── android/          # Código nativo (Kotlin)
    │   └── app/src/main/
    │       ├── kotlin/   # Receivers, MainActivity
    │       └── AndroidManifest.xml
    └── lib/
        ├── core/         # Servicios compartidos
        └── features/     # Módulos por funcionalidad
```

## 🚀 Configuración Rápida

### Backend (Python)

```bash
cd backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

Accede a la documentación interactiva: http://localhost:8000/docs

### Mobile App (Flutter)

```bash
cd mobile_app
flutter pub get
flutter create .  # Genera archivos nativos si faltan
flutter run
```

## 🔐 Arquitectura de Seguridad

### Flujo de Datos

1. **Dispositivo → Backend**: Eventos hasheados con SHA-256
2. **Backend → CTI**: Consulta IOCs y mapeo MITRE
3. **Backend → IA**: Análisis con modelos ML
4. **Backend → Dispositivo**: Alertas y recomendaciones

### Componentes Clave

- **Rules Engine**: Detección estática basada en reglas
- **MITRE Mapper**: Correlación con ATT&CK Mobile
- **IOC Storage**: Base de indicadores de compromiso
- **Correlation Engine**: Fusión de múltiples señales

## 📊 MITRE ATT&CK Coverage

| Técnica | Descripción | Detección |
|---------|-------------|-----------|
| T1476 | SMS Phishing | ✅ NLP + URL analysis |
| T1478 | Install Malicious App | ✅ Signature + IOC lookup |
| T1412 | Capture SMS | ✅ Permission analysis |
| T1430 | Location Tracking | ✅ Permission anomaly |

## 🧪 Testing

### Backend
```bash
# Placeholder para tests unitarios
pytest tests/
```

### Mobile
```bash
flutter test
```

## 📖 API Endpoints

### Autenticación
- `POST /api/v1/auth/device/register` - Registro de dispositivo

### Eventos
- `POST /api/v1/events/sms` - Ingestar evento SMS
- `POST /api/v1/events/call` - Ingestar evento de llamada
- `POST /api/v1/events/apps` - Batch de apps instaladas

### Status
- `GET /health` - Health check
- `GET /api/v1/events/stats` - Estadísticas de eventos

## 🛡️ Privacidad

- **Sin almacenamiento de contenido**: Nunca guardamos el texto completo de SMS
- **Hashing**: Números de teléfono siempre hasheados con SHA-256
- **On-device ML**: Clasificación inicial en el dispositivo
- **Minimización**: Solo metadata crítica enviada al backend

## 🔧 Próximos Pasos

1. **Database Integration**: Migrar de almacenamiento en memoria a PostgreSQL
2. **JWT Real**: Implementar autenticación JWT completa con python-jose
3. **Redis**: Caché distribuido y rate limiting
4. **TF Lite**: Integrar modelos TensorFlow Lite en móvil
5. **CI/CD**: Pipeline de testing y deployment

## 📝 Licencia

Este es un proyecto de demostración arquitectónica.

## 🤝 Contribuciones

Ver [architecture_design.md](../brain/.../architecture_design.md) para detalles del diseño.
