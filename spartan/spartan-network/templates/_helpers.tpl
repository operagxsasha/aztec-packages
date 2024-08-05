{{/*
Expand the name of the chart.
*/}}
{{- define "spartan-network.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spartan-network.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spartan-network.fullname" -}}
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
Common labels
*/}}
{{- define "spartan-network.labels" -}}
helm.sh/chart: {{ include "spartan-network.chart" . }}
{{ include "spartan-network.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spartan-network.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spartan-network.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "spartan-network.ethereumHost" -}}
http://{{ include "spartan-network.fullname" . }}-ethereum.{{ .Release.Namespace }}:{{ .Values.ethereum.service.port }}
{{- end -}}

{{- define "spartan-network.pxeUrl" -}}
http://{{ include "spartan-network.fullname" . }}-pxe.{{ .Release.Namespace }}:{{ .Values.pxe.service.port }}
{{- end -}}