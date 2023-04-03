{{/*
Expand the name of the chart.
*/}}
{{- define "pulsar-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pulsar-operator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pulsar-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pulsar-operator.labels" -}}
{{ include "pulsar-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "pulsar-operator.chart" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pulsar-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pulsar-operator.name" . }}
{{- end }}

{{/*
Create the name of the operator role to use
*/}}
{{- define "pulsar-operator.roleName" -}}
{{- default (include "pulsar-operator.fullname" .) .Values.rbac.operatorRole.name }}
{{- end }}

{{/*
Create the name of the operator role binding to use
*/}}
{{- define "pulsar-operator.roleBindingName" -}}
{{- default "default" .Values.rbac.operatorRoleBinding.name }}
{{- end }}

{{/*
Create the name of the operator service account to use
*/}}
{{- define "pulsar-operator.serviceAccountName" -}}
{{- default (include "pulsar-operator.fullname" .) .Values.serviceAccount.name }}
{{- end }}
