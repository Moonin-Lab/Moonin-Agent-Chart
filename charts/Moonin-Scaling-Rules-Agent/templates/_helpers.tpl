{{/*
Expand the name of the chart.
*/}}
{{- define "Scaling-Rules-Agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | lower | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "Scaling-Rules-Agent.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | lower | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "Scaling-Rules-Agent.name" . }}
{{- $releaseName := .Release.Name | lower }}
{{- if contains $name $releaseName }}
{{- $releaseName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" $releaseName $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "Scaling-Rules-Agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "Scaling-Rules-Agent.labels" -}}
helm.sh/chart: {{ include "Scaling-Rules-Agent.chart" . }}
{{ include "Scaling-Rules-Agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "Scaling-Rules-Agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "Scaling-Rules-Agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "Scaling-Rules-Agent.serviceAccountName" -}}
{{- $serviceAccount := .Values.serviceAccount | default dict -}}
{{- if (default true $serviceAccount.create) }}
{{- default (include "Scaling-Rules-Agent.fullname" .) $serviceAccount.name }}
{{- else }}
{{- default "default" $serviceAccount.name }}
{{- end }}
{{- end }}
