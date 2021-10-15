{{/*
Return the postgresql host.
*/}}
{{- define "papercups.psql.host" -}}
  {{- if .Values.postgresql.install -}}
    {{- template "papercups.psql.fullname" . -}}
  {{- else if .Values.postgresql.external.enabled -}}
    {{- .Values.postgresql.external.host -}}
  {{- end -}}
{{- end -}}

{{/*
Override the fullname template of the subchart.
*/}}
{{- define "papercups.psql.fullname" -}}
{{- printf "%s-postgresql" .Release.Name -}}
{{- end -}}

{{/*
Return the db database name.
*/}}
{{- define "papercups.psql.database" -}}
{{- coalesce .databaseName .Values.global.postgresql.postgresqlDatabase "papercups" -}}
{{- end -}}

{{/*
Return the db username.
*/}}
{{- define "papercups.psql.username" -}}
{{- coalesce .Values.global.postgresql.postgresqlUsername "papercups" -}}
{{- end -}}

{{/*
Return the db port.
*/}}
{{- define "papercups.psql.port" -}}
{{- coalesce .Values.global.postgresql.servicePort 5432 -}}
{{- end -}}

{{/*
Return the secret name.
*/}}
{{- define "papercups.psql.password.secret" -}}
{{- default (include "papercups.psql.fullname" .) .Values.global.postgresql.existingSecret | quote -}}
{{- end -}}


{{/*
Return the name of the key in a secret that contains the postgres password.
*/}}
{{- define "papercups.psql.password.key" -}}
  {{- if .Values.postgresql.existingSecretKey -}}
    {{- .Values.postgresql.existingSecretKey -}}
  {{- else if (not (eq .Values.global.postgresql.postgresqlUsername "postgres")) -}}
postgresql-postgres-password
  {{- else -}}
postgresql-password
  {{- end -}}
{{- end -}}

{{/*
Determine if PostgreSQL is available
*/}}
{{- define "papercups.psql.available" -}}
{{- if or .Values.postgresql.external.enabled .Values.postgresql.install -}}
{{- print "true" -}}
{{- else -}}
{{- print "false" -}}
{{- end -}}
{{- end -}}

{{/*
Return the common database env variables.
              value: {{- print "ecto://" .Values.global.postgresql.postgresqlUsername -}}
              #value: "ecto://{{ .Values.global.postgresql.postgresqlUsername }}:{{ .Values.global.postgresql.postgresqlPassword }}@papercups-postgresql.default.svc.cluster.local/{{ .Values.global.postgresql.postgresqlDatabase }}"
*/}}
{{- define "papercups.psql.envs" -}}
- name: "DB_USER"
  value: "{{ template "papercups.psql.username" . }}"
- name: "DB_HOST"
  value: "{{ template "papercups.psql.host" . }}"
- name: "DB_PORT"
  value: "{{ template "papercups.psql.port" . }}"
- name: "DB_DATABASE"
  value: "{{ template "papercups.psql.database" . }}"
- name: "DB_PASSWORD"
  valueFrom:
    secretKeyRef:
      name: {{ template "papercups.psql.password.secret" . }}
      key: {{ template "papercups.psql.password.key" . }}
#- name: "DATABASE_URL"
#  valueFrom:
#    secretKeyRef:
#      name: {{ template "papercups.psql.password.secret" . }}
#      key: {{ template "papercups.psql.password.key" . }}
{{- end -}}
