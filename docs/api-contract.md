# Medos Backend API Contract Draft

## Versioning
API prefix:

```text
/api/v1
```

Breaking change bo'lsa, yangi prefix:

```text
/api/v2
```

## Asosiy Endpointlar

### Auth/Profile
- `GET /api/v1/me`
- `PATCH /api/v1/me`

### Patients
- `GET /api/v1/patients`
- `POST /api/v1/patients`
- `GET /api/v1/patients/{patientId}`
- `PATCH /api/v1/patients/{patientId}`

### Encounters
- `POST /api/v1/encounters`
- `GET /api/v1/encounters/{encounterId}`
- `PATCH /api/v1/encounters/{encounterId}`
- `POST /api/v1/encounters/{encounterId}/diagnoses`

### Prescriptions
- `POST /api/v1/encounters/{encounterId}/prescriptions`
- `GET /api/v1/prescriptions/{prescriptionId}`
- `POST /api/v1/prescriptions/{prescriptionId}/items`
- `POST /api/v1/medication-intake-events`

### Catalog
- `GET /api/v1/catalog/medications`
- `GET /api/v1/catalog/protocols`

### Notifications
- `GET /api/v1/notifications`
- `POST /api/v1/notifications/{notificationId}/mark-read`

### Integrations
- `POST /api/v1/integrations/telegram/link`
- `POST /api/v1/integrations/telegram/webhook`

## Error Format
```json
{
  "error": {
    "code": "permission_denied",
    "message": "You do not have access to this patient.",
    "requestId": "req_..."
  }
}
```

## Backend Majburiyatlari
- User tokenini tekshirish.
- Role va organization accessni tekshirish.
- Tibbiy yozuvlar o'zgarishini auditga yozish.
- Notification ichida maxfiy diagnoz yoki dori nomini providerga keraksiz yubormaslik.
- Retsept va doza qoidalarini frontenddan mustaqil tekshirish.
