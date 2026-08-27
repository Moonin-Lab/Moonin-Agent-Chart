{{- define "Moonin-Node-Agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" | lower -}}
{{- end -}}

{{- define "Moonin-Node-Agent.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" | lower -}}
{{- else -}}
{{- printf "%s-node-agent" .Release.Name | trunc 63 | trimSuffix "-" | lower -}}
{{- end -}}
{{- end -}}

{{- define "Moonin-Node-Agent.serviceAccountName" -}}
{{- default (include "Moonin-Node-Agent.fullname" .) .Values.serviceAccount.name -}}
{{- end -}}

{{- define "Moonin-Node-Agent.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "Moonin-Node-Agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: node-agent
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
arguz.io/upgradeable: "true"
{{- end -}}

{{- define "Moonin-Node-Agent.annotations" -}}
arguz.io/helm-release: {{ .Release.Name | quote }}
arguz.io/helm-release-namespace: {{ .Release.Namespace | quote }}
{{- end -}}

{{- define "Moonin-Node-Agent.image" -}}
{{- $image := .Values.image | default dict -}}
{{- if $image.digest -}}
{{- printf "%s@%s" $image.repository $image.digest -}}
{{- else -}}
{{- printf "%s:%s" $image.repository (default .Chart.AppVersion $image.tag) -}}
{{- end -}}
{{- end -}}
