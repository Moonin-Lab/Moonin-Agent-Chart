{{/*
Expand the name of the chart.
*/}}
{{- define "Discovery-Agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | lower | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "Discovery-Agent.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | lower | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := include "Discovery-Agent.name" . }}
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
{{- define "Discovery-Agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "Discovery-Agent.labels" -}}
helm.sh/chart: {{ include "Discovery-Agent.chart" . }}
{{ include "Discovery-Agent.selectorLabels" . }}
app.kubernetes.io/component: discovery-agent
arguz.io/upgradeable: "true"
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Metadata used by the agent to identify only resources from its Helm release. */}}
{{- define "Discovery-Agent.annotations" -}}
arguz.io/helm-release: {{ .Release.Name | quote }}
arguz.io/helm-release-namespace: {{ .Release.Namespace | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "Discovery-Agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "Discovery-Agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "Discovery-Agent.serviceAccountName" -}}
{{- $serviceAccount := .Values.serviceAccount | default dict -}}
{{- if (default true $serviceAccount.create) }}
{{- default (include "Discovery-Agent.fullname" .) $serviceAccount.name }}
{{- else }}
{{- default "default" $serviceAccount.name }}
{{- end }}
{{- end }}
